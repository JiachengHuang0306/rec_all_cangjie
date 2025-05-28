package list_api.queries

// naivesqlbuilder
import naivesqlbuilder.abstractions.*
import naivesqlbuilder.macros.*
import std.collection.*

import cjjson.*
import cjjson.macros.*

@NSTable["recAllSet"]
@JsonAdapter
public class SetViewModel {
    @NSColumn
    public var id: String = ""

    @NSColumn
    public var name: String = ""

    @NSColumn
    public var typeId: Int64 = 0

    @NSColumn
    public var listId: String = ""
}