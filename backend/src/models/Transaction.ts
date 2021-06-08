import { Field, ID, ObjectType } from "type-graphql";
import { TypeormLoader } from "type-graphql-dataloader";
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
    @TypeormLoader()
    owner: User;
    
    @Field(() => [Order], {nullable: true})
    @OneToMany(type => Order, order => order.transaction, {cascade: true})
    @TypeormLoader()
    orders: Order[];

    @Field(() => Date)
    @CreateDateColumn()
    createdAt: Date;
}