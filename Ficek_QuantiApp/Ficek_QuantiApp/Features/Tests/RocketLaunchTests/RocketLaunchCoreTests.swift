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
    store.dependencies.coreMotionClient.rotationRate = { que in
      AsyncThrowingStream<Coordinates, Error> { continuation in
        continuation.yield(Coordinates(x: 2, y: 2, z: 2))
        continuation.finish()
      }
    }
    
    await store.send(.flying(Coordinates(x: 0, y: 0, z: 0)))
    await store.send(.flying(Coordinates(x: 2, y: 0, z: 0)))
    await store.send(.onAppear)
    await store.receive(.flying(Coordinates(x: 2, y: 2, z: 2))) {
      $0.isFlying = true
    }
    
    await store.send(.flying(Coordinates(x: 0, y: 5, z: 0))) {
      $0.isFlying = true
      $0.positionX = -(5 * store.state.positionMultiplier)
    }
    
    await store.send(.flying(Coordinates(x: 0, y: 0, z: 5))) {
      $0.isFlying = true
      $0.positionZ = -5
    }
  }
}
