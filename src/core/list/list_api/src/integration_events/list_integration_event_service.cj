package list_api.integration_events

import event_bus.abstractions.*
import event_bus.events.*
import list_infrastructure.*

// naiveioc
import naiveioc.*
import naiveioc.macros.*

@NIService
public class ListIntegrationEventService <: IListIntegrationEventService {
    public ListIntegrationEventService(private let integrationEventLogService: IIntegrationEventLogService,
        private let databaseContext: IDatabaseContext, private let eventBus: IEventBus) {}

    public func addAndSaveEvent(integrationEvent: IntegrationEvent): Unit {
        integrationEventLogService.saveEvent(integrationEvent, databaseContext)
    }

    public func publishEvents(transactionUuid: String): Unit {
        let pendingLogEvents = integrationEventLogService.retrieveEventLogsPendingToPublish(transactionUuid)

        for (logEvent in pendingLogEvents) {
            try {
                integrationEventLogService.markEventAsInProcess(logEvent.eventUuid)
                eventBus.publish(logEvent.integrationEvent)
                integrationEventLogService.markEventAsPublished(logEvent.eventUuid)
            } catch (e: Exception) {
                integrationEventLogService.markEventAsFailed(logEvent.eventUuid)
            }
        }
    }
}