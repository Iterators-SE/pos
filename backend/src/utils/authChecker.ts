import {AuthChecker} from "type-graphql";

export const authChecker: AuthChecker = ({ context: { currentUser } } : any) => {
    if (!currentUser) return false;
    return true;    
};