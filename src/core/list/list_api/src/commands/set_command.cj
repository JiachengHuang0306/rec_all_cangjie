package list_api.commands

import serialization.serialization.*

// naivemediator
import naivemediator.abstractions.*
import naivemediator.macros.*

// naiveserviceresult
import naiveserviceresult.*
import cjjson.*
import cjjson.macros.*
import derive_macros.*
import derive_macros.macros.*

@NMIRequest[@ sourcePackage(), ServiceResult]
@JsonAdapter
@Derive[HashEqual]
public class CreateSetCommand {
    public var name: String = ""
    public var listId: Int64 = 0
}

@NMIRequest[@ sourcePackage(), ServiceResult]
@JsonAdapter
@Derive[HashEqual]
public class DeleteSetCommand {
    public var id: Int64 = 0
}

@NMIRequest[@ sourcePackage(), ServiceResult]
@JsonAdapter
@Derive[HashEqual]
public class UpdateSetCommand {
    public var id: Int64 = 0
    public var name: String = ""
}