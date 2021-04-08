import { buildSchema } from "type-graphql";
import { authChecker } from "./authChecker";
import { UserResolver } from "../resolvers/UserResolver";
import { LoginResolver } from "../resolvers/LoginResolver";
import { SignupResolver } from "../resolvers/SignupResolver";
import { ProductResolver } from "../resolvers/ProductResolver";
import { VariantResolver } from "../resolvers/VariantResolver"

export const createSchema = () => buildSchema({
    resolvers: [UserResolver, LoginResolver, SignupResolver, ProductResolver, VariantResolver],
    authChecker,
    authMode: "null",
});
