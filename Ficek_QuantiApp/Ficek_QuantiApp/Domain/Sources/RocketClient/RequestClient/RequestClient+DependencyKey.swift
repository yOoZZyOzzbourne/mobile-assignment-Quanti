import Foundation
import Dependencies
import Networking
import RequestBuilder

extension RequestClient: DependencyKey {
    public static var liveValue: RequestClient {
        return Self(
            execute: { networkClient in
                Request(
                    endpoint: "https://api.spacexdata.com/v4/rockets"
                )
                .execute(using: networkClient)
            }
        )
    }
    
    public static var testValue = RequestClient (
        execute: unimplemented("\(Self.self).execute")
    )
}
