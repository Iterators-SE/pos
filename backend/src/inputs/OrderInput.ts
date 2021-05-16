// import { Min } from "class-validator";
import { InputType, Field, Int } from "type-graphql";

@InputType()
export class OrderInput {
    @Field(() => [Int])
    productIds: number[];

    @Field(() => [Int])
    variantIds: number[];

    @Field(() => [Int])
    // @Min(1, {message: "Quantity must be at least 1."})
    quantity: number[];
}