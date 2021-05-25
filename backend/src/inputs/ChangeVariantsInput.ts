import { InputType, Field } from "type-graphql";

@InputType()
export class ChangeVariantInput {
  @Field({ nullable: true })
  name?: string;

  @Field({ nullable: true })
  quantity?: number;

  @Field({ nullable: true })
  price?: number;
}