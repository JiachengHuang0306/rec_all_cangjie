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
public class CreateListCommand {
    public var name: String = ""
    public var typeId: Int64 = 0
}