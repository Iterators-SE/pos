import { ID, Field, ObjectType, Int } from "type-graphql";
import { TypeormLoader } from "type-graphql-dataloader";
import { BaseEntity, Index, ManyToOne, ManyToMany, JoinTable, CreateDateColumn, UpdateDateColumn, Column, Entity, PrimaryGeneratedColumn, TableInheritance, ChildEntity } from "typeorm";
import { Product } from './Product';
import { User } from './User';

@ObjectType()
@Entity()
@TableInheritance({column: {type: "varchar", name: "type"}})
export class Discount extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID!)
    id: number;

    @Field()
    @Column()
    description: string;

    @Field(() => User)
    @ManyToOne(() => User, user => user.discounts, {eager: true})
    @TypeormLoader()
    user: User;
    
    @Field()
    @Column({type: "integer"})
    percentage: number;
    
    @Field(() => [Product])
    @ManyToMany(() => Product, product => product.discounts, {nullable: true})
    @JoinTable()
    @TypeormLoader()
    products: Product[];

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}


/**
 * Defines short-term promos, seasonal sales, and holidays
 */
@ObjectType()
@ChildEntity()
export class CustomDiscount extends Discount {
    @Field(() => String, {nullable: true})
    @Column({type: "daterange"})
    inclusiveDates: string;

    @Field(() => String, {nullable: true})
    @Column({type: "time"})
    startTime: string;

    @Field(() => String, {nullable: true})
    @Column({type: "time"})
    endTime: string;
}

/**
 * 
 * DISCOUNT
 * 
 * NAME
 * % / PRICE ?
 * 
 * ENUM / SUBTYPES
 *  HOLIDAY / SEASONAL [END/START]
 *  COUPON ?????
 *  BOGO ?
 * 
 * HOW TO CREATE SUBTYPES USING TYPEORM???
 * TODO: CREATE FKEY_IDX FOR * MODELS/ENTITIES
 *  RATE-LIMITING
 *      EXPRESS
 *      GQL
 *  REDIS
 */