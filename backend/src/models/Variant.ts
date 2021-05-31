import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Product } from "./Product"

@Entity()
@ObjectType()
export class Variant extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID)
    id: number;

    @Column()
    @Field()
    name: string;

    @Column()
    @Field()
    price: number;

    @ManyToOne(() => Product, product => product.variant)
    product : Product;

    @Column()
    @Field()
    quantity: number;
}
