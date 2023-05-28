import Foundation
import Dependencies

public struct CoreMotionClient {
  public var yRotationRate: (OperationQueue) async throws -> AsyncThrowingStream<(Double, Double), Error>
}

