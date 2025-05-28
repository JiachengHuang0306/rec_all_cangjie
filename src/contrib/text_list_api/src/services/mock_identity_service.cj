package text_list_api.services

import naiveioc.macros.*

@NIService
public class MockIdentityService <: IIdentityService {
    public MockIdentityService() {}

    public func getUserIdentityGuid(): String {
        return "04be6c0f-205b-487e-89ad-8aebb11b32f1"
    }
}