import Foundation
import Dependencies
import Combine
import Networking
import NetworkMonitoring
import RequestBuilder
import ModelConvertible
import ErrorReporting

extension RocketClient: DependencyKey {

    public static var liveValue: RocketClient {
        @Dependency(\.networkClient) var networkClient
        @Dependency(\.requestClient) var requestClient
        
        return Self(
            fetchAllRockets: {
                
                let converter = RocketsConverter.live(
                    rocketConverter: .live(
                        massConverter: .live(),
                        secondStageConverter: .live(),
                        firstStageConverter: .live(),
                        enginesConverter: .live(),
                        diameterConverter: .live()
                    )
                )
//                let request = Request(
//                    endpoint: Self.RocketRequest.allRockets.rawValue
//                )
//
//                return request
//                    .execute(using: networkClient)
//                    .mapErrorReporting(to: RocketError(cause: .modelConvertibleError))
//                    .convertToDomainModel(using: converter)
//                    .eraseToAnyPublisher()
                
                return requestClient
                    .execute(networkClient)
                    .mapErrorReporting(to: RocketError() )
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
