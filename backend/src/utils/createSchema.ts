import { buildSchema } from "type-graphql";
import { authChecker } from "./authChecker";
import { UserResolver } from "../resolvers/UserResolver";
import { LoginResolver } from "../resolvers/LoginResolver";
import { SignupResolver } from "../resolvers/SignupResolver";

export const createSchema = () => buildSchema({
    resolvers: [UserResolver, LoginResolver, SignupResolver],
    authChecker,
    authMode: "null",
});
