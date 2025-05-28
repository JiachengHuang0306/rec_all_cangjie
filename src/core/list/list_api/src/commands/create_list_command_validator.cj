package list_api.commands

import list_domain.aggregate_models.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivevalidation
import naivevalidation.*
import naivevalidation.macros.*

@NIService
public class CreateListCommandValidator <: AbstractValidator<CreateListCommand> {
    public CreateListCommandValidator() {
        @NVRuleFor({p => p.typeId}).must {typeId => ListType.isValidValue(typeId)}.withMessage("invalid typeId")
    }
}