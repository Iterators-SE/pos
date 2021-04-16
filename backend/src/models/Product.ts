import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, ManyToOne, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./User";

@Entity()
@ObjectType()
export class Product extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID)
    id: number;

    @Column({unique: true})
    @Field()
    productname: string;

    @Field(() => User)
    @ManyToOne(() => User, owner => owner.product, {eager: true})
    user : User;

    @Column()
    @Field()
    description: string;

    @Column()
    @Field()
    photolink: string;

    @Column()
    @Field()
    taxable: boolean;
}