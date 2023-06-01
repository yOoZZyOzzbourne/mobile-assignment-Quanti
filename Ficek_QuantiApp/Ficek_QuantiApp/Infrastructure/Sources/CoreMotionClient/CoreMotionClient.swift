import Foundation
import Dependencies

public struct CoreMotionClient {
  public var rotationRate: (OperationQueue) async throws -> AsyncThrowingStream<(Double, Double, Double), Error>
}

