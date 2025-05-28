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

public func listSetHandler(p: TeaContext): Unit {
    let listId = Int64.tryParse(p.query("listId") ?? throw Exception("missing query parameter listId")) ?? throw Exception(
        "missing query parameter listId")
    let skip = Int64.tryParse(p.query("skip") ?? throw Exception("missing query parameter skip")) ?? throw Exception(
        "missing query parameter skip")
    let take = Int64.tryParse(p.query("take") ?? throw Exception("missing query parameter take")) ?? throw Exception(
        "missing query parameter take")

    let queryService = @NIGetRequiredService[p.serviceProvider](ISetQueryService)
    let sets = queryService.list(listId, skip, take).toTypedViewModel()
    p.json(200, sets)
}

public func getSetHandler(p: TeaContext): Unit {
    let id = Int64.tryParse(p.query("id") ?? throw Exception("missing query parameter id")) ?? throw Exception(
        "missing query parameter id")
    let queryService = @NIGetRequiredService[p.serviceProvider](ISetQueryService)
    let resut = queryService.get(id)
    p.json(200, resut.toTypedViewModel())
}

public func createSetHandler(p: TeaContext): Unit {
    let command = p.bindJson<CreateSetCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}

public func deleteSetHandler(p: TeaContext): Unit {
    let command = p.bindJson<DeleteSetCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}

public func updateSetHandler(p: TeaContext): Unit {
    let command = p.bindJson<UpdateSetCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}