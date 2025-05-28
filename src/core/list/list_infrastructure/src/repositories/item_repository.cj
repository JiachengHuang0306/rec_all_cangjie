package list_infrastructure.repositories

import list_domain.*
import list_domain.aggregate_models.item_aggregate.*
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
public class ItemRepository <: IItemRepository {
    public ItemRepository(private let context: IDatabaseContext, private let idGenerator: IHiLoIdGenerator) {}

    public func add(recAllItem: RecAllItem): Unit {
        context.update {
            connection =>
            recAllItem.__id = idGenerator.getNextId(RecAllItemEntityDesc().tableName)
            let (sql, params) = @NSInsertInto(RecAllItemEntity) {
                p => [
                    p.__id << recAllItem.__id,
                    p.__typeId << recAllItem.__typeId,
                    p.__setId << recAllItem.__setId,
                    p.__contribId << recAllItem.__contribId,
                    p.__userIdentityGuid << recAllItem.__userIdentityGuid,
                    p.__isDeleted << recAllItem.__isDeleted
                ]
            }.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func update(recAllItem: RecAllItem): Unit {
        context.update {
            connection =>
            let (sql, params) = @NSUpdate(RecAllItemEntity) {
                p => [
                    p.__typeId << recAllItem.__typeId,
                    p.__setId << recAllItem.__setId,
                    p.__contribId << recAllItem.__contribId,
                    p.__userIdentityGuid << recAllItem.__userIdentityGuid,
                    p.__isDeleted << recAllItem.__isDeleted
                ]
            }.setWhere {p => p.__id == recAllItem.__id}.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func get(itemId: Int64): ?RecAllItem {
        let queryResult = context.query {
            connection =>
            let (sql, params) = @NSSelectFrom(RecAllItemEntity) {_ => []}.setWhere {p => p.__id == itemId}.
                toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
        return @NSMapTo[RecAllItemEntity](queryResult) |> map {p => p.asRecAllItem()} |> first
    }

    public prop unitOfWork: IUnitOfWork {
        get() {
            return context
        }
    }
}