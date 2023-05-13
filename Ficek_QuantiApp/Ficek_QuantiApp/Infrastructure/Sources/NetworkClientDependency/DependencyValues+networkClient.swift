import Foundation
import Dependencies
import Networking

extension DependencyValues {
  public var networkClient: NetworkClient {
    get { self[NetworkClient.self] }
    set { self[NetworkClient.self] = newValue }
  }
}
