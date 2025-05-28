package list_domain.aggregate_models.set_aggregate

// naiveseedwork
import naiveseedwork.*

public open class RecAllSet <: Entity & IAggregateRoot {
    public var __name: String = String.empty

    public var __typeId: Int64 = 0

    public var __listId: Int64 = 0

    public var __userIdentityGuid: String = String.empty

    public var __isDeleted: Bool = false

    public init() {}

    public init(name: String, typeId: Int64, listId: Int64, userIdentityGuid: String) {
        __name = name
        __typeId = typeId
        __listId = listId
        __userIdentityGuid = userIdentityGuid
    }

    public func setDeleted(): Unit {
        if (__isDeleted) {
            throwDeletedException()
        }

        __isDeleted = true
    }

    public func setName(name: String): Unit {
        if (__isDeleted) {
            throwDeletedException()
        }

        __name = name
    }

    public func setListId(listId: Int64): Unit {
        if (__isDeleted) {
            throwDeletedException()
        }

        __listId = listId
    }

    private func throwDeletedException(): Unit {
        throw Exception("集合已删除。")
    }
}