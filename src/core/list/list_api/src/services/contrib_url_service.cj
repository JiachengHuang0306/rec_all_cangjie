package list_api.services

import list_domain.aggregate_models.*

import naiveioc.macros.*

@NIService
public class ContribUrlService <: IContribUrlService {
    public ContribUrlService() {}

    public func getContribUrl(listTypeId: Int64): String {
        let route = if (listTypeId == ListType.TextId) {
            "text"
        } else {
            throw Exception("unknown list type id")
        }

        return "http://recall-envoygateway/${route}"
    }
}