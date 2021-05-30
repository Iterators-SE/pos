import { Resolver, Mutation, Ctx, Arg, Authorized, Query } from "type-graphql";
import { ChangeTaxDetailsInput } from "../inputs/ChangeTaxDetailsInput";
import { Tax } from "../models/Tax";
import { User } from "../models/User";
import { Context } from "../types/context";
require('dotenv').config()

@Resolver(() => Tax)
export class TaxResolver {
  @Authorized()
  @Mutation(() => Boolean, { nullable: true })
  async addTax(@Ctx() ctx: Context, @Arg("name") name: string, @Arg("percentage") percentage: number){
    let user = await User.findOne({id: ctx.currentUser.id})
    let tax: Tax;
    let isSuccessful

    await Tax.create({
      name: name,
      percentage: percentage,
      user: user,
    }).save().then(tax => {
      isSuccessful = this.selectTax(ctx, tax.id);
    });

    return isSuccessful;
  }

  @Authorized()
  @Mutation(() => Boolean, { nullable: true })
  async deleteTax(@Ctx() ctx: Context, @Arg("taxId") taxId: number) {
    const tax = await Tax.findOne({ where: { user: ctx.currentUser.id, id: taxId }, relations: ["user"]});
    if (!tax) throw new Error("Deletion not possible! Tax doesn't exist!")
    await tax.remove()
    return true;
  }

  @Authorized()
  @Mutation(() => Boolean, { nullable: true })
  async editTax(@Ctx() ctx: Context, @Arg("taxId") taxId: number, @Arg("data") data: ChangeTaxDetailsInput) {
    const tax = await Tax.findOne({ where: { user: ctx.currentUser.id, id: taxId }, relations: ["user"]});
    if (!tax) throw new Error("Can't update. Tax doesn't exist!")
    Object.assign(tax, data);
    await tax.save();
    return true;
  }

  @Authorized()
  @Mutation(() => Boolean, {nullable: true})
  async selectTax (@Ctx() ctx: Context, @Arg("taxId") taxId: number) {
    const oldSelectedTax = await Tax.findOne({where: {user: ctx.currentUser.id, isSelected: true}, relations: ["user"]})
    const input = new ChangeTaxDetailsInput(); input.isSelected = false;
    if (oldSelectedTax){
      Object.assign(oldSelectedTax, input);
      await oldSelectedTax.save()
    }

    const newSelectedTax = await Tax.findOne({where: {user: ctx.currentUser.id, id: taxId}, relations: ["user"]})
    input.isSelected = true;

    if(!newSelectedTax) throw new Error("Can't select Tax");
    Object.assign(newSelectedTax, input);
    await newSelectedTax?.save()

    return true
  }

  @Authorized()
  @Query(() => [Tax], { nullable: true })
  async getTaxes(@Ctx() ctx: Context) {
      const taxes = await Tax.find({ where: { user: ctx.currentUser.id } });
      return taxes;
  }

  @Authorized()
  @Query(() => Tax, { nullable: true })
  async getTaxDetails(@Ctx() ctx: Context, @Arg("taxId") taxId: number) {
      const user = await User.findOne({id: ctx.currentUser.id});
      const taxDetails = await Tax.findOne({ where: { user: user, id: taxId } });
      if (!taxDetails) throw new Error("Tax doesn't exist!");

      console.log(taxDetails)
      return taxDetails;
  }

  @Authorized()
  @Query(() => Tax, { nullable: true })
  async getSelectedTax(@Ctx() ctx: Context) {
      const user = await User.findOne({id: ctx.currentUser.id});
      const tax = await Tax.findOne({ where: { user: user, isSelected: true } });
      if (!tax) throw new Error("No Selected");

      console.log(tax)
      return tax;
  }
}