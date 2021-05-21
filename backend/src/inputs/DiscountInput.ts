import { IsDate, IsMilitaryTime, IsNotEmpty, Max, Min } from "class-validator";
import { InputType, Field, Int } from "type-graphql";

@InputType()
export class DiscountInput {
    @Field()
    @IsNotEmpty()
    description: string;

    @Field()
    @Min(0)
    @Max(100)
    percentage: number;

    @Field(() => [Int])
    products: number[];
}

@InputType()
export class CustomDiscountInput {
    @Field(() => [String])
    inclusiveDates: string[];

    @Field()
    @IsMilitaryTime()
    startTime: string;

    @Field()
    @IsMilitaryTime()
    endTime: string;
}