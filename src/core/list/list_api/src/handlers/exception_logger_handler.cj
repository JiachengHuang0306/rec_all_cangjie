package list_api.handlers

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naiveteaset
import naiveteaset.*

// tea
import tea.*

// others
import log.*

public func exceptionLoggerHandler(p: TeaContext): Unit {
    try {
        p.next()
    } catch (e: Exception) {
        let logger = @NIGetRequiredService[p.serviceProvider](Logger)
        logger.error(e.message)
        throw e
    }
}