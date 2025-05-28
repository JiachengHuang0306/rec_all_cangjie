package list_infrastructure.repositories

import list_domain.*
import list_domain.aggregate_models.list_aggregate.*
import list_infrastructure.*
import list_infrastructure.entities.*

// naiveseedwork
import naiveseedwork.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivesqlbuilder
import naivesqlbuilder.builder.*
import naivesqlbuilder.macros.*
import naivesqlbuilder.orm.*
import std.collection.*

// hellohilo
import hellohilo.*

// hellohilo
import hellohilo.*

@NIService
public class ListRepository <: IListRepository {

    public ListRepository(private let idGenerator: IHiLoIdGenerator, private let context: IDatabaseContext){}

    public func add(recAllList: RecAllList): Unit {
        context.update {
            connection =>
            recAllList.__id = idGenerator.getNextId(RecAllListEntityDesc().tableName)
            let (sql, params) = @NSInsertInto(RecAllListEntity) {
                p => [
                    p.__id << recAllList.__id,
                    p.__name << recAllList.__name,
                    p.__typeId << recAllList.__typeId,
                    p.__userIdentityGuid << recAllList.__userIdentityGuid,
                    p.__isDeleted << recAllList.__isDeleted
                ]
            }.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func update(recAllList: RecAllList): Unit {
        context.update {
            connection =>
            let (sql, params) = @NSUpdate(RecAllListEntity) {
                p => [
                    p.__name << recAllList.__name,
                    p.__typeId << recAllList.__typeId,
                    p.__userIdentityGuid << recAllList.__userIdentityGuid,
                    p.__isDeleted << recAllList.__isDeleted
                ]
            }.setWhere {p => p.__id == recAllList.__id}.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func get(listId: Int64): ?RecAllList {
        let queryResult = context.query {
            connection =>
            let (sql, params) = @NSSelectFrom(RecAllListEntity) {_ => []}.setWhere {p => p.__id == listId}.
                toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
        return @NSMapTo[RecAllListEntity](queryResult) |> map {p => p.asRecAllList()} |> first
    }

    public prop unitOfWork: IUnitOfWork {
        get() {
            return context
        }
    }
}

