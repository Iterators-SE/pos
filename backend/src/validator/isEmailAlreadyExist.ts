import { isEmail, registerDecorator, ValidationOptions, ValidatorConstraint, ValidatorConstraintInterface } from "class-validator";
import { User } from "../models/User";

@ValidatorConstraint({ async: true })
export class IsEmailAlreadyExistConstraint implements ValidatorConstraintInterface {
    async validate(email: string): Promise<boolean> {
        if (!isEmail(email)) {
            throw new Error("Please input a valid email.");
        }

        const user = await User.findOne({ where: { email } })
        return !user;
    }

}

export function isEmailAlreadyExist(validationOptions?: ValidationOptions) {
    return function (object: Object, propertyName: string) {
        registerDecorator({
            target: object.constructor,
            propertyName: propertyName,
            options: validationOptions,
            constraints: [],
            validator: IsEmailAlreadyExistConstraint
        });
    }
}