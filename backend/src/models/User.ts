import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Discount } from "./Discount";
import { Product } from "./Product";
import { Transaction } from "./Transaction";

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

    @OneToMany(() => Transaction, transaction => transaction.owner, {nullable: true})
    transactions: Transaction[];

    @OneToMany(() => Discount, discount => discount.user, {nullable: true})
    discounts: Discount[];

    @Column("bool", {default: false})
    confirmed: boolean;

    @CreateDateColumn({name: 'created_at'})
    createdAt: Date;

    @Column({default: "Thank you!"})
    receiptMessage: string;

    @Column({default: "Earth"})
    address: string;
}