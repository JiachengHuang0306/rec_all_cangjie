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
public class DeleteTextItemCommandHandler <: IRequestHandler<DeleteTextItemCommand, ServiceResult> {
    public DeleteTextItemCommandHandler(private let textItemStorage: ITextItemStorage) {}

    public func handle(request: DeleteTextItemCommand): ServiceResult {
        return textItemStorage.remove(request.id)
    }
}