import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Product } from "./Product";

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

    @OneToMany(() => Product, product => product.user, {nullable: true})
    product: Product[];

    @Column("bool", {default: false})
    confirmed: boolean;
}