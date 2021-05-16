import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, Index, JoinColumn, ManyToOne, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Product } from "./Product";
import { Transaction } from "./Transaction";
import { Variant } from "./Variant";

@Entity()
@ObjectType()
export class Order extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID!)
    id: number;

    @OneToOne(type => Product, {primary: false})
    @JoinColumn()
    @Field()
    product: Product;

    @OneToOne(type => Variant, {primary: false})
    @JoinColumn()
    @Field()
    variant: Variant;

    @Field()
    @Column()
    quantity: number;

    @Index()
    @ManyToOne(type => Transaction, transaction => transaction.orders, {eager: true})
    transaction: Transaction;

    @CreateDateColumn()
    createdAt: Date;
}