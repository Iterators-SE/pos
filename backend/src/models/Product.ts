import { Field, ID, ObjectType } from "type-graphql";
import { TypeormLoader } from "type-graphql-dataloader";
import { BaseEntity, Column, Entity, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Discount } from "./Discount";
import { Order } from "./Order";
import { User } from "./User";
import { Variant } from './Variant';

@Entity()
@ObjectType()
export class Product extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID)
    id: number;

    @Column()
    @Field()
    name: string;

    @Field(() => User)
    @ManyToOne(() => User, user => user.product, {eager: true})
    @TypeormLoader()
    user : User;
    
    @Field(() => [Variant])
    @OneToMany(() => Variant, variant => variant.product, {eager: true})
    @TypeormLoader()
    variant: Variant[];

    @OneToMany(() => Order, order => order.product)
    @TypeormLoader()
    order: Order[];

    @Column()
    @Field()
    description: string;

    @Column()
    @Field()
    photoLink: string;

    @ManyToMany(() => Discount, discount => discount.products)
    @TypeormLoader()
    discounts: Discount[]

    @Column()
    @Field()
    isTaxable: boolean;
}