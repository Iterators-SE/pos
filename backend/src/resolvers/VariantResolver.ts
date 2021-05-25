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
    async addVariant(@Ctx() ctx: Context, @Arg("name") name: string, @Arg('productId') productId: number, @Arg('quantity') quantity: number, @Arg('price') price: number){
        const product = await Product.findOne({id: productId});

        await Variant.create({
            name,
            product: product,
            quantity,
            price,
        }).save();
        return true;
    }

    @Authorized()
    @Mutation(() => Boolean, {nullable: true})
    async deleteVariant(@Arg('variantId') variantId : number){
        const variant = await Variant.findOne({where: {id: variantId}})
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
    async editVariant(@Ctx() ctx: Context, @Arg('variantId') variantId: number, @Arg('data') data: ChangeVariantInput){
        const variant = await Variant.findOne({where: {id: variantId}})
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