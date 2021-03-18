import { compare } from "bcrypt";
import jwt = require("express-jwt");
import { sign, decode } from "jsonwebtoken";
import { Arg, Ctx, Mutation, Resolver } from "type-graphql";
import { User } from "../models/User";
import { Context } from "../types/context";
import { Token } from "../types/token";

@Resolver()
export class LoginResolver {
    @Mutation(() => String, {nullable: true})
    async login(@Ctx() ctx: Context, @Arg("email") email: string, @Arg("password") password: string) {
        if (ctx.currentUser) throw new Error("Already logged in.");
        const user = await User.findOne({ where: { email } })

        if (!user) throw new Error('No user with that email')
        const valid = await compare(password, user.password)

        if (!valid) throw new Error('Incorrect password');

        if (!user.confirmed) {
            throw new Error("Please validate your email");
        }

        const refreshToken = sign({
            id: user.id,
        }, process.env.JWT_SECRET as string, { expiresIn: '15m' });

        ctx.currentUser = decode(refreshToken) as Token;
        
        return refreshToken;
    }
}