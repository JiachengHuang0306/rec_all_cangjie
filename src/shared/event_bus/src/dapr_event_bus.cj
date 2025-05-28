package event_bus

import event_bus.abstractions.*
import event_bus.events.*

// naiveioc
import naiveioc.*
import naiveioc.macros.*

// dapr_cangjie_sdk
import dapr_cangjie_sdk.client.*

// others
import std.collection.*

@NIService
public class DaprEventBus <: IEventBus {
    public static const PubSubName = "recall-pubsub"

    public DaprEventBus(private let daprClient: DaprClient) {}

    public func publish(event: IntegrationEvent): Unit {
        daprClient.publishEvent(
            PubSubName, event.eventType, event.serialize(),
            HashMap<String, String>([("rawPayload", "true")]))
    }
}