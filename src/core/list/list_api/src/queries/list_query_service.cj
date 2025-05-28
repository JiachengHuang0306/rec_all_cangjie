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
public class ListQueryService <: IListQueryService {
    public ListQueryService(
        private let identityService: IIdentityService,
        private let connectionProvider: IDatabaseConnectionProvider
    ) {}

    public func list(skip: Int64, take: Int64): TypedServiceResult<Array<ListViewModel>> {
        let (sql, params) = @NSSelectFrom(RecAllListEntity)(Dialect.MYSQL, {_ => []}).setWhere {
            p => p.__userIdentityGuid == identityService.getUserIdentityGuid()
        }.and({p => p.__isDeleted == false}).setLimit(take, skip).toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            let queryResult = statement.query(params)
            return TypedServiceResult<Array<ListViewModel>>.success(@NSMapTo[ListViewModel](queryResult) |> collectArray
            )
        }

        throw Exception("this should not happen")
    }

    public func get(id: Int64): TypedServiceResult<ListViewModel> {
        let (sql, params) = @NSSelectFrom(RecAllListEntity){_ => []}.setWhere {p => p.__id == id}.and {
            p => p.__userIdentityGuid == identityService.getUserIdentityGuid()
        }.and {p => p.__isDeleted == false}.toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            let queryResult = statement.query(params)
            return match (@NSMapTo[ListViewModel](queryResult) |> first) {
                case Some(v) => TypedServiceResult<ListViewModel>.success(v)
                case None => TypedServiceResult<ListViewModel>.invalidParameter("List not found")
            }
        }

        throw Exception("this should not happen")
    }
}