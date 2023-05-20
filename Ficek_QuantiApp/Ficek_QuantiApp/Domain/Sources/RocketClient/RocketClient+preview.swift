import Foundation
import Dependencies
import Combine
import Networking
import NetworkMonitoring
import RequestBuilder

extension RocketClient {
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
