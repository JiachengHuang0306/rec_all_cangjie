package list_api.integration_events

import event_bus.events.*
import list_infrastructure.*

// naiveioc
import naiveioc.*
import naiveioc.macros.*

// naivesqlbuilder
import naivesqlbuilder.builder.*
import naivesqlbuilder.macros.*
import naivesqlbuilder.orm.*
import std.collection.*

// others
import std.sort.*

@NIService
public class IntegrationEventLogService <: IIntegrationEventLogService {
    public IntegrationEventLogService(private let connectionProvider: IDatabaseConnectionProvider) {}

    public func retrieveEventLogsPendingToPublish(transactionUuid: String): Array<IntegrationEventLogEntity> {
        let (sql, params) = @NSSelectFrom(IntegrationEventLogEntity) {_ => []}.setWhere {p => p.transactionUuid == transactionUuid}.
            and {p => p.stateValue == EventState.NotPublished.toInt64()}.toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            let queryResult = statement.query(params)
            let events = @NSMapTo[IntegrationEventLogEntity](queryResult) |>
                map {p => p.deserializeIntegrationEvent()} |> collectArray
            events.sortBy(stable: true) {
                rht, lht => match {
                    case rht.createdTime < lht.createdTime => Ordering.LT
                    case rht.createdTime > lht.createdTime => Ordering.GT
                    case _ => Ordering.EQ
                }
            }
            return events
        }

        throw Exception("this should not happen")
    }

    public func saveEvent(integrationEvent: IntegrationEvent, context: IDatabaseContext): Unit {
        let entity = IntegrationEventLogEntity(integrationEvent, context.transactionUuid)
        context.update {
            connection =>
            let (sql, params) = @NSInsertInto(IntegrationEventLogEntity) {
                p => [
                    p.eventUuid << entity.eventUuid,
                    p.eventType << entity.eventType,
                    p.stateValue << entity.stateValue,
                    p.createdTime << entity.createdTime,
                    p.contentJson << entity.contentJson,
                    p.transactionUuid << entity.transactionUuid
                ]
            }.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func markEventAsPublished(eventUuid: String): Unit {
        updateEventState(eventUuid, EventState.Published)
    }

    public func markEventAsInProcess(eventUuid: String): Unit {
        updateEventState(eventUuid, EventState.InProcess)
    }

    public func markEventAsFailed(eventUuid: String): Unit {
        updateEventState(eventUuid, EventState.PublishFailed)
    }

    private func updateEventState(eventUuid: String, state: EventState): Unit {
        let (sql, params) = @NSUpdate(IntegrationEventLogEntity) {
            p => [p.stateValue << state.toInt64()]
        }.setWhere {p => p.eventUuid == eventUuid}.toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            connection.prepareStatement(sql).update(params)
        }
    }
}
