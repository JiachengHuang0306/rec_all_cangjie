package text_list_api.models

// naivesqlbuilder
import naivesqlbuilder.abstractions.*
import naivesqlbuilder.macros.*
import std.collection.*

@NSTable["textItem"]
public class TextItem{
    
    @NSColumn
    public var id: Int64 = 0
    
    @NSColumn
    public var itemId: ?Int64 = None
    
    @NSColumn
    public var content: String = ""

    @NSColumn
    public var userIdentityGuid: String = ""
    
    @NSColumn
    public var isDeleted: Bool = false

}