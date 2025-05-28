package event_bus.events

import cjjson.*
import datetime_serialization.*
import encoding.json.*
import serialization.serialization.*
import std.collection.*
import std.time.*

public abstract class IntegrationEvent {
    protected IntegrationEvent(
        public var uuid: String,
        public var createdTime: DateTime
    ) {}
    
    public prop eventType: String

    private static let deserializerMap: HashMap<String, (DataModelStruct) -> IntegrationEvent> = HashMap<String, (DataModelStruct) -> IntegrationEvent>(
        )

    protected static func registerSubclassSpecificFieldDeserializer(
        eventType: String,
        deserializer: (DataModelStruct) -> IntegrationEvent
    ): Unit {
        if (deserializerMap.contains(eventType)) {
            throw Exception("duplicate event type: " + eventType)
        }

        deserializerMap[eventType] = deserializer
    }

    public static func deserialize(eventType: String, dm: DataModel): IntegrationEvent {
        if (!deserializerMap.contains(eventType)) {
            throw Exception("unknown event type: " + eventType)
        }

        var dms: DataModelStruct = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("IntegrationEvent: not a DataModelStruct")
        }

        let obj = deserializerMap[eventType](dms)

        try {
            obj.uuid = String.deserialize(dms.get("uuid"))
        } catch (e: DataModelException) {
            let dm = dms.get("uuid")
            if (dm.isNull()) {
                throw JsonFieldNotExist("IntegrationEvent", "uuid")
            } else {
                throw JsonTypeMismatch("IntegrationEvent", "uuid", "String", dm.toJsonType())
            }
        }

        try {
            obj.createdTime = deserializeDateTime(dms.get("createdTime"))
        } catch (e: DataModelException) {
            let dm = dms.get("createdTime")
            if (dm.isNull()) {
                throw JsonFieldNotExist("IntegrationEvent", "createdTime")
            } else {
                throw JsonTypeMismatch("IntegrationEvent", "createdTime", "DateTime", dm.toJsonType())
            }
        }

        return obj
    }

    public static func fromJson(eventType: String, str: String): IntegrationEvent {
        let dm = str |> JsonValue.fromStr |> DataModel.fromJson
        return deserialize(eventType, dm)
    }

    public func serialize(): DataModelStruct {
        let dms = DataModelStruct()
        dms.add(field("uuid", uuid))
        dms.add(Field("createdTime", serializeDateTime(createdTime)))
        serializeSubclassSpecificFields(dms)
        return dms
    }

    protected func serializeSubclassSpecificFields(dms: DataModelStruct): Unit

    public func toJson(): String {
        return serialize().toJson().toString()
    }
}