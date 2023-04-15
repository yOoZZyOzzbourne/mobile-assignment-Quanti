import Foundation
import Dependencies
import RequestBuilder

extension RequestBuilderClient: DependencyKey {
   public static var liveValue: RequestBuilderClient {
        
        return Self(
            rocketRequest: {
                return Request(
                    endpoint: "https://api.spacexdata.com/v4/rockets"
                )
            }
        )
    }
    
    public static var testValue: RequestBuilderClient {
        return Self(
            rocketRequest: unimplemented("\(Self.self).rocketRequest")
        )
    }
}
