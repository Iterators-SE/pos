import { createConnection } from "typeorm";
import express = require('express');
import { ApolloServer } from 'apollo-server-express';
import jwt = require('express-jwt');
import { createSchema } from "./utils/createSchema";

require('dotenv').config();

const startServer = async () => {
  const app = express()
  const port = Number(process.env.PORT) || 5000;
  const connection = await createConnection()

  const authMiddleware = jwt({
    secret: process.env.JWT_SECRET as string,
    credentialsRequired: false,
    algorithms: [process.env.JWT_ALGORITHM as string]
  });

  const schema = await createSchema();

  const server = new ApolloServer({ 
    schema, 
    context: ({req, res}) => ({
      req, 
      currentUser: req.user,
      res
    })
  });

  app.use(authMiddleware, (err: any, req: any, res: any, next: any)=> {
    if(err.code === "invalid_token") return next();
    return next(err);
  });

  server.applyMiddleware({app});

  app.listen({ port }, () => {
    console.log(`Server is up on http://localhost:${port}${server.graphqlPath}`);
  });
}

startServer();