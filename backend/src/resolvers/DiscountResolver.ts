import { Resolver, Query, Arg, Mutation, Authorized, Ctx } from "type-graphql";
import { CustomDiscountInput, DiscountInput } from "../inputs/DiscountInput";
import { Discount } from "../models/Discount";
import { Product } from "../models/Product";
import { User } from "../models/User";
import { Context } from "../types/context";
require('dotenv').config()

@Resolver(of => Discount)
export class DiscountResolver {
    @Authorized()
    @Query(() => Discount, { nullable: true })
    async getDiscount(@Arg("id") id: number) {
        const discount = await Discount.findOne({ where: { id: id }, relations: ["products"] });
        return discount;
    }

    @Authorized()
    @Query(() => [Discount], { nullable: true })
    async getDiscounts(@Ctx() ctx: Context) {
        const user = await User.findOne(ctx.currentUser.id);
        const discount = await Discount.find({ where: { user: user }, relations: ["products"]});
        return discount;
    }

    @Authorized()
    @Mutation(() => Discount, { nullable: true })
    async createGenericDiscount(@Ctx() ctx: Context, @Arg("input") input: DiscountInput, args = {}) {
        const productList = await Product.findByIds(input.products, { where: { user: ctx.currentUser.id } });

        // revisit logic
        if (productList.length !== input.products.length) {
            throw Error('Unauthorized operation, please recheck applicable products.')
        }

        // Replace base user location logic in case of subuser implementation
        const user = await User.findOne(ctx.currentUser.id);

        const result = await Discount.create({
            description: input.description,
            percentage: input.percentage,
            user: user,
            products: productList,
            ...args
        }).save()

        return result;
    }

    @Authorized()
    @Mutation(() => Discount, { nullable: true })
    async createCustomDiscount(@Ctx() ctx: Context, @Arg("input") input: DiscountInput, @Arg("custom") custom: CustomDiscountInput) {
        const discount = await this.createGenericDiscount(ctx, input, {
            endTime: custom.endTime,
            startTime: custom.startTime,
            inclusiveDates: `[${custom.inclusiveDates.join(', ')}]`
        });

        return discount;
    }

    @Authorized()
    @Mutation(() => Discount)
    async updateGenericDiscount(@Arg("id") id: number, @Arg("input") input: DiscountInput, args = {}) {
        const discount = await Discount.findOne(id);

        if (!discount) throw new Error(`Discount with id of ${id} not found.`)

        Object.assign(discount, {
            description: input.description ?? discount.description,
            percentage: input.percentage ?? discount.percentage,
            products: await Product.findByIds(input.products) ?? discount.products,
            ...args
        })

        return await discount.save();
    }

    @Authorized()
    @Mutation(() => Discount, { nullable: true })
    async updateCustomDiscount(@Arg("id") id: number, @Arg("input") input: DiscountInput, @Arg("custom") custom: CustomDiscountInput) {
        const discount = await this.updateGenericDiscount(id, input, {
            endTime: custom.endTime,
            startTime: custom.startTime,
            inclusiveDates: `[${custom.inclusiveDates.join(', ')}]`
        });

        return discount;
    }

    @Authorized()
    @Mutation(() => Discount, {nullable: true})
    async deleteDiscount(@Arg("id") id: number) {
        const discount = await Discount.findOne(id);
        return await discount?.remove();
    }
}