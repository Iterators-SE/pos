import { InputType, Field } from "type-graphql";

@InputType()
export class ChangeVariantInput {
  @Field({ nullable: true })
  variantname?: string;

  @Field({ nullable: true })
  quantity?: number;

  @Field({ nullable: true })
  price?: number;
}