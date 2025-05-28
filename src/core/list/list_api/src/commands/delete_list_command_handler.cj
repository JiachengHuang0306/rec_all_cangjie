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
public class DeleteListCommandHandler <: IRequestHandler<DeleteListCommand, ServiceResult> {
    public DeleteListCommandHandler(
        private let listRepository: IListRepository,
        private let identityService: IIdentityService
    ) {}

    public func handle(request: DeleteListCommand): ServiceResult {
        let list = match (listRepository.get(request.id)) {
            case Some(v) => v
            case None => return ServiceResult.invalidParameter("List not found")
        }

        list.setDeleted()
        listRepository.update(list)
        return if (listRepository.unitOfWork.saveEntities()) {
            ServiceResult.success()
        } else {
            ServiceResult.failure()
        }
    }
}