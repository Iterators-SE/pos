import { InputType, Field } from "type-graphql";

@InputType()
export class ChangeUserDetailsInput {
  @Field()
  name: string;

  @Field()
  email: string;
}