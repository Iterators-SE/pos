import { Field, ID, ObjectType } from "type-graphql";
import { TypeormLoader } from "type-graphql-dataloader";
import { BaseEntity, Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Order } from "./Order";
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
    @TypeormLoader()
    product : Product;
    
    @OneToMany(() => Order, order => order.variant)
    @TypeormLoader()
    order: Order[];

    @Column()
    @Field()
    quantity: number;
}
