
import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./User";

@Entity()
@ObjectType()
export class Tax extends BaseEntity {
  @PrimaryGeneratedColumn()
  @Field(() => ID)
  id: number;

  @Column()
  @Field()
  name: string;

  @Column({default: false})
  @Field()
  isSelected: boolean;

  @ManyToOne(() => User, user => user.tax, {eager:true})
  user: User;


  @Column("decimal", {precision: 3, scale: 2})
  @Field()
  perentage: number;
}
