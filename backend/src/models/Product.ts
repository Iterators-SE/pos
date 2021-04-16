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

    @Column({unique: true})
    @Field()
    productname: string;

    @Field(() => User)
    @ManyToOne(() => User, owner => owner.product, {eager: true})
<<<<<<< HEAD
    owner : User;
    
    @OneToMany(() => Variant, variant => variant.product, {nullable: true})
    variant: Variant[];
=======
    user : User;
>>>>>>> 72a3de150e3fc0cc5cce43b49e89deedff3b392c

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