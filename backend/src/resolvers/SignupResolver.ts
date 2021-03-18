import { hash } from "bcrypt";
import { Resolver, Mutation, Ctx, Arg } from "type-graphql";
import { SignupInput } from "../inputs/SignupInput";
import { User } from "../models/User";
import { Context } from "../types/context";
import { createConfirmationUrl } from "../utils/createConfirmationUrl";
import { sendEmail } from "../utils/sendEmail";

@Resolver()
export class SignupResolver {
    @Mutation(() => Boolean, { nullable: true })
    async signup(@Ctx() ctx: Context, @Arg("data") {name, email, password}: SignupInput) {
        if (ctx.currentUser) throw new Error("Already logged in.");

        const hashedPassword = await hash(password, 10);

        const user = await User.create({
            name,
            email,
            password: hashedPassword
        }).save();

        await sendEmail(name, email, await createConfirmationUrl(user.id), {confirm: true});

        return true;
    }
}