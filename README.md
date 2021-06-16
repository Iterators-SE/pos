# pos

A Point-of-Sale system by the Iterators which utilizes aspects of Clean Architecture (inspired by Robert Martin) for code organization in the Futter frontend and has a Postgres-Express-GraphQL backend.

## Setup
1. Create local `pos` database
1. Go to `/backend`
1. Create `.env` file with the following keys: `JWT_SECRET`, `PORT`, `TYPEORM_CONNECTION` `TYPEORM_HOST = localhost`, `TYPEORM_USERNAME` `TYPEORM_PASSWORD`, `TYPEORM_DATABASE` `TYPEORM_PORT = 5432`, `TYPEORM_SYNCHRONIZE = true`, `TYPEORM_LOGGING = true`,`TYPEORM_ENTITIES = ./src/models/*.ts`, `JWT_ALGORITHM`, `NODEMAILER_USER`, and `NODEMAILER_PASSWORD`