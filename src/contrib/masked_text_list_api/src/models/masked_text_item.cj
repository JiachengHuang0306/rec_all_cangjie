package masked_text_list_api.models

// naivesqlbuilder
import naivesqlbuilder.abstractions.*
import naivesqlbuilder.macros.*
import std.collection.*

@NSTable["maskedTextItem"]
public class MaskedTextItem{
    
    @NSColumn
    public var id: Int64 = 0
    
    @NSColumn
    public var itemId: ?Int64 = None
    
    @NSColumn
    public var content: String = ""

    @NSColumn
    public var maskedContent: String = ""

    @NSColumn
    public var userIdentityGuid: String = ""
    
    @NSColumn
    public var isDeleted: Bool = false

}