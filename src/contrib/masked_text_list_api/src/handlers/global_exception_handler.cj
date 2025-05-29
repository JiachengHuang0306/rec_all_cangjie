package masked_text_list_api.handlers

// naiveserviceresult
import naiveserviceresult.*

// tea
import tea.*

public func globalExceptionHandler(context: TeaContext): Unit {
    try{
        context.next()
    } catch(e: Exception){
        e.printStackTrace()
        context.json(200, ServiceResult.exception(e).toViewModel())
    }
}