import { buildSchema } from "type-graphql";
import { authChecker } from "./authChecker";
import { UserResolver } from "../src/resolvers/UserResolver";

export const createSchema = () => buildSchema({
    resolvers: [UserResolver],
    authChecker,
    authMode: "null"
});
