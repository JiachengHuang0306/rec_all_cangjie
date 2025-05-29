package masked_text_list_api.services

// naiveserviceresult
import naiveserviceresult.*

public interface IMaskedTextItemStorage{
    func add(content: String, maskedContent: String): TypedServiceResult<String>

    func updateContent(id: Int64, content: String, maskedContent: String): ServiceResult

    func remove(id: Int64): ServiceResult

    func updateItemId(id: Int64, itemId: Int64): ServiceResult
    
}