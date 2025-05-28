package list_api

import list_api.handlers.*

// naiveteaset
import naiveteaset.*
import naiveteaset.dapr_cangjie_sdk.*

// tea
import tea.*

main(): Int64 {
    let tea = Tea.default()

    tea.use(globalExceptionHandler)

    tea.useNaiveIoc {
        services => services |> 
            useDaprClient |> 
            addCustomLogger |> 
            addCustomApplicationServices |> 
            addCustomMediator
    }

    tea.use(exceptionLoggerHandler)

    tea |> mapHandlers

    tea.run(8080)

    return 0
}