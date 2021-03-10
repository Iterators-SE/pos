import { InputType, Field } from "type-graphql";

@InputType()
export class ChangeUserDetailsInput {
  @Field({nullable: true})
  name: string;

  @Field({nullable: true})
  email: string;
}