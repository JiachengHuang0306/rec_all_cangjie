package text_list_api.commands

// naivemediator
import naivemediator.abstractions.*
import naivemediator.macros.*

// naiveserviceresult
import naiveserviceresult.*

// others
import cjjson.*
import cjjson.macros.*

@NMIRequest[@sourcePackage(), TypedServiceResult<String>]
@JsonAdapter
public class CreateTextItemCommand{
    public var content: String = ""

}