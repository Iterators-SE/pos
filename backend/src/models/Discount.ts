import { ID, Field, ObjectType, Int } from "type-graphql";
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
    owner: User;
    
    @Field()
    @Column({type: "integer"})
    percentage: number;
    
    @Field(() => [Int])
    @ManyToMany(() => Product, product => product.discounts, {nullable: true})
    @JoinTable()
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
    @Field()
    @Column({type: "daterange"})
    inclusiveDates: string;

    @Field()
    @Column({type: "time"})
    startTime: string;

    @Field()
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