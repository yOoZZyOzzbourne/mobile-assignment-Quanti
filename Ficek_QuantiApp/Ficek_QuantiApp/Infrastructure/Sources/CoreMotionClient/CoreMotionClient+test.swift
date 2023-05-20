import Foundation
import CoreMotion
import Dependencies
import XCTestDynamicOverlay

extension CoreMotionClient: TestDependencyKey {
  public static let testValue = CoreMotionClient(
    xRotationRate: unimplemented("\(Self.self).xRotationRate")
  )
}
