package masked_text_list_api.handlers

import masked_text_list_api.commands.*
import masked_text_list_api.services.*
import masked_text_list_api.integration_events.*

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

public func createMaskedTextItemHandler(context: TeaContext): Unit {
    let command = context.bindJson<CreateMaskedTextItemCommand>()
    let logger = @NIGetRequiredService[context.serviceProvider](Logger)
    logger.info("----- Handling ${CreateMaskedTextItemCommand.__naivemediator__qualifiedName}")

    let mediator = 
        @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    let result = mediator.send(command)

    context.json(200, result.toTypedViewModel())
}

public func deleteMaskedTextItemHandler(context: TeaContext): Unit {
    let command = context.bindJson<DeleteMaskedTextItemCommand>()
    let logger = @NIGetRequiredService[context.serviceProvider](Logger)
    logger.info("----- Handling ${DeleteMaskedTextItemCommand.__naivemediator__qualifiedName}")

    let mediator = 
        @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    let result = mediator.send(command)

    context.json(200, result.toViewModel())
}

public func updateMaskedTextItemHandler(p: TeaContext): Unit {
    let command = p.bindJson<UpdateMaskedTextItemCommand>()
    let logger = @NIGetRequiredService[p.serviceProvider](Logger)
    logger.info("----- Handling ${UpdateMaskedTextItemCommand.__naivemediator__qualifiedName}")

    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}

public func itemIdAssignedIntegrationEventHandler(p: TeaContext) {
    let integrationEvent = p.bindJson<ItemIdAssignedIntegrationEvent>()
    let logger = @NIGetRequiredService[p.serviceProvider] (Logger)
    logger.info("---- Handling ${ItemIdAssignedIntegrationEvent.__naivemediator__qualifiedName}")

    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(integrationEvent)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}