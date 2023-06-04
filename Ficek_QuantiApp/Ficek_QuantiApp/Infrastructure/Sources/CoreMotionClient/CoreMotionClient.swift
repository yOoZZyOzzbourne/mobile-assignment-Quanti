import Foundation
import Dependencies

public struct CoreMotionClient {
  public var rotationRate: (OperationQueue) async throws -> AsyncThrowingStream<Coordinates, Error>
}
