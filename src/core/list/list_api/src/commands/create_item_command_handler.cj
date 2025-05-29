package list_api.commands

import list_domain.aggregate_models.item_aggregate.*
import list_api.integration_events.*
import list_api.queries.*
import list_api.services.*

import event_bus.abstractions.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// ginger
import ginger.*
import ginger.default.*

// others
import encoding.json.*
import net.http.*
import serialization.serialization.*
import std.io.*

@NIService
public class CreateItemCommandHandler <: IRequestHandler<CreateItemCommand, ServiceResult> {
    public CreateItemCommandHandler(
        private let contribUrlService: IContribUrlService,
        private let itemRepository: IItemRepository,
        private let setQueryService: ISetQueryService,
        private let identityService: IIdentityService,
        private let listIntegrationEventService: IListIntegrationEventService
    ) {}

    public func handle(request: CreateItemCommand): ServiceResult {
        let typeId = match (setQueryService.get(request.setId).result) {
            case Some(v) => v.typeId
            case None => throw Exception("this should not happen")
        }
        var contribUrl = "${contribUrlService.getContribUrl(typeId)}/item/create"
        let contribJson = request.contribJson.toJson().toJsonString()

        let httpResponse = post(contribUrl, body: RequestBody.of(contribJson))
        let result = httpResponse.readAs<TypedServiceResultViewModel<String>>()

        if (result.status != Success) {
            return result.toServiceResult()
        }

        let contribId = match (result.result) {
            case Some(v) => v
            case None => throw Exception("this should not happen")
        }

        let item = RecAllItem(typeId, request.setId, contribId, identityService.getUserIdentityGuid())
        itemRepository.add(item)
        if (!itemRepository.unitOfWork.saveEntities()) {
            ServiceResult.failure()
        }

        var itemIdAssignedIntegrationEvent = ItemIdAssignedIntegrationEvent(typeId, contribId, item.id)
        listIntegrationEventService.addAndSaveEvent(itemIdAssignedIntegrationEvent)

        return if (itemRepository.unitOfWork.saveEntities()) {
            ServiceResult.success()
        } else {
            ServiceResult.failure()
        }
    }
}