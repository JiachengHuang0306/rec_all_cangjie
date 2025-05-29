package masked_text_list_api.commands

import masked_text_list_api.models.*
import masked_text_list_api.services.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivevalidation
import naivevalidation.*
import naivevalidation.macros.*

// naivesqlbuilder
import naivesqlbuilder.builder.*
import naivesqlbuilder.macros.*
import naivesqlbuilder.orm.*
import std.collection.*

@NIService
public class DeleteMaskedTextItemCommandValidator <: AbstractValidator<DeleteMaskedTextItemCommand>{
    public DeleteMaskedTextItemCommandValidator(connectionProvider: IDatabaseConnectionProvider, 
        identityService: IIdentityService){
        @NVRuleFor({p => p.id}).must{
            id => 
            let (sql, params) = @NSSelectFrom(MaskedTextItem) {_ => []}.setWhere {p => p.id == id}.and {
                p => p.userIdentityGuid == identityService.getUserIdentityGuid()
            }.and {p => p.isDeleted == false}.toSQLWithParams()

            try (connection = connectionProvider.getConnection()) {
                let statement = connection.prepareStatement(sql)
                let queryResult = statement.query(params)
                return !(@NSMapTo[MaskedTextItem](queryResult) |> isEmpty)
            }

            throw Exception("this should not happen")
        }.withMessage("MaskedTextItem not found")
    }
    
}