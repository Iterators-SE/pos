import { hash } from "bcrypt";
import { sign } from "jsonwebtoken";
import { Resolver, Mutation, Ctx, Arg } from "type-graphql";
import { User } from "../models/User";
import { Context } from "../types/context";

@Resolver()
export class SignupResolver {
    @Mutation(() => Boolean, { nullable: true })
    async signup(@Ctx() ctx: Context, @Arg("name") name: string, @Arg("email") email: string, @Arg("password") password: string) {
        if (ctx.currentUser) throw new Error("Already logged in.");

        const user = await User.findOne({ where: { email } })
        if (user) throw new Error('Email has already been taken.')

        const hashedPassword = await hash(password, 10);

        await User.create({
            name,
            email,
            password: hashedPassword
        }).save();

        // confirm email here

        return true;
    }
}