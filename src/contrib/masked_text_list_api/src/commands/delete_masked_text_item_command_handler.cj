package masked_text_list_api.commands

import masked_text_list_api.services.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

@NIService
public class DeleteMaskedTextItemCommandHandler <: IRequestHandler<DeleteMaskedTextItemCommand, ServiceResult> {
    public DeleteMaskedTextItemCommandHandler(private let maskedTextItemStorage: IMaskedTextItemStorage) {}

    public func handle(request: DeleteMaskedTextItemCommand): ServiceResult {
        return maskedTextItemStorage.remove(request.id)
    }
}