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
public class UpdateMaskedTextItemCommandHandler <: IRequestHandler<UpdateMaskedTextItemCommand, ServiceResult> {
    public UpdateMaskedTextItemCommandHandler(private let maskedTextItemStorage: IMaskedTextItemStorage) {}

    public func handle(request: UpdateMaskedTextItemCommand): ServiceResult {
        return maskedTextItemStorage.updateContent(request.id, request.content, request.maskedContent)
    }
}