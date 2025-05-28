package list_api.commands

import list_domain.aggregate_models.set_aggregate.*
import list_api.queries.*
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
public class CreateSetCommandHandler <: IRequestHandler<CreateSetCommand, ServiceResult> {
    public CreateSetCommandHandler(
        private let setRepository: ISetRepository,
        private let listQueryService: IListQueryService,
        private let identityService: IIdentityService
    ) {}

    public func handle(request: CreateSetCommand): ServiceResult {
        let typeId = match (listQueryService.get(request.listId).result) {
            case Some(v) => v.typeId
            case None => throw Exception("this should not happen")
        }
        let set = RecAllSet(request.name, typeId, request.listId, identityService.getUserIdentityGuid())
        setRepository.add(set)
        return if (setRepository.unitOfWork.saveEntities()) {
            ServiceResult.success()
        } else {
            ServiceResult.failure()
        }
    }
}

@NIService
public class DeleteSetCommandHandler <: IRequestHandler<DeleteSetCommand, ServiceResult> {
    public DeleteSetCommandHandler(
        private let setRepository: ISetRepository,
        private let identityService: IIdentityService
    ) {}

    public func handle(request: DeleteSetCommand): ServiceResult {
        let set = match (setRepository.get(request.id)) {
            case Some(v) => v
            case None => return ServiceResult.invalidParameter("Set not found")
        }

        set.setDeleted()
        setRepository.update(set)
        return if (setRepository.unitOfWork.saveEntities()) {
            ServiceResult.success()
        } else {
            ServiceResult.failure()
        }
    }
}

@NIService
public class UpdateSetCommandHandler <: IRequestHandler<UpdateSetCommand, ServiceResult> {
    public UpdateSetCommandHandler(
        private let setRepository: ISetRepository,
        private let identityService: IIdentityService
    ) {}

    public func handle(request: UpdateSetCommand): ServiceResult {
        let set = match (setRepository.get(request.id)) {
            case Some(v) => v
            case None => return ServiceResult.invalidParameter("Set not found")
        }

        set.setName(request.name)
        setRepository.update(set)
        return if (setRepository.unitOfWork.saveEntities()) {
            ServiceResult.success()
        } else {
            ServiceResult.failure()
        }
    }
}