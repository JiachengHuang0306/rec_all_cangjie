package list_api.services

import list_infrastructure.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// hellohilo
import hellohilo.*

// others
import std.database.sql.*

@NIService
public class HiLoConnectionProvider <: IHiLoConnectionProvider {
    public HiLoConnectionProvider(private let connectionProvider: IDatabaseConnectionProvider) {}

    public func getConnection(): Connection {
        return connectionProvider.getConnection()
    }
}