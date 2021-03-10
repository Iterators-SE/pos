import { Resolver, Query, Arg, Mutation } from "type-graphql";
import { ChangeUserDetailsInput } from "../inputs/ChangeUserDetailsInput";
import { User } from "../models/User";
import { compare, hash } from "bcrypt";
import { sign } from "jsonwebtoken";
require('dotenv').config()

@Resolver(of => User)
export class UserResolver {
    @Query(() => User)
    async getUser(@Arg("id") id: number) {
        const user = await User.findOne({ where: { id } });
        if (user) {
            return user;
        }

        throw Error("No user found")
    }

    @Mutation(() => User)
    async changeUserDetails(@Arg("id") id: string, @Arg("data") data: ChangeUserDetailsInput) {
        const user = await User.findOne({ where: { id } });

        if (!user) throw new Error("User does not exist!");
        Object.assign(user, data);
        await user.save();
        return user;
    }

        // TODO [2021-03-11]: Access context
    @Query(() => String)
    async login( @Arg("email") email: string, @Arg("password") password: string) {
        // check that user is not already logged in
        // if (context) throw new Error("Already logged in.");
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
    async signup(@Arg("name") name: string, @Arg("email") email: string, @Arg("password") password: string) {
        // check if user is logged in
        // if (context) throw new Error("Already logged in.");
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