package list_api.integration_events

import event_bus.events.*
import std.time.*

// naivesqlbuilder
import naivesqlbuilder.abstractions.*
import naivesqlbuilder.macros.*
import std.collection.*

@NSTable["integrationEventLog"]
public class IntegrationEventLogEntity {
    @NSColumn
    public var eventUuid: String = ""

    @NSColumn
    public var eventType: String = ""

    public prop integrationEvent: IntegrationEvent {
        get() {
            return _integrationEvent ?? throw Exception("this should not happen")
        }
    }
    private var _integrationEvent: ?IntegrationEvent = None

    @NSColumn
    public var stateValue: Int64 = EventState.NotPublished.toInt64()

    @NSColumn
    public var createdTime: DateTime = DateTime.fromUnixTimeStamp(Duration.Zero)

    @NSColumn
    public var contentJson: String = ""

    @NSColumn
    public var transactionUuid: String = ""

    public func deserializeIntegrationEvent(): IntegrationEventLogEntity {
        _integrationEvent = IntegrationEvent.fromJson(eventType, contentJson)
        return this
    }

    public init() {}

    public IntegrationEventLogEntity(integrationEvent: IntegrationEvent, transactionUuid: String) {
        eventUuid = integrationEvent.uuid
        createdTime = integrationEvent.createdTime
        eventType = integrationEvent.eventType
        contentJson = integrationEvent.toJson()
        this.transactionUuid = transactionUuid
    }
}