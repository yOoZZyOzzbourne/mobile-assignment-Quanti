import Foundation
import Dependencies
import Combine
import Networking
import NetworkMonitoring
import RequestBuilder
import ModelConvertible
import ErrorReporting
import NetworkClientDependency
import Clocks
import CombineSchedulers

extension RocketClient: DependencyKey {
  
  public static var liveValue: RocketClient {
    @Dependency(\.networkClient) var networkClient
    @Dependency(\.rocketsConverter) var converter
    @Dependency(\.continuousClock) var clock
    
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
        //This can be commented, only for testing Swift-Clocks
        try await clock.sleep(for: .seconds(5))
        
        return result
      }
    )
  }
}
