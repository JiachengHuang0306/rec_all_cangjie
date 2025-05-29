package list_api.commands

import list_domain.aggregate_models.*
import list_api.queries.*
import list_api.services.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivevalidation
import naivevalidation.*
import naivevalidation.macros.*

@NIService
public class CreateSetCommandValidator <: AbstractValidator<CreateSetCommand> {
    public CreateSetCommandValidator(listQueryService: IListQueryService) {
        @NVRuleFor({p => p.listId}).must {listId => listQueryService.get(listId).status == Success}.withMessage(
            "invalid listId")
    }
}

@NIService
public class DeleteSetCommandValidator <: AbstractValidator<DeleteSetCommand> {
    public DeleteSetCommandValidator(
        identityService: IIdentityService,
        queryService: ISetQueryService
    ) {
        @NVRuleFor({p => p.id}).must {id => queryService.get(id).status == Success}.withMessage("Set not found")
    }
}

@NIService
public class UpdateSetCommandValidator <: AbstractValidator<UpdateSetCommand> {
    public UpdateSetCommandValidator(
        identityService: IIdentityService,
        queryService: ISetQueryService
    ) {
        @NVRuleFor({p => p.id}).must {id => queryService.get(id).status == Success}.withMessage("Set not found")
    }
}