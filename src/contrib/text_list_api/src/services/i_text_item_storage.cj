package text_list_api.services

// naiveserviceresult
import naiveserviceresult.*

public interface ITextItemStorage{
    func add(content: String): TypedServiceResult<String>

    func updateContent(id: Int64, content: String): ServiceResult

    func remove(id: Int64): ServiceResult

    func updateItemId(id: Int64, itemId: Int64): ServiceResult
    
}