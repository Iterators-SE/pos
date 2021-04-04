import { createConnection } from "typeorm";
import * as dotenv from "dotenv";

dotenv.config();

export const testConnection = (drop: boolean = false) => {
    return createConnection({
        type: "postgres",
        username: process.env.TYPEORM_USERNAME,
        password: process.env.TYPEORM_PASSWORD,
        database: "pos_test",
        synchronize: drop,
        dropSchema: drop,
        entities: [__dirname + "/../models/*.ts"]
    });
}