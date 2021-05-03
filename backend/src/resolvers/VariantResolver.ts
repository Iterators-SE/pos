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
    @Mutation(() => Boolean ,{nullable: true})
    async editVariant(@Ctx() ctx: Context, @Arg('variantid') variantid: number, @Arg('data') data: ChangeVariantInput){
        const variant = await Variant.findOne({where: {variantid: variantid}})
        if (!variant) throw new Error("Variant does not exist")
        Object.assign(variant, data);
        return true
    }

    @Authorized()
    @Query(() => [Variant], {nullable: true})
    async getVariants(@Ctx() ctx: Context, @Arg('product') product: Number){
        const variants = await Variant.find({where: {productid: product}})

        return variants
    }
}