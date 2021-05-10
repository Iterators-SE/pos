import { Arg, Authorized, Ctx, Mutation, Query, Resolver } from "type-graphql";
import { Product } from "../models/Product";
import { User } from "../models/User";
import { Variant } from "../models/Variant";
import { Context } from "../types/context";
import { ChangeVariantInput} from '../inputs/ChangeVariantsInput'

@Resolver(of => Variant)
export class VariantResolver{
    @Authorized()
    @Mutation(() => Boolean, {nullable: true})
    async addVariant(@Ctx() ctx: Context, @Arg("variantname") variantname: string, @Arg('productId') productId: number, @Arg('quantity') quantity: number, @Arg('price') price: Number){
        const product = await Product.findOne({id: productId});

        await Variant.create({
            variantname,
            product: product,
            quantity,
            price,
        }).save();
        return true;
    }

    @Authorized()
    @Mutation(() => Boolean, {nullable: true})
    async removeVariant(@Arg('variantid') variantid : number){
        const variant = await Variant.findOne({where: {variantid: variantid}})
        if (!variant) throw new Error("Variant does not exist!")
        await variant.remove();
        return true;
    }

    @Authorized()
    @Mutation(() => Boolean, {nullable: true})
    async deleteAllVariants(@Arg('productId') productId : number){

        const parentProduct = await Product.findOne({where: {id: productId}})
        const variant = await Variant.find({where: {product: parentProduct}})
        if (!variant) throw new Error("Variant does not exist!")
        console.log(variant);
        await variant.forEach((value) => value.remove());
        return true;
    }

    @Authorized()
    @Mutation(() => Boolean ,{nullable: true})
    async editVariant(@Ctx() ctx: Context, @Arg('variantid') variantid: number, @Arg('data') data: ChangeVariantInput){
        const variant = await Variant.findOne({where: {variantid: variantid}})
        if (!variant) throw new Error("Variant does not exist")
        console.log(data);
        console.log(variant);
        Object.assign(variant, data);
        variant.save();
        return true
    }

    @Authorized()
    @Query(() => [Variant], {nullable: true})
    async getVariants(@Ctx() ctx: Context, @Arg('productId') productId: Number){
        const parentProduct = await Product.findOne({where: {id: productId}});
        const variants = await Variant.find({where: {product: parentProduct}});

        return variants;
    }
}