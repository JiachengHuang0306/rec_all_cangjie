package list_api.integration_events

import event_bus.events.*

public interface IListIntegrationEventService {
    func addAndSaveEvent(integrationEvent: IntegrationEvent): Unit

    func publishEvents(transactionUuid: String): Unit
}