import Foundation
import Networking
import Dependencies

extension NetworkClient: TestDependencyKey {
  public static var testValue = NetworkClient(
    urlRequester: unimplemented("\(Self.self).urlRequester"),
    networkMonitorClient: unimplemented("\(Self.self).networkMonitorClient")
  )
}

