import { InputType, Field } from "type-graphql";

@InputType()
export class ChangeTaxDetailsInput {
  @Field({ nullable: true })
  name?: string;

  @Field({ nullable: true })
  isSelected?: boolean;

  @Field({ nullable: true })
  percentage?: number;
}