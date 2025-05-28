package list_api.commands

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
public class DeleteListCommandValidator <: AbstractValidator<DeleteListCommand> {
    public DeleteListCommandValidator(
        identityService: IIdentityService,
        queryService: IListQueryService
    ) {
        @NVRuleFor({p => p.id}).must {id => queryService.get(id).status == Success}.withMessage("List not found")
    }
}