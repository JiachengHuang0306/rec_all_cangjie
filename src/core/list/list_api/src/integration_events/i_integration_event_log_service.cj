package list_api.integration_events

import event_bus.events.*
import list_infrastructure.*

public interface IIntegrationEventLogService {
    func retrieveEventLogsPendingToPublish(transactionUuid: String): Array<IntegrationEventLogEntity>

    func saveEvent(integrationEvent: IntegrationEvent, context: IDatabaseContext): Unit

    func markEventAsPublished(eventUuid: String): Unit

    func markEventAsInProcess(eventUuid: String): Unit

    func markEventAsFailed(eventUuid: String): Unit
}