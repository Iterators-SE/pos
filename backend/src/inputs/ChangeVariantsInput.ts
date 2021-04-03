import { InputType, Field } from "type-graphql";

@InputType()
export class ChangeVariantInput {
  @Field({ nullable: true })
  variantname?: string;

  @Field({ nullable: true })
  quantity?: string;

  @Field({ nullable: true })
  price?: number;
}