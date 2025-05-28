package list_api.behaviors

import list_api.integration_events.*
import list_infrastructure.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivemediator
import naivemediator.abstractions.*

// others
import log.*

@NIService
public class TransactionBehavior <: IPipelineBehavior {
    public TransactionBehavior(
        private let databaseContext: IDatabaseContext,
        private let listIntegrationEventService: IListIntegrationEventService,
        private let logger: Logger
    ) {}

    public func handle(request: IBaseRequest, next: (IBaseRequest) -> Any): Any {
        if (databaseContext.hasActiveTransaction) {
            return next(request)
        }

        databaseContext.beginTransaction()
        logger.info(
            "----- Begin transaction ${databaseContext.transactionUuid} for ${request.__naivemediator__qualifiedName__}"
        )
        let response = next(request)
        logger.info(
            "----- Commit transaction ${databaseContext.transactionUuid} for ${request.__naivemediator__qualifiedName__}"
        )
        databaseContext.commitTransaction()
        listIntegrationEventService.publishEvents(databaseContext.transactionUuid)
        return response
    }
}