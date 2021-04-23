import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Discount } from "./Discount";
import { Product } from "./Product";

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

    @OneToMany(() => Discount, discount => discount.owner, {nullable: true})
    discounts: Discount[];

    @Column("bool", {default: false})
    confirmed: boolean;

    @CreateDateColumn({name: 'created_at'})
    createdAt: Date;
}