import { Connection } from "typeorm";
import * as faker from "faker";
import { testConnection } from "../test-utils/testConnection";
import { graphql} from "graphql";
import { createSchema } from "../utils/createSchema";
import { User } from "../models/User";

let connection: Connection;

beforeAll(async () =>  {
    connection = await testConnection();
});

afterAll(async () => {
    await connection.close();
});

const signupMutation = `
mutation RegisterUser($data: SignupInput!) {
    signup(data: $data)
}
`;

describe('Signup', () => {
    test("Creates a user", async () => {
        const user = {
            name: faker.company.companyName(),
            email: faker.internet.email(),
            password: faker.internet.password()
        }

        let schema = await createSchema();

        const response = await graphql({
            schema,
            source: signupMutation,
            variableValues: {
                data: user
            },
            contextValue: {
                req: {},
                res: {},
                currentUser: null
            }
        });

        expect(response).toMatchObject({
            data: {
                signup: true
            }
        });

        const dbUser = await User.findOne({ where: { email: user.email } });
        expect(dbUser).toBeDefined();
        expect(dbUser!.confirmed).toBeFalsy();
        expect(dbUser!.name).toBe(user.name);
    }, 20000);
})
