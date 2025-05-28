package event_bus.abstractions

import event_bus.events.*

public interface IEventBus {
    func publish(event: IntegrationEvent): Unit
}