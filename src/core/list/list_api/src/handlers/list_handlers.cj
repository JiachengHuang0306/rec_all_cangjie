package list_api.handlers

import list_api.commands.*
import list_api.queries.*

// tea
import tea.*

// naiveteaset
import naiveteaset.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivemediator
import naivemediator.*

// naiveserviceresult
import naiveserviceresult.*
import std.convert.*

public func listListHandler(p: TeaContext): Unit {
    let skip = Int64.tryParse(p.query("skip") ?? throw Exception("missing query parameter skip")) ?? throw Exception(
        "missing query parameter skip")
    let take = Int64.tryParse(p.query("take") ?? throw Exception("missing query parameter take")) ?? throw Exception(
        "missing query parameter take")

    let queryService = @NIGetRequiredService[p.serviceProvider](IListQueryService)
    let lists = queryService.list(skip, take).toTypedViewModel()
    p.json(200, lists)
}

public func getListHandler(p: TeaContext): Unit {
    let id = Int64.tryParse(p.query("id") ?? throw Exception("missing query parameter id")) ?? throw Exception(
        "missing query parameter id")
    let queryService = @NIGetRequiredService[p.serviceProvider](IListQueryService)
    let result = queryService.get(id)
    p.json(200, result.toTypedViewModel())
}

public func createListHandler(p: TeaContext): Unit {
    let command = p.bindJson<CreateListCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}

public func updateListHandler(p: TeaContext): Unit {
    let command = p.bindJson<UpdateListCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}

public func deleteListHandler(p: TeaContext): Unit {
    let command = p.bindJson<DeleteListCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}
