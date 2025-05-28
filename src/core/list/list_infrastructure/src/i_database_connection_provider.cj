package list_infrastructure

import std.database.sql.*

public interface IDatabaseConnectionProvider {
    func getConnection(): Connection
}