package text_list_api.commands

import text_list_api.services.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

@NIService
public class UpdateTextItemCommandHandler <: IRequestHandler<UpdateTextItemCommand, ServiceResult> {
    public UpdateTextItemCommandHandler(private let textItemStorage: ITextItemStorage) {}

    public func handle(request: UpdateTextItemCommand): ServiceResult {
        return textItemStorage.updateContent(request.id, request.content)
    }
}