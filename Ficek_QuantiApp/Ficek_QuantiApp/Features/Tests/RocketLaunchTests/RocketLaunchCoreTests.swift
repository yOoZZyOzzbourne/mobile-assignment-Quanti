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
    store.dependencies.coreMotionClient.RotationRate = { que in
      AsyncThrowingStream<(Double, Double), Error> { continuation in
        continuation.yield((2,2))
        continuation.finish()
      }
    }
    
    await store.send(.flying(0,0))
    await store.send(.flying(2,0))
    await store.send(.onAppear)
    await store.receive(.flying(2,2)) {
      $0.isFlying = true
    }
    
    await store.send(.flying(0,5)) {
      $0.isFlying = true
      $0.positionY = -(5 * store.state.positionMultiplier)
    }
    
    await store.send(.flying(5,0)) {
      $0.isFlying = true
      $0.positionX = (5 * store.state.positionMultiplier)
    }
  }
}
