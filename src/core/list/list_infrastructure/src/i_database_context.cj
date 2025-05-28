package list_infrastructure

// naiveseedwork
import naiveseedwork.*

import std.database.sql.*

public interface IDatabaseContext <: IUnitOfWork {
    func query(queryStatementProvider: (Connection) -> (Statement, Array<SqlDbType>)): QueryResult

    func update(updateStatementProvider: (Connection) -> (Statement, Array<SqlDbType>)): Unit

    prop transactionUuid: String

    prop hasActiveTransaction: Bool

    func beginTransaction(): Unit

    func commitTransaction(): Unit

    func rollBackTransaction(): Unit
}