import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./User";

@Entity()
@ObjectType()
export class Product extends BaseEntity {
    @PrimaryGeneratedColumn()
    @Field(() => ID)
    id: number;

    @Column({unique: true})
    @Field()
    productname: string;

    @Column()
    ownerid : number

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