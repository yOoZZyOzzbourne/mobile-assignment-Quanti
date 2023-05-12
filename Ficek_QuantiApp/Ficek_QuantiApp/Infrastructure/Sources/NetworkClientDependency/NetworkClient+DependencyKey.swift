import Foundation
import Networking
import Dependencies

extension NetworkClient: DependencyKey {
  public static var liveValue: NetworkClient {
    return Self(
      urlRequester: .live(urlSessionConfiguration: .default),
      networkMonitorClient: .live(onQueue: DispatchQueue.main)
    )
  }
  
  public static var testValue = NetworkClient(
    urlRequester: unimplemented("\(Self.self).urlRequester"),
    networkMonitorClient: unimplemented("\(Self.self).networkMonitorClient")
  )
}

