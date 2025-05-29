package masked_text_list_api.integration_events

import masked_text_list_api.services.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// others
import std.convert.*

@NIService
public class ItemIdAssignedIntegrationEventHandler <: IRequestHandler<ItemIdAssignedIntegrationEvent, ServiceResult> {
    public ItemIdAssignedIntegrationEventHandler(private let maskedTextItemStorage: IMaskedTextItemStorage) {}

    public func handle(request: ItemIdAssignedIntegrationEvent): ServiceResult {
        if (request.typeId != 2) {
            return ServiceResult.success()
        }
        return maskedTextItemStorage.updateItemId(
            Int64.tryParse(request.contribId) ?? throw Exception("cannot parse contribId"), request.itemId)
    }
} 