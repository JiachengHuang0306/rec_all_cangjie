package masked_text_list_api.commands

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
public class CreateMaskedTextItemCommand{
    public var content: String = ""
    public var maskedContent: String = ""
}