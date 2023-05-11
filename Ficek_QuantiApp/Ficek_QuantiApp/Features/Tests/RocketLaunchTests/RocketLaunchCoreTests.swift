import Foundation
import StoreKit
import XCTest
import ComposableArchitecture
import SwiftUI
import CoreMotionClient
import RocketLaunch
import CoreMotion

@MainActor
final class RocketLaunchCoreTests: XCTestCase {
    @Dependency(\.coreMotionClient) var coreMotionClient

  func test_data_flow_rocketLaunch() async {
    let store = TestStore(
      initialState: RocketLaunchCore.State(),
      reducer: RocketLaunchCore()
    )
    store.dependencies.coreMotionClient.xRotationRate = { que in
      AsyncThrowingStream<Double, Error> { continuation in
        continuation.yield(3.1)
        continuation.finish()
      }
    }
    
    await store.send(.flying(0))
    await store.send(.onAppear)
    await store.receive(.flying(3.1)) {
      $0.isFlying = true
    }
  }
}
