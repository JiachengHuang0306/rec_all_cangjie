package list_api.commands

import list_domain.aggregate_models.list_aggregate.*
import list_api.services.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

@NIService
public class CreateListCommandHandler <: IRequestHandler<CreateListCommand, ServiceResult> {
    public CreateListCommandHandler(
        private let identityService: IIdentityService,
        private let listRepository: IListRepository
    ) {}

    public func handle(request: CreateListCommand): ServiceResult {
        let list = RecAllList(request.name, request.typeId, identityService.getUserIdentityGuid())
        listRepository.add(list)
        return if (listRepository.unitOfWork.saveEntities()) {
            ServiceResult.success()
        } else {
            ServiceResult.failure()
        }
    }
}