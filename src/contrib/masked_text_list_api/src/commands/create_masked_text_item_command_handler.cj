package masked_text_list_api.commands

import masked_text_list_api.services.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

@NIService
public class CreateMaskedTextItemCommandHandler <: IRequestHandler<CreateMaskedTextItemCommand, TypedServiceResult<String>>{
    public CreateMaskedTextItemCommandHandler(private let maskedTextItemStorage: IMaskedTextItemStorage){}

    public func handle(request: CreateMaskedTextItemCommand):TypedServiceResult<String>{
        return maskedTextItemStorage.add(request.content, request.maskedContent)
    }
}