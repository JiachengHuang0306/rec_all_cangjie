package text_list_api

import text_list_api.commands.*
import text_list_api.handlers.*
import text_list_api.services.*
import text_list_api.integration_events.*

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

// dapr_tea
import dapr_tea.subscription.*

func addCustomLogger(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    
    serviceCollection |> addNaiveLogger{
        p => p.usePrintLogger{_=>} //print logger
            .useSeqLogger{q => q.addr = "recall-seq"}
    }
    return serviceCollection
}

func addCustomApplicationServices(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    @NIAddSingleton[serviceCollection](IDatabaseConnectionProvider, DatabaseConnectionProvider)

    @NIAddScoped[serviceCollection](IIdentityService, MockIdentityService)
    @NIAddScoped[serviceCollection](ITextItemStorage, TextItemStorage)

    return serviceCollection
}

func addCustomMediator(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    @NIAddTransient[serviceCollection](NaiveMediator)

    @NIAddTransient[serviceCollection](IPipelineBehavior, ValidatorBehavior)

    @NMRegisterTransientHandler[serviceCollection](CreateTextItemCommand, CreateTextItemCommandHandler)
    @NMRegisterTransientHandler[serviceCollection](UpdateTextItemCommand, UpdateTextItemCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](UpdateTextItemCommand, UpdateTextItemCommandValidator)
    @NMRegisterTransientHandler[serviceCollection](DeleteTextItemCommand, DeleteTextItemCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](DeleteTextItemCommand, DeleteTextItemCommandValidator)
    @NMRegisterTransientHandler[serviceCollection](ItemIdAssignedIntegrationEvent, ItemIdAssignedIntegrationEventHandler)

    return serviceCollection
}

func mapHandlers(tea: Tea): Tea {
    tea.post("/item/create", createTextItemHandler)
    tea.post("/item/update", updateTextItemHandler)
    tea.post("/item/delete", deleteTextItemHandler)

    return tea
}

func mapTopicHandlers(tea: Tea): Tea {
    // 订阅事件并注册事件Handler
    tea
        .topic
        .pubsubName("recall-pubsub")
        .topic("ItemIdAssignedIntegrationEvent")
        .post("/itemIdAssigned", itemIdAssignedIntegrationEventHandler)
    tea.subscriptions.mapHandler()

    return tea
}