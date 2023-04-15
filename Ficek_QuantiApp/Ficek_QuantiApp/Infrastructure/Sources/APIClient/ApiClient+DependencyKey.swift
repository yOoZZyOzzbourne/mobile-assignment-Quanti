import Foundation
import Dependencies
import RequestBuilderClient
import Networking
import NetworkMonitoring

extension APIClient: DependencyKey {
    public static var liveValue: APIClient {
        return Self(
            request: { request in
                return request.execute(
                    using:
                        NetworkClient(
                            urlRequester: .live(urlSessionConfiguration: .default),
                            networkMonitorClient: .live(onQueue: DispatchQueue.main)
                        ) 
                )
            }
        )
    }
    
    public static var testValue: APIClient {
        return Self(
            request: unimplemented("\(Self.self).request")
        )
    }
}
