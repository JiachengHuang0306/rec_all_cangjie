package list_api.services

import list_infrastructure.*


// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// dapr_cangjie_sdk
import dapr_cangjie_sdk.client.*

import std.database.sql.*
import mysqlclient4cj.cdbc.*

@NIService
public class DatabaseConnectionProvider <: IDatabaseConnectionProvider & Resource {
    private let datasource: Datasource

    public DatabaseConnectionProvider(daprClient: DaprClient) {
        let driver = match (DriverManager.getDriver("mysql")) {
            case Some(v) => v
            case None => throw Exception("no mysql driver")
        }
        let connectionString = daprClient.getSecret("recall-secretstore", "ConnectionStrings:TextListDb")["ConnectionStrings:TextListDb"]
        datasource = driver.open(connectionString, [("database", "listDb"), ("prepare.mode", "server")])
    }

    public func getConnection(): Connection {
        return datasource.connect()
    }

    public func isClosed(): Bool {
        return datasource.isClosed()
    }

    public func close(): Unit {
        datasource.close()
    }
}