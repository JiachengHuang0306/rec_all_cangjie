package list_api.queries

// naiveserviceresult
import naiveserviceresult.*

public interface ISetQueryService {
    func list(listId: Int64, skip: Int64, take: Int64): TypedServiceResult<Array<SetViewModel>>

    func get(id: Int64): TypedServiceResult<SetViewModel>
}