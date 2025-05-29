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


public class CreateListCommand <: Hashable & Equatable < CreateListCommand > & IJsonAdapter < CreateListCommand > {
    public var name: String = ""
    public var typeId: Int64 = 0
    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write("CreateListCommand")
        hasher.write(name.hashCode())
        hasher.write(typeId.hashCode())
        hasher.finish()
    }
    public operator func ==(that: CreateListCommand): Bool {
        this.hashCode() == that.hashCode()
    }
    public operator func !=(that: CreateListCommand): Bool {
        this.hashCode() != that.hashCode()
    }
    static public func fromJson(str: String): CreateListCommand {
        let dm = DataModel.fromJson(JsonValue.fromStr(str))
        return CreateListCommand.deserialize(dm)
    }
    public func toJson(): String {
        return this.serialize().toJson().toString()
    }
    public func serialize(): DataModel {
        let dms = DataModelStruct()
        dms.add(field("name", name))
        dms.add(field("typeId", typeId))
        return dms
    }
    static public func deserialize(dataModel: DataModel): CreateListCommand {
        var dms: DataModelStruct = match(dataModel) {
            case data: DataModelStruct => data
            case _ => throw Exception("CreateListCommand: not a DataModelStruct")
        }
        let obj = CreateListCommand()
        try {
            obj.name = String.deserialize(dms.get("name"))
        } catch(e: DataModelException) {
            let dm = dms.get("name")
            if(dm.isNull()) {
                throw JsonFieldNotExist("CreateListCommand", "name")
            }
            else {
                throw JsonTypeMismatch("CreateListCommand", "name", "String", dm.toJsonType())
            }
        }
        try {
            obj.typeId = Int64.deserialize(dms.get("typeId"))
        } catch(e: DataModelException) {
            let dm = dms.get("typeId")
            if(dm.isNull()) {
                throw JsonFieldNotExist("CreateListCommand", "typeId")
            }
            else {
                throw JsonTypeMismatch("CreateListCommand", "typeId", "Int64", dm.toJsonType())
            }
        }
        return obj
    }
}

extend CreateListCommand <: IRequest < ServiceResult > {
    public static prop __naivemediator__qualifiedName: String {
        get() {
            return "list_api.commands.CreateListCommand"
        }
    }
}

