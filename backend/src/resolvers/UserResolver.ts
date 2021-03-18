import { Resolver, Query, Arg, Mutation, Authorized, Ctx } from "type-graphql";
import { ChangeUserDetailsInput } from "../inputs/ChangeUserDetailsInput";
import { User } from "../models/User";
import { Context } from "../types/context";
require('dotenv').config()

@Resolver(() => User)
export class UserResolver {
    @Authorized()
    @Mutation(() => User, {nullable: true})
    async changeUserDetails(@Ctx() ctx: Context, @Arg("data") data: ChangeUserDetailsInput) {
        const user = await User.findOne({ where: { id: ctx.currentUser.id } });

        if (!user) throw new Error("User does not exist!");
        Object.assign(user, data);
        await user.save();
        return user;
    }

    @Query(() => User, {nullable: true})
    async getUserDetails(@Ctx() ctx: Context) {
        if (!ctx.currentUser) {
            throw Error("Unable to get user details.") 
        }

        const user = await User.findOne({ where: { id: ctx.currentUser.id } });
        return user;
    }
}