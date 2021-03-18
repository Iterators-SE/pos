import { compare } from "bcrypt";
import { sign } from "jsonwebtoken";
import { Arg, Ctx, Mutation, Resolver } from "type-graphql";
import { User } from "../models/User";
import { Context } from "../types/context";

@Resolver()
export class LoginResolver {
    @Mutation(() => String, {nullable: true})
    async login(@Ctx() ctx: Context, @Arg("email") email: string, @Arg("password") password: string) {
        if (ctx.currentUser) throw new Error("Already logged in.");
        const user = await User.findOne({ where: { email } })

        if (!user) throw new Error('No user with that email')
        const valid = await compare(password, user.password)

        if (!valid) throw new Error('Incorrect password');

        // add user confirmation

        const refreshToken = sign({
            id: user.id,
        }, process.env.JWT_SECRET as string, { expiresIn: '15m' });
        
        
        return refreshToken;
    }
}