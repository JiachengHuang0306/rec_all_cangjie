package list_domain.aggregate_models

import naiveseedwork.*

public class ListType <: TypedEnumeration<ListType> & GetAll<ListType> {

    public static const TextId : Int64 = 1

    public static let Text: ListType = ListType(TextId,"TEXT".toAsciiLower(),"TEXT")

    public init(){}

    public init(id: Int64, name: String, displayName: String){
        super(id, name, displayName)
    }

    private static let listTypes: Array<ListType> = [Text]

    public static func getAll(): Array<ListType>{
        return listTypes
    }

}