package list_domain.aggregate_models

// naiveseedwork
import naiveseedwork.*

public class ListType <: TypedEnumeration<ListType> & GetAll<ListType>{
    public static const TextId: Int64 = 1
    public static const MaskedTextId: Int64 = 2

    public static let Text: ListType = ListType(TextId, "TEXT".toAsciiLower(), "TEXT")
    public static let MaskedText: ListType = ListType(MaskedTextId, "MASKED_TEXT".toAsciiLower(), "MASKED_TEXT")

    public init(){}

    public init(id: Int64, name: String, displayName: String) {
        super(id, name, displayName)
    }

    private static let listTypes: Array<ListType> = [Text, MaskedText]

    public static func getAll(): Array<ListType> {
        return listTypes
    }
}