package list_infrastructure.repositories

import list_domain.*
import list_domain.aggregate_models.set_aggregate.*
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

@NIService
public class SetRepository <: ISetRepository {
    public SetRepository(private let context: IDatabaseContext, private let idGenerator: IHiLoIdGenerator) {}

    public func add(recAllSet: RecAllSet): Unit {
        context.update {
            connection =>
            recAllSet.__id = idGenerator.getNextId(RecAllSetEntityDesc().tableName)
            let (sql, params) = @NSInsertInto(RecAllSetEntity) {
                p => [
                    p.__id << recAllSet.__id,
                    p.__name << recAllSet.__name,
                    p.__typeId << recAllSet.__typeId,
                    p.__listId << recAllSet.__listId,
                    p.__userIdentityGuid << recAllSet.__userIdentityGuid,
                    p.__isDeleted << recAllSet.__isDeleted
                ]
            }.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func update(recAllSet: RecAllSet): Unit {
        context.update {
            connection =>
            let (sql, params) = @NSUpdate(RecAllSetEntity) {
                p => [
                    p.__name << recAllSet.__name,
                    p.__typeId << recAllSet.__typeId,
                    p.__listId << recAllSet.__listId,
                    p.__userIdentityGuid << recAllSet.__userIdentityGuid,
                    p.__isDeleted << recAllSet.__isDeleted
                ]
            }.setWhere {p => p.__id == recAllSet.__id}.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func get(listId: Int64): ?RecAllSet {
        let queryResult = context.query {
            connection =>
            let (sql, params) = @NSSelectFrom(RecAllSetEntity) {_ => []}.setWhere {p => p.__id == listId}.
                toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
        return @NSMapTo[RecAllSetEntity](queryResult) |> map {p => p.asRecAllSet()} |> first
    }

    public prop unitOfWork: IUnitOfWork {
        get() {
            return context
        }
    }
}