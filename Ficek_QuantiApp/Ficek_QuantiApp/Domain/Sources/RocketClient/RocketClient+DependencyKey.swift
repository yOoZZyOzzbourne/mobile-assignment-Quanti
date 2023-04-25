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
        
        return Self(
            fetchAllRockets: {
                
                let converter = RocketsConverter.live(
                    rocketConverter: .live(
                        massConverter: .live(),
                        secondStageConverter: .live(),
                        firstStageConverter: .live(),
                        enginesConverter: .live(),
                        diameterConverter: .live(),
                        heightConverter: .live()
                    )
                )
            //MARK: Should work witkout mapErrorReporting
//                return requestClient
//                    .execute(networkClient)
//                    .mapErrorReporting(to: RocketError(cause: <#RocketError.Cause#>) )
//                    .convertToDomainModel(using: converter)
//                    .eraseToAnyPublisher()
//
                let request = Request(
                    endpoint: Self.RocketRequest.allRockets.rawValue
                )

                return request
                    .execute(using: networkClient)
                   // .mapErrorReporting(to: RocketError(cause: .modelConvertibleError))
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
