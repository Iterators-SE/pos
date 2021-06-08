import { Field, ID, ObjectType } from "type-graphql";
import { TypeormLoader } from "type-graphql-dataloader";
import { BaseEntity, Column, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Product } from "./Product";
import { Transaction } from "./Transaction";
import { Variant } from "./Variant";

@Entity()
@ObjectType()
export class Order extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID!)
    id: number;

    @Field(type => Product, {nullable: true})
    @ManyToOne(() => Product, product => product.order, {cascade: true})
    @TypeormLoader()
    product : Product;
    
    @Field(type => Variant, {nullable: true})
    @ManyToOne(() => Variant, variant => variant.order, {cascade: true})
    @TypeormLoader()
    variant: Variant;

    @Field()
    @Column()
    quantity: number;

    @ManyToOne(type => Transaction, transaction => transaction.orders, {eager: true})
    @TypeormLoader()
    transaction: Transaction;

    @CreateDateColumn()
    createdAt: Date;
}