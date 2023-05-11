import Foundation
import Dependencies

public struct CoreMotionClient {
  public var xRotationRate: (OperationQueue) async throws -> AsyncThrowingStream<Double, Error>
}

