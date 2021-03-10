import {AuthChecker} from "type-graphql";

export const authChecker: AuthChecker = ({ context: { currentUser } } : any) => {
    if (!currentUser) return false;
    
    // TODO [2021-03-30]: addtional checks
    return true;    
};