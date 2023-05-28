import Foundation
import CoreMotion
import Dependencies
import XCTestDynamicOverlay

extension CoreMotionClient: DependencyKey {
  @MainActor
  public static var liveValue: CoreMotionClient {
    let motionManager = CMMotionManager()
    
    return Self(
      yRotationRate: { queue in
        AsyncThrowingStream<(Double, Double), Error> { continuation in
          motionManager.gyroUpdateInterval = 1/60
          motionManager.startGyroUpdates(to: queue) { gyroData, error in
            if let gyroData {
              continuation.yield((gyroData.rotationRate.y, gyroData.rotationRate.x))
            } else if let error {
              continuation.finish(throwing: error)
            }
          }
          continuation.onTermination = { _ in motionManager.stopGyroUpdates() }
        }
      }
    )
  }
}
