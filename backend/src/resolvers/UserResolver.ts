import { Resolver, Query, Arg, Mutation, Authorized, Ctx } from "type-graphql";
import { ChangeUserDetailsInput } from "../inputs/ChangeUserDetailsInput";
import { User } from "../models/User";
import { compare, hash } from "bcrypt";
import { sign } from "jsonwebtoken";
import { Context } from "../types/context";
require('dotenv').config()

@Resolver(of => User)
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

    // TODO [2021-03-11]: Access context  
    @Query(() => String)
    async login(@Ctx() ctx: Context, @Arg("email") email: string, @Arg("password") password: string) {
        if (ctx.currentUser) throw new Error("Already logged in.");
        const user = await User.findOne({ where: { email } })

        if (!user) throw new Error('No user with that email')
        const valid = await compare(password, user.password)

        if (!valid) throw new Error('Incorrect password');

        const refreshToken = sign({
            id: user.id,
        }, process.env.JWT_SECRET as string, { expiresIn: '15m' });

        return refreshToken;
    }

    // TODO [2021-03-11]: Access context
    @Query(() => String)
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

        // TODO [2021-03-11]: extract tokenizing logic
        return sign({
            id: newUser.id,
        }, process.env.JWT_SECRET as string, { expiresIn: '15m' })
    }

}