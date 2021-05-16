import { buildSchema } from "type-graphql";
import { authChecker } from "./authChecker";
import { UserResolver } from "../resolvers/UserResolver";
import { LoginResolver } from "../resolvers/LoginResolver";
import { SignupResolver } from "../resolvers/SignupResolver";
import { ProductResolver } from "../resolvers/ProductResolver";
import { VariantResolver } from "../resolvers/VariantResolver"
import { DiscountResolver } from "../resolvers/DiscountResolver";
import { TransactionResolver } from "../resolvers/TransactionResolver";

export const createSchema = () => buildSchema({
    resolvers: [DiscountResolver, UserResolver, LoginResolver, SignupResolver, ProductResolver, VariantResolver, TransactionResolver],
    authChecker,
    authMode: "null",
});
