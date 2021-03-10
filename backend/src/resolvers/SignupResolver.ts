import { hash } from "bcrypt";
import { sign } from "jsonwebtoken";
import { Resolver, Mutation, Ctx, Arg } from "type-graphql";
import { User } from "../models/User";
import { Context } from "../types/context";

@Resolver()
export class SignupResolver {
    @Mutation(() => String, {nullable: true})
    async signup(@Ctx() ctx: Context, @Arg("name") name: string, @Arg("email") email: string, @Arg("password") password: string) {
        if (ctx.currentUser) throw new Error("Already logged in.");

        const user = await User.findOne({ where: { email } })
        if (user) throw new Error('User with that email exists.')

        const hashedPassword = await hash(password, 10);

        const newUser = await User.create({
            name,
            email,
            password: hashedPassword
        }).save();

        // confirm email here

        // TODO [2021-03-11]: extract tokenizing logic
        return sign({
            id: newUser.id,
        }, process.env.JWT_SECRET as string, { expiresIn: '15m' })
    }
}