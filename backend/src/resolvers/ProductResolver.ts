import { Resolver, Query, Arg, Mutation, Authorized, Ctx } from "type-graphql";
import { ChangeUserDetailsInput } from "../inputs/ChangeUserDetailsInput";
import { Product } from "../models/Product";
import { Context } from "../types/context";
require('dotenv').config()

@Resolver(of => Product)
export class ProductResolver {
    @Mutation(() => Boolean, { nullable: true })

    async addProduct(@Ctx() ctx: Context, @Arg("productName") productname: string, @Arg("description") description: string, @Arg("isTaxable") taxable: boolean) {
        await Product.create({
            productname,
            description,
            ownerid: ctx.currentUser.id,
            taxable,
            photolink: "http://something/1234" // will work on this at a later time
        }).save();

        return true;
    }
    
    @Query(() => Product, {nullable: true})
    async getProducts(@Ctx() ctx: Context){
        const products = await Product.find({ where: { ownerid: ctx.currentUser.id } });
        return products;
    }

    @Query(() => Product, {nullable: true})
    async getProductDetails(@Ctx() ctx: Context, @Arg("productId") productID: number){
        const productDetails = await Product.findOne({ where: { ownerid: ctx.currentUser.id, id: productID  } });
        if (!productDetails) throw new Error("Product doesn't exist!");
        return productDetails;
    }

}