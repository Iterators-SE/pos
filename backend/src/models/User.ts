import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, PrimaryGeneratedColumn } from "typeorm";

// TODO [2021-03-12]: Add count
@Entity()
@ObjectType()
export class User extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID)
    id: number;

    @Column()
    @Field()
    name: string;

    @Field()
    @Column({unique: true})
    email: string;

    @Column()
    password: string;

    @Column("bool", {default: false})
    confirmed: boolean;
}