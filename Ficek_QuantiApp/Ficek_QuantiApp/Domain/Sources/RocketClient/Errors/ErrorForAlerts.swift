import Foundation
import ComposableArchitecture
import Networking

public protocol ErrorForAlerts: Error, CustomDebugStringConvertible, CustomStringConvertible {
  var causeUIDescription: String { get }
  var causeName: String { get }
}
