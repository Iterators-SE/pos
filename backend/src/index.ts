import { createConnection } from "typeorm";
import express = require('express');
import { ApolloServer } from 'apollo-server-express';
import jwt = require('express-jwt');
import {verify} from "jsonwebtoken";
import { createSchema } from "./utils/createSchema";
import { Token } from "./types/token";
import { User } from "./models/User";
import queryComplexity, {fieldExtensionsEstimator, simpleEstimator} from "graphql-query-complexity";
// import rateLimit =  require('express-rate-limit');
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
    }),
    // validationRules: [
    //   queryComplexity({
    //     maximumComplexity: 45,
    //     variables: {},
    //     onComplete: (complexity: number) => {
    //       console.log(`Query Complexity: ${complexity}`)
    //     },
    //     estimators: [
    //       fieldExtensionsEstimator(),
    //       simpleEstimator({
    //         defaultComplexity: 1
    //       })
    //     ]
    //   }) as any
    // ],
    // formatError: (err) : Error => {
    //   if (err.message.startsWith('Database Error: ')) {
    //     return new Error('Internal server error');
    //   }
    //   if (err.message.startsWith('Argument Validation')) {
    //     return new Error('Something went wrong with validation :( Would you like to try again?');
    //   }

    //   return err;
    // }
  });

  app.use(authMiddleware, (err: any, req: any, res: any, next: any)=> {
    if(err.code === "invalid_token") return next();
    return next(err);
  });

  // app.use(rateLimit({
  //   windowMs: 1000,
  //   max: 1, // limit each IP to 100 requests per windowMs
  //   message: "Too many requests created from this IP, please try again after a minute."
  // }));


  app.use(express.json());
  app.use(express.urlencoded({extended: false}));

  app.get('/confirm/:token', async (req, res) => {
    const token = req.params.token;

    return verify(token,  process.env.JWT_SECRET as string, {ignoreExpiration: false}, (err, decoded) => {
      if (err) return res.status(400).json({message: "Could not confirm email - please request a new link"});

      const {id} = decoded as Token;

      return connection.getRepository(User).update({id}, {confirmed: true}).then((_) => {
        return res.status(200).json({message: "Email successfully confirmed!"})
      }).catch(() => {
        return res.status(500).json({message: "Could not confirm email - please try again"});
      });
    });
  });

  server.applyMiddleware({app});

  app.listen({ port }, () => {
    console.log(`Server is up on http://localhost:${port}${server.graphqlPath}`);
  }).on('close', () => {
    connection.close();
  });
}

startServer();