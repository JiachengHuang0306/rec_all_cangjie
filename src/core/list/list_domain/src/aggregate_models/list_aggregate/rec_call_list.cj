package list_domain.aggregate_models.list_aggregate

// naiveseedwork
import naiveseedwork.*

public open class RecAllList <: Entity & IAggregateRoot{
    public var __name: String = String.empty

    public var __typeId: Int64 = 0

    public var __userIdentityGuid: String = String.empty

    public var __isDeleted: Bool = false

    public init() {}

    public init(name: String, typeId: Int64, userIdentityGuid: String) {
        __name = name
        __typeId = typeId
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

    private func throwDeletedException(): Unit {
        throw Exception("列表已删除。")
    }
}