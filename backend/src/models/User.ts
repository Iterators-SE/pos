import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Discount } from "./Discount";
import { Product } from "./Product";
import { Tax } from "./Tax";
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

    @OneToMany(() => Tax, tax => tax.user, {nullable: true})
    tax: Tax[];

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

    @Field()
    @Column({default: "Thank you!"})
    receiptMessage: string;

    @Field()
    @Column({default: "Earth"})
    address: string;
}