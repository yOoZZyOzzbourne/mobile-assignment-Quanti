import Foundation
import Dependencies
import Combine
import Networking
import NetworkMonitoring
import APIClient
import RequestBuilder

extension RocketClient: DependencyKey {
    
    public static var liveValue: RocketClient {
        
        @Dependency(\.apiClient) var apiClient
        @Dependency(\.requestBuilderClient) var requestBuilder
        
         return Self(
                 fetchAllRockets: {
                return apiClient.request(requestBuilder.rocketRequest())
                    .tryMap { (headers, body) -> Data in
                        guard headers["Content-Type"] == "application/json; charset=utf-8"
                        else {
                            throw NetworkError.invalidResponse
                        }
                        
                        return body
                    }
                    .decode(type: [Rocket].self, decoder: JSONDecoder()) //RocketDTO
                    .mapError { NetworkError -> RocketError in
                        return RocketError.networkError
                    }
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



