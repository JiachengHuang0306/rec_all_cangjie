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
public class LoggingBehavior <: IPipelineBehavior {
    public LoggingBehavior(private let logger: Logger) {}

    public func handle(request: IBaseRequest, next: (IBaseRequest) -> Any): Any {
        logger.info("----- Handling ${request.__naivemediator__qualifiedName__}")
        let response = next(request)
        logger.info("----- Handled ${request.__naivemediator__qualifiedName__}")
        return response
    }
}