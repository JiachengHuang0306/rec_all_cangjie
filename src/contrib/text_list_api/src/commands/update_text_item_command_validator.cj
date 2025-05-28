package text_list_api.commands

import text_list_api.models.*
import text_list_api.services.*

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
public class UpdateTextItemCommandValidator <: AbstractValidator<UpdateTextItemCommand> {
    public UpdateTextItemCommandValidator(
        identityService: IIdentityService,
        connectionProvider: IDatabaseConnectionProvider
    ) {
        @NVRuleFor({p => p.id}).must {
            id =>
            let (sql, params) = @NSSelectFrom(TextItem) {_ => []}.setWhere {p => p.id == id}.and {
                p => p.userIdentityGuid == identityService.getUserIdentityGuid()
            }.and {p => p.isDeleted == false}.toSQLWithParams()

            try (connection = connectionProvider.getConnection()) {
                let statement = connection.prepareStatement(sql)
                let queryResult = statement.query(params)
                return !(@NSMapTo[TextItem](queryResult) |> isEmpty)
            }

            throw Exception("this should not happen")
        }.withMessage("TextItem not found")
    }
}