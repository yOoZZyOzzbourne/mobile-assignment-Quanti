import Foundation
import Dependencies

extension RocketClient: TestDependencyKey {
  public static let testValue = RocketClient(
    fetchAllRocketsCombine: unimplemented("\(Self.self).fetchAllRockets"),
    fetchAllRocketsAsync: unimplemented("\(Self.self).fetchAsync")
  )
}
