import { Resolver, Query, Arg, Mutation, Authorized, Ctx } from "type-graphql";
import { ChangeProductDetailsInput } from "../inputs/ChangeProductDetailsInput";
import { Product } from "../models/Product";
import { User } from "../models/User";
import { Context } from "../types/context";
require('dotenv').config()

@Resolver(of => Product)
export class ProductResolver {
    @Authorized()
    @Mutation(() => Boolean, { nullable: true })

    async addProduct(@Ctx() ctx: Context, @Arg("productname") productname: string, @Arg("description") description: string, @Arg("taxable") taxable: boolean) {
        const user = await User.findOne({id: ctx.currentUser.id});

        await Product.create({
            productname,
            description,
            owner: user,
            taxable,
            photolink: "http://something/1234" // will work on this at a later time
        }).save();

        return true;
    }

    @Authorized()
    @Mutation(() => Boolean, { nullable: true })
    async deleteProduct(@Ctx() ctx: Context, @Arg("productId") productId: number) {
        const product = await Product.findOne({ where: { owner: ctx.currentUser.id, id: productId }, relations: ["user"]  });
        if (!product) throw new Error("Deletion not possible! Product doesn't exist!")
        await product.remove()
        return true;
    }

    @Authorized()
    @Mutation(() => Product)
    async changeProductDetails(@Ctx() ctx: Context, @Arg("productId") productId: number, @Arg("data") data: ChangeProductDetailsInput) {
        const product = await Product.findOne({ where: { id: productId, owner: ctx.currentUser.id } });
        if (!product) throw new Error("Can't update a non existent product!");
        Object.assign(product, data);
        await product.save();
        return product;
    }

    @Authorized()
    @Query(() => [Product], { nullable: true })
    async getProducts(@Ctx() ctx: Context) {
        const products = await Product.find({ where: { owner: ctx.currentUser.id } });
        return products;
    }

    @Authorized()
    @Query(() => Product, { nullable: true })
    async getProductDetails(@Ctx() ctx: Context, @Arg("productId") productId: number) {
        const productDetails = await Product.findOne({ where: { owner: ctx.currentUser.id, id: productId } });
        if (!productDetails) throw new Error("Product doesn't exist!");

        console.log(productDetails)
        return productDetails;
    }
}