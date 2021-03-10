import { buildSchema } from "type-graphql";
import { authChecker } from "../src/authChecker";
import { UserResolver } from "../src/resolvers/UserResolver";

export const createSchema = () => buildSchema({
    resolvers: [UserResolver],
    authChecker,
    authMode: "null"
});
