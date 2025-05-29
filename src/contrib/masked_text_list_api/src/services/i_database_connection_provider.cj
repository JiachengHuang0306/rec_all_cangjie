package masked_text_list_api.services

import std.database.sql.*

public interface IDatabaseConnectionProvider{
    func getConnection():Connection
}