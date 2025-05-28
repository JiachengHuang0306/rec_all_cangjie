 package text_list_api.commands

import text_list_api.services.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

@NIService
public class CreateTextItemCommandHandler <: IRequestHandler<CreateTextItemCommand, TypedServiceResult<String>>{
    public CreateTextItemCommandHandler(private let textItemStorage: ITextItemStorage){}

    public func handle(request: CreateTextItemCommand):TypedServiceResult<String>{
        
        return textItemStorage.add(request.content)

    }
}