import {sign} from "jsonwebtoken";
import * as dotenv from "dotenv";

dotenv.config();

export const createConfirmationUrl = async (userId: number) => {
    const body = {
        type: 'CONFIRM',
        id: userId
    }

    const token = sign(body,  process.env.JWT_SECRET as string, {expiresIn: "1d"});

    return `http://localhost:5000/confirm/${token}`;
}