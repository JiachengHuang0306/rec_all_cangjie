package text_list_api

import text_list_api.handlers.*
import text_list_api.services.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivemediator
import naivemediator.abstractions.*
import naivemediator.macros.*

// naiveteaset
import naiveteaset.*
import naiveteaset.dapr_cangjie_sdk.*

//tea
import tea.*

main(): Int64 {
    let tea = Tea.default()

    tea.use(globalExceptionHandler)

    tea.useNaiveIoc{
        services => services |> useDaprClient |> 
            addCustomLogger |> 
            addCustomApplicationServices |> 
            addCustomMediator
    }

    tea |> mapHandlers |> mapTopicHandlers

    
    tea.run(8080)

    return 0
}