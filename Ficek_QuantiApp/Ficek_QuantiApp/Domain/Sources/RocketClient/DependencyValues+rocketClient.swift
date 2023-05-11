import Foundation
import Dependencies

extension DependencyValues {
  public var rocketClient: RocketClient {
    get { self[RocketClient.self] }
    set { self[RocketClient.self] = newValue }
  }
}
