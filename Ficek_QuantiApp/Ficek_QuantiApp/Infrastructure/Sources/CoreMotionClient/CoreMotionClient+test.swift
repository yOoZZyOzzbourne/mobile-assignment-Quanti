import Foundation
import CoreMotion
import Dependencies
import XCTestDynamicOverlay

extension CoreMotionClient: TestDependencyKey {
  public static let testValue = CoreMotionClient(
    yRotationRate: unimplemented("\(Self.self).xRotationRate")
  )
}
