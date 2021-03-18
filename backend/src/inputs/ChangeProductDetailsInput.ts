import { InputType, Field } from "type-graphql";

@InputType()
export class ChangeProductDetailsInput {
  @Field({ nullable: true })
  productname?: string;

  @Field({ nullable: true })
  description?: string;

  @Field({ nullable: true })
  isTaxable?: boolean;

  @Field({ nullable: true })
  photolink?: string;
}