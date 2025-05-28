package list_api.queries

import list_infrastructure.*
import list_infrastructure.entities.*
import list_api.services.*

// naiveioc
import naiveioc.*
import naiveioc.macros.*

// naivesqlbuilder
import naivesqlbuilder.builder.*
import naivesqlbuilder.macros.*
import naivesqlbuilder.orm.*
import std.collection.*
import sql_builder.builder.*

// naiveserviceresult
import naiveserviceresult.*

@NIService
public class SetQueryService <: ISetQueryService {
    public SetQueryService(
        private let identityService: IIdentityService,
        private let connectionProvider: IDatabaseConnectionProvider
    ) {}

    public func list(listId: Int64, skip: Int64, take: Int64): TypedServiceResult<Array<SetViewModel>> {
        let (sql, params) = @NSSelectFrom(RecAllSetEntity)(Dialect.MYSQL, {_ => []}).setWhere {p => p.__listId == listId}.
            and {p => p.__userIdentityGuid == identityService.getUserIdentityGuid()}.and {p => p.__isDeleted == false}.
            setLimit(take, skip).toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            let queryResult = statement.query(params)
            return TypedServiceResult<Array<SetViewModel>>.success(@NSMapTo[SetViewModel](queryResult) |> collectArray)
        }

        throw Exception("this should not happen")
    }

    public func get(id: Int64): TypedServiceResult<SetViewModel> {
        let (sql, params) = @NSSelectFrom(RecAllSetEntity)(Dialect.MYSQL, {_ => []}).setWhere {p => p.__id == id}.and {
            p => p.__userIdentityGuid == identityService.getUserIdentityGuid()
        }.and {p => p.__isDeleted == false}.toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            let queryResult = statement.query(params)
            return match (@NSMapTo[SetViewModel](queryResult) |> first) {
                case Some(v) => TypedServiceResult<SetViewModel>.success(v)
                case None => TypedServiceResult<SetViewModel>.invalidParameter("Set not found")
            }
        }

        throw Exception("this should not happen")
    }
}
