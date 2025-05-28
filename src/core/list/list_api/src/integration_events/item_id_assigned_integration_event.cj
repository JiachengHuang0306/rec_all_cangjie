package list_api.integration_events

import event_bus.events.*

// others
import cjjson.*
import fakeuuid4cj.*
import serialization.serialization.*
import std.time.*

public class ItemIdAssignedIntegrationEvent <: IntegrationEvent {
    public ItemIdAssignedIntegrationEvent(
        public var typeId: Int64,
        public var contribId: String,
        public var itemId: Int64
    ) {
        super(generateFakeUuid(), DateTime.now())
    }

    private init() {
        super("", DateTime.fromUnixTimeStamp(Duration.Zero))
        typeId = 0
        contribId = ""
        itemId = 0
    }

    private static const EventType: String = "ItemIdAssignedIntegrationEvent"
    public prop eventType: String {
        get() {
            return EventType
        }
    }

    protected func serializeSubclassSpecificFields(dms: DataModelStruct): Unit {
        dms.add(field("typeId", typeId))
        dms.add(field("contribId", contribId))
        dms.add(field("itemId", itemId))
    }

    private static func subclassSpecificFieldDeserializer(dms: DataModelStruct): IntegrationEvent {
        let obj = ItemIdAssignedIntegrationEvent()

        try {
            obj.typeId = Int64.deserialize(dms.get("typeId"))
        } catch (e: DataModelException) {
            let dm = dms.get("typeId")
            if (dm.isNull()) {
                throw JsonFieldNotExist("ItemIdAssignedIntegrationEvent", "typeId")
            } else {
                throw JsonTypeMismatch("ItemIdAssignedIntegrationEvent", "typeId", "Int64", dm.toJsonType())
            }
        }

        try {
            obj.contribId = String.deserialize(dms.get("contribId"))
        } catch (e: DataModelException) {
            let dm = dms.get("contribId")
            if (dm.isNull()) {
                throw JsonFieldNotExist("ItemIdAssignedIntegrationEvent", "contribId")
            } else {
                throw JsonTypeMismatch("ItemIdAssignedIntegrationEvent", "contribId", "String", dm.toJsonType())
            }
        }

        try {
            obj.itemId = Int64.deserialize(dms.get("itemId"))
        } catch (e: DataModelException) {
            let dm = dms.get("itemId")
            if (dm.isNull()) {
                throw JsonFieldNotExist("ItemIdAssignedIntegrationEvent", "itemId")
            } else {
                throw JsonTypeMismatch("ItemIdAssignedIntegrationEvent", "itemId", "String", dm.toJsonType())
            }
        }

        return obj
    }

    static init() {
        IntegrationEvent.registerSubclassSpecificFieldDeserializer(EventType, subclassSpecificFieldDeserializer)
    }
}