package text_list_api.handlers

import text_list_api.commands.*
import text_list_api.services.*
import text_list_api.integration_events.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivemediator
import naivemediator.*
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

// naiveteaset
import naiveteaset.*

// others
import log.*

//tea
import tea.*

public func createTextItemHandler(context: TeaContext): Unit {
    let command = context.bindJson<CreateTextItemCommand>()
    let logger = @NIGetRequiredService[context.serviceProvider](Logger)
    logger.info("----- Handling ${CreateTextItemCommand.__naivemediator__qualifiedName}")

    let mediator = 
        @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    let result = mediator.send(command)

    context.json(200, result.toTypedViewModel())
}

public func updateTextItemHandler(p: TeaContext): Unit {
    let command = p.bindJson<UpdateTextItemCommand>()
    let logger = @NIGetRequiredService[p.serviceProvider](Logger)
    logger.info("----- Handling ${UpdateTextItemCommand.__naivemediator__qualifiedName}")

    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}

public func deleteTextItemHandler(context: TeaContext): Unit {
    let command = context.bindJson<DeleteTextItemCommand>()
    let logger = @NIGetRequiredService[context.serviceProvider](Logger)
    logger.info("----- Handling ${DeleteTextItemCommand.__naivemediator__qualifiedName}")

    let mediator = 
        @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    let result = mediator.send(command)

    context.json(200, result.toViewModel())
}


//========================
public func itemIdAssignedIntegrationEventHandler(p: TeaContext) {
    let integrationEvent = p.bindJson<ItemIdAssignedIntegrationEvent>()
    let logger = @NIGetRequiredService[p.serviceProvider](Logger)
    logger.info("----- Handling ${ItemIdAssignedIntegrationEvent.__naivemediator__qualifiedName}")
    
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(integrationEvent)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}