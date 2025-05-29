package masked_text_list_api

import masked_text_list_api.commands.*
import masked_text_list_api.handlers.*
import masked_text_list_api.services.*
import masked_text_list_api.integration_events.*
import dapr_tea.subscription.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivemediator
import naivemediator.*
import naivemediator.abstractions.*
import naivemediator.macros.*

// naivelogger
import naivelogger.*
import naivelogger.print_logger.*
import naivelogger_seq.*

// naiveteaset
import naiveteaset.macros.*
import naiveteaset.naivevalidation.*

//tea
import tea.*

func addCustomLogger(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {

    serviceCollection |> addNaiveLogger{
        p => p.usePrintLogger{_=>}
            .useSeqLogger{q => q.addr = "recall-seq"}
    }
    return serviceCollection
}

func addCustomApplicationServices(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    @NIAddSingleton[serviceCollection](IDatabaseConnectionProvider, DatabaseConnectionProvider)

    @NIAddScoped[serviceCollection](IIdentityService, MockIdentityService)
    @NIAddScoped[serviceCollection](IMaskedTextItemStorage, MaskedTextItemStorage)

    return serviceCollection
}

func addCustomMediator(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    @NIAddTransient[serviceCollection](NaiveMediator)

    @NIAddTransient[serviceCollection](IPipelineBehavior, ValidatorBehavior)

    @NMRegisterTransientHandler[serviceCollection](CreateMaskedTextItemCommand, CreateMaskedTextItemCommandHandler)
    @NMRegisterTransientHandler[serviceCollection](UpdateMaskedTextItemCommand, UpdateMaskedTextItemCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](UpdateMaskedTextItemCommand, UpdateMaskedTextItemCommandValidator)
    @NMRegisterTransientHandler[serviceCollection](DeleteMaskedTextItemCommand, DeleteMaskedTextItemCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](DeleteMaskedTextItemCommand, DeleteMaskedTextItemCommandValidator)

    @NMRegisterTransientHandler[serviceCollection](ItemIdAssignedIntegrationEvent, ItemIdAssignedIntegrationEventHandler)

    return serviceCollection
}

func mapHandlers(tea: Tea): Tea {
    tea.post("/item/create", createMaskedTextItemHandler)
    tea.post("/item/update", updateMaskedTextItemHandler)
    tea.post("/item/delete", deleteMaskedTextItemHandler)
    
    return tea
}

func mapTopicHandlers(tea: Tea): Tea {
    tea
        .topic
        .pubsubName("recall-pubsub")
        .topic("ItemIdAssignedIntegrationEvent")
        .post("/itemIdAssigned", itemIdAssignedIntegrationEventHandler)
    tea.subscriptions.mapHandler()
    return tea
}