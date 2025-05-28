package text_list_api.services

import text_list_api.models.*

// naiveioc
import naiveioc.*
import naiveioc.macros.*

// naivesqlbuilder
import naivesqlbuilder.builder.*
import naivesqlbuilder.macros.*
import naivesqlbuilder.orm.*
import std.collection.*

// naiveserviceresult
import naiveserviceresult.*

// others
import mysqlclient4cj.cdbc.*
import std.database.sql.*

@NIService
public class TextItemStorage <: ITextItemStorage{
    public TextItemStorage(
        private let connectionProvider: IDatabaseConnectionProvider,
        private let identityService: IIdentityService
    ) {}
    
    public func add(content: String): TypedServiceResult<String>{

        let (sql, params) = @NSInsertInto(TextItem){
            p => [p.content << content, p.userIdentityGuid << identityService.getUserIdentityGuid()]
        }.toSQLWithParams()
        

        try (connection = connectionProvider.getConnection()){
            let statement = connection.prepareStatement(sql)
            let updateResult = statement.update(params)
            return TypedServiceResult<String>.success(updateResult.lastInsertId.toString())
        }
        
        throw Exception("this should not happen")
    }

    public func updateContent(id: Int64, content: String): ServiceResult {
        let (sql, params) = @NSUpdate(TextItem) {p => [p.content << content]}.setWhere {p => p.id == id}.and {
            p => p.userIdentityGuid == identityService.getUserIdentityGuid()
        }.and {p => p.isDeleted == false}.toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            statement.update(params)
            return ServiceResult.success()
        }

        throw Exception("this should not happen")
    }

    public func remove(id: Int64): ServiceResult {
        let (sql, params) = @NSUpdate(TextItem) {p => [p.isDeleted << true]}
            .setWhere {p => p.id == id}
            .and {
                p => p.userIdentityGuid == identityService.getUserIdentityGuid()
            }
            .and {p => p.isDeleted == false}
            .toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            statement.update(params)
            return ServiceResult.success()
        }

        throw Exception("this should not happen")
    }

    public func updateItemId(id: Int64, itemId: Int64): ServiceResult {
        let (sql, params) = @NSUpdate(TextItem) {p => [p.itemId << itemId]}.setWhere {p => p.id == id}.and {
            p => p.userIdentityGuid == identityService.getUserIdentityGuid()
        }.and {p => p.isDeleted == false}.toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            statement.update(params)
            return ServiceResult.success()
        }

        throw Exception("this should not happen")
    }
}