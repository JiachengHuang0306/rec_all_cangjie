package masked_text_list_api.services

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// dapr_cangjie_sdk
import dapr_cangjie_sdk.client.*

// others
import std.database.sql.*

@NIService
public class DatabaseConnectionProvider <: IDatabaseConnectionProvider{
    private let datasource: Datasource

    public DatabaseConnectionProvider(daprClient: DaprClient){
        let driver = DriverManager.getDriver("mysql") ?? throw Exception("no mysql driver")
        let connectionString = daprClient.getSecret("recall-secretstore", "ConnectionStrings:MaskedTextListDb")["ConnectionStrings:MaskedTextListDb"]
        datasource = driver.open(connectionString, [("database", "maskedTextListDb"), ("prepare.mode", "server")])
    }

    public func getConnection():Connection{
        return datasource.connect()
    }
}
