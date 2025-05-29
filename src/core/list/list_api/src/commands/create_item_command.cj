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
public class CreateItemCommand <: Hashable & Equatable<CreateItemCommand> & IJsonAdapter<CreateItemCommand> {
    public var setId: Int64 = 0
    public var contribJson: DataModelStruct = DataModelStruct()

    public operator func ==(that: CreateItemCommand): Bool {
        this.hashCode() == that.hashCode()
    }

    public operator func !=(that: CreateItemCommand): Bool {
        this.hashCode() != that.hashCode()
    }

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write("CreateItemCommand")
        hasher.write(setId.hashCode())
        hasher.write(contribJson.toJson().toJsonString().hashCode())
        hasher.finish()
    }

    public static func deserialize(dataModel: DataModel): CreateItemCommand {
        var dms: DataModelStruct = match (dataModel) {
            case data: DataModelStruct => data
            case _ => throw Exception("CreateItemCommand: not a DataModelStruct")
        }

        let obj = CreateItemCommand()

        try {
            obj.setId = Int64.deserialize(dms.get("setId"))
        } catch (e: DataModelException) {
            let dm = dms.get("setId")
            if (dm.isNull()) {
                throw JsonFieldNotExist("CreateItemCommand", "setId")
            } else {
                throw JsonTypeMismatch("CreateItemCommand", "setId", "Int64", dm.toJsonType())
            }
        }

        obj.contribJson = match (dms.get("contribJson")) {
            case data: DataModelStruct => data
            case _ => throw Exception("CreateItemCommand#contribJson: not a DataModelStruct")
        }

        return obj
    }

    public func serialize(): DataModel {
        let dms = DataModelStruct()
        dms.add(field("setId", setId))
        dms.add(Field("contribJson", contribJson))
        return dms
    }

    public static func fromJson(str: String): CreateItemCommand {
        return str |> JsonValue.fromStr |> DataModel.fromJson |> CreateItemCommand.deserialize
    }

    public func toJson(): String {
        return serialize().toJson().toString()
    }
}