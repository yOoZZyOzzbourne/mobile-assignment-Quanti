import Foundation
import Dependencies

public struct CoreMotionClient {
   public let xRotationRate: (OperationQueue) async throws -> AsyncThrowingStream<Double, Error>
}

