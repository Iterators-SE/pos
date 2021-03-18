import { Length } from "class-validator";
import { InputType, Field } from "type-graphql";
import { isEmailAlreadyExist } from "../validator/isEmailAlreadyExist";

@InputType()
export class SignupInput {
    @Field()
    @Length(1, 50, {message: "Business name must be between 1 and 50 characters."})
    name: string;

    @Field()
    @isEmailAlreadyExist({message: "Email already in use."})
    email: string;

    @Field()
    @Length(8, 100, {message: "Password must be at least 8 characters"})
    password: string;
}