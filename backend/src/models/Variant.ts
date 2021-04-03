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

    @ManyToOne(() => Product, product => product.id, {eager : true})
    product : Number

    @Column()
    @Field()
    quantity: Number;

}
