import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
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

    @Column()
    @Field()
    taxable: boolean;
}