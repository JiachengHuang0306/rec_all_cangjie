package list_infrastructure

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// others
import fakeuuid4cj.*
import std.collection.*
import std.database.sql.*

@NIService
public class DatabaseContext <: IDatabaseContext {
    private let connection: Connection
    private let updateStatements: ArrayList<(Statement, Array<SqlDbType>)> = ArrayList<(Statement, Array<SqlDbType>)>()

    public prop transactionUuid: String {
        get() {
            return _transactionUuid ?? throw Exception("call beginTransaction first")
        }
    }
    private var _transactionUuid: ?String = None
    private var transaction: ?Transaction = None

    public prop hasActiveTransaction: Bool {
        get() {
            return _transactionUuid.isSome()
        }
    }

    public DatabaseContext(connectionProvider: IDatabaseConnectionProvider) {
        connection = connectionProvider.getConnection()
    }

    public func query(queryStatementProvider: (Connection) -> (Statement, Array<SqlDbType>)): QueryResult {
        let p = queryStatementProvider(connection)
        return p[0].query(p[1])
    }

    public func update(updateStatementProvider: (Connection) -> (Statement, Array<SqlDbType>)): Unit {
        updateStatements.append(updateStatementProvider(connection))
    }

    public func saveEntities(): Bool {
        updateStatements |> forEach {p => p[0].update(p[1])}
        updateStatements.clear()
        return true
    }

    public func beginTransaction(): Unit {
        if (_transactionUuid.isSome()) {
            throw Exception("beginTransaction can only be called once per DatabaseContext instance")
        }

        _transactionUuid = generateFakeUuid()
        transaction = connection.createTransaction()
    }

    public func commitTransaction(): Unit {
        if (_transactionUuid.isNone()) {
            throw Exception("call beginTransaction first")
        }

        try {
            saveEntities()
            transaction.getOrThrow().commit()
        } catch (e: Exception) {
            rollBackTransaction()
            throw e
        }
    }

    public func rollBackTransaction(): Unit {
        if (_transactionUuid.isNone()) {
            throw Exception("call beginTransaction first")
        }

        try {
            transaction.getOrThrow().rollback()
        } finally {
        }
    }

    public func isClosed(): Bool {
        return connection.isClosed()
    }

    public func close(): Unit {
        connection.close()
    }
}