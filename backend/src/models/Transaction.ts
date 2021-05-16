import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, CreateDateColumn, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Order } from "./Order";
import { User } from "./User";

@Entity()
@ObjectType()
export class Transaction extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID!)
    id: number;

    @ManyToOne(type => User, user => user.transactions)
    owner: User;
    
    @Field(() => [Order], {nullable: true})
    @OneToMany(type => Order, order => order.transaction)
    orders: Order[];

    @Field(() => Date)
    @CreateDateColumn()
    createdAt: Date;
}