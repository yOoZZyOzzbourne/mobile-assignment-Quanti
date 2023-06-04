import Foundation
import Dependencies

//MARK: Helpful struct Coordinates for easier manipulation with CoreMotion
public struct Coordinates: Equatable {
    public var x: Double
    public var y: Double
    public var z: Double
  
  public init(
    x: Double,
    y: Double,
    z: Double
  ) {
    self.x = x
    self.y = y
    self.z = z
  }
}
