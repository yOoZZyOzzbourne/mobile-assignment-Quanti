import Foundation
import Dependencies
import Combine
import Networking
import NetworkMonitoring
import RequestBuilder
import ModelConvertible
import ErrorReporting
import NetworkClientDependency

extension RocketClient: DependencyKey {

    public static var liveValue: RocketClient {
        @Dependency(\.networkClient) var networkClient
        @Dependency(\.rocketsConverter) var converter
        
        return Self(
            fetchAllRockets: {
                
                let request = Request(
                    endpoint: Self.RocketRequest.allRockets.rawValue
                )

                return request
                    .execute(using: networkClient)
                    .convertToDomainModel(using: converter)
                    .eraseToAnyPublisher()
            }
        )
    }
    
    public static let testValue = RocketClient(
        fetchAllRockets: unimplemented("\(Self.self).fetchAllRockets")
    )
    
    public static let previewValue = RocketClient(
        fetchAllRockets: {
            return Just([Rocket].mock)
                .setFailureType(to: RocketError.self)
                .eraseToAnyPublisher()
        }
    )
}
