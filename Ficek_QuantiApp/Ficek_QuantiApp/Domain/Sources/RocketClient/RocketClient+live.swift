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
      fetchAllRocketsCombine: {
        let request = Request(
          endpoint: Self.RocketRequest.allRockets.rawValue
        )
        
        return request
          .execute(using: networkClient)
          .convertToDomainModel(using: converter)
      },
      fetchAllRocketsAsync: {
        let request = Request(
          endpoint: Self.RocketRequest.allRockets.rawValue
        )
        
        let data: [RocketDTO] = try await request.execute(using: networkClient)
        guard let result = converter.domainModel(fromExternal: data) else {
          throw NetworkError.invalidResponse
        }
        
        return result
      }
    )
  }
}
