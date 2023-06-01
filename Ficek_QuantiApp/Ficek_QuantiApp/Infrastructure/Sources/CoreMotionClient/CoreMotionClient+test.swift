import Foundation
import CoreMotion
import Dependencies
import XCTestDynamicOverlay

extension CoreMotionClient: TestDependencyKey {
  public static let testValue = CoreMotionClient(
    rotationRate: unimplemented("\(Self.self).xRotationRate")
  )
}
