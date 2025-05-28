package list_infrastructure.entities

import list_domain.aggregate_models.list_aggregate.*

// naivesqlbuilder
import naivesqlbuilder.abstractions.*
import naivesqlbuilder.macros.*
import std.collection.*


@NSTable["recAllList"]
public class RecAllListEntity <: RecAllList{

    @NSColumnForInheritedField["id"](var __id: Int64)
    @NSColumnForInheritedField["name"](var __name: String)
    @NSColumnForInheritedField["typeId"](var __typeId: Int64)
    @NSColumnForInheritedField["userIdentityGuid"](var __userIdentityGuid: String)
    @NSColumnForInheritedField["isDeleted"](var __isDeleted: Bool)

    public func asRecAllList(): RecAllList {
        return this
    }

}