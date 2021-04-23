import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Discount } from "./Discount";
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
    productname: string;

    @Field(() => User)
    @ManyToOne(() => User, user => user.product, {eager: true})
    user : User;
    
    @OneToMany(() => Variant, variant => variant.product, {nullable: true})
    variant: Variant[];

    @Column()
    @Field()
    description: string;

    @Column()
    @Field()
    photolink: string;

    @ManyToMany(() => Discount, discount => discount.products)
    discounts: Discount[]

    @Column()
    @Field()
    taxable: boolean;
}