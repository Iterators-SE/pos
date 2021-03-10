import { Request, Response } from "express";
import { Token } from "./token";

export interface Context {
    req: Request;
    res: Response;
    currentUser: Token;
}