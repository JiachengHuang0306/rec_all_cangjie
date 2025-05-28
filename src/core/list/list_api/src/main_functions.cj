package list_api

import list_infrastructure.*
import list_infrastructure.repositories.*
import list_api.behaviors.*
import list_api.commands.*
import list_api.handlers.*
import list_api.integration_events.*
import list_api.queries.*
import list_api.services.*
import event_bus.abstractions.*
import event_bus.*

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

// tea
import tea.*

// hellohilo
import hellohilo.*

func addCustomLogger(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    serviceCollection |> addNaiveLogger {p => p.usePrintLogger {_ =>}.useSeqLogger {p => p.addr = "recall-seq"}}
    return serviceCollection
}

func addCustomApplicationServices(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    @NIAddSingleton[serviceCollection](IDatabaseConnectionProvider, DatabaseConnectionProvider)
    @NIAddSingleton[serviceCollection](IListQueryService, ListQueryService)
    @NIAddSingleton[serviceCollection](ISetQueryService, SetQueryService)
    @NIAddSingleton[serviceCollection](IContribUrlService, ContribUrlService)
    @NIAddSingleton[serviceCollection](IEventBus, DaprEventBus)
    @NIAddSingleton[serviceCollection](IHiLoConnectionProvider, HiLoConnectionProvider)
    @NIAddSingleton[serviceCollection](IHiLoIdGenerator, HiLoIdGenerator)

    @NIAddScoped[serviceCollection](IDatabaseContext, DatabaseContext)
    @NIAddScoped[serviceCollection](IIdentityService, MockIdentityService)
    @NIAddScoped[serviceCollection](IListRepository, ListRepository)
    @NIAddScoped[serviceCollection](ISetRepository, SetRepository)
    @NIAddScoped[serviceCollection](IItemRepository, ItemRepository)
    @NIAddScoped[serviceCollection](IIntegrationEventLogService, IntegrationEventLogService)
    @NIAddScoped[serviceCollection](IListIntegrationEventService, ListIntegrationEventService)

    return serviceCollection
}

func addCustomMediator(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    @NIAddTransient[serviceCollection](NaiveMediator)
    @NIAddTransient[serviceCollection](IPipelineBehavior, LoggingBehavior)
    @NIAddTransient[serviceCollection](IPipelineBehavior, ValidatorBehavior)
    @NIAddTransient[serviceCollection](IPipelineBehavior, TransactionBehavior)

    @NMRegisterTransientHandler[serviceCollection](CreateListCommand, CreateListCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](CreateListCommand, CreateListCommandValidator)
    @NMRegisterTransientHandler[serviceCollection](UpdateListCommand, UpdateListCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](UpdateListCommand, UpdateListCommandValidator)
    @NMRegisterTransientHandler[serviceCollection](DeleteListCommand, DeleteListCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](DeleteListCommand, DeleteListCommandValidator)

    @NMRegisterTransientHandler[serviceCollection](CreateSetCommand, CreateSetCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](CreateSetCommand, CreateSetCommandValidator)
    @NMRegisterTransientHandler[serviceCollection](DeleteSetCommand, DeleteSetCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](DeleteSetCommand, DeleteSetCommandValidator)
    @NMRegisterTransientHandler[serviceCollection](UpdateSetCommand, UpdateSetCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](UpdateSetCommand, UpdateSetCommandValidator)

    @NMRegisterTransientHandler[serviceCollection](CreateItemCommand, CreateItemCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](CreateItemCommand, CreateItemCommandValidator)

    return serviceCollection
}

func mapHandlers(tea: Tea): Tea {
    tea.get("", {p: TeaContext => p.string(200, "list_api")})

    tea.get("list/list", listListHandler)
    tea.get("list/get", getListHandler)
    tea.post("list/create", createListHandler)
    tea.post("list/delete", deleteListHandler)
    tea.post("list/update", updateListHandler)

    tea.get("set/list", listSetHandler)
    tea.get("set/get", getSetHandler)
    tea.post("set/create", createSetHandler)
    tea.post("set/delete", deleteSetHandler)
    tea.post("set/update", updateSetHandler)

    // tea.get("item/list", listItemHandler)
    // tea.get("item/get", getItemHandler)
    tea.post("item/create", createItemHandler)


    return tea
}