import Foundation
import Dependencies

extension DependencyValues {
  public var coreMotionClient: CoreMotionClient {
    get { self[CoreMotionClient.self] }
    set { self[CoreMotionClient.self] = newValue }
  }
}

