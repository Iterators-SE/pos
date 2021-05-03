import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Product } from "./Product"

@Entity()
@ObjectType()
export class Variant extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID)
    variantid: number;

    @Column()
    @Field()
    variantname: String;

    @Column()
    @Field()
    price: Number;

    @ManyToOne(() => Product, product => product.variant, {eager : true})
    product : Product;

    @Column()
    @Field()
    quantity: Number;

}
