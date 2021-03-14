# pos

A point-of-sale system by the Iterators

## Setup
1. Create local `pos` database
1. Go to `/backend`
1. Create `.env` file with the following keys: `JWT_SECRET`, `PORT`, `TYPEORM_CONNECTION` `TYPEORM_HOST = localhost`, `TYPEORM_USERNAME` `TYPEORM_PASSWORD`, `TYPEORM_DATABASE` `TYPEORM_PORT = 5432`, `TYPEORM_SYNCHRONIZE = true`, `TYPEORM_LOGGING = true`,`TYPEORM_ENTITIES = ./src/models/*.ts`, `JWT_ALGORITHM`