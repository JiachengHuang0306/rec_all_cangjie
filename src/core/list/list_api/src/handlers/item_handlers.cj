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

public func createItemHandler(p: TeaContext): Unit {
    let command = p.bindJson<CreateItemCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}