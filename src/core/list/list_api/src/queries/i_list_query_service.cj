package list_api.queries

// naiveserviceresult
import naiveserviceresult.*

public interface IListQueryService {
    func list(skip: Int64, take: Int64): TypedServiceResult<Array<ListViewModel>>

    func get(id: Int64): TypedServiceResult<ListViewModel>
}