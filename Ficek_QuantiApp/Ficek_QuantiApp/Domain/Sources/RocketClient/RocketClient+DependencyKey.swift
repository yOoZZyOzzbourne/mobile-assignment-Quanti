import Foundation
import ErrorForAlerts
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
//          .eraseToAnyPublisher()
      },
      //TODO: Naming
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
  
  public static let testValue = RocketClient(
    fetchAllRocketsCombine: unimplemented("\(Self.self).fetchAllRockets"),
    fetchAllRocketsAsync: unimplemented("\(Self.self).fetchAsync")
  )
  
  public static let previewValue = RocketClient(
    fetchAllRocketsCombine: {
      return Just([Rocket].mock)
        .setFailureType(to: RocketError.self)
        .eraseToAnyPublisher()
    },
    fetchAllRocketsAsync: {
      return [Rocket].mock
    }
  )
}

extension NetworkError: ModelConvertibleErrorCapable {
  public static var modelConvertibleError: NetworkError {
    .timeoutError
  }
}

extension NetworkError: ErrorHandlingConcurrency {
  public var causeUIDescription: String {
    switch cause {
    case .invalidResponse:
      return "Invalid response"
    case .urlError:
      return "Error with url"
    case .unauthorized:
      return "Bad credentials"
    case .clientError:
      return "Client error"
    case .serverError:
      return "Server error"
    case .noConnection:
      return "No connection"
    case .jsonDecodingError:
      return "Internal error"
    case .urlRequestBuilderError:
      return "Internal error"
    case .timeout:
      return "Timeout"
    }
  }
  
  public var causeName: String {
    switch cause {
    case .invalidResponse:
      return "Invalid response"
    case .urlError:
      return "Url error"
    case .unauthorized:
      return "Unauthorized"
    case .clientError:
      return "Client error"
    case .serverError:
      return "Server error"
    case .noConnection:
      return "No connection"
    case .jsonDecodingError:
      return "Json decoding error"
    case .urlRequestBuilderError:
      return "Url request error"
    case .timeout:
      return "Timeout"
    }
  }
}
