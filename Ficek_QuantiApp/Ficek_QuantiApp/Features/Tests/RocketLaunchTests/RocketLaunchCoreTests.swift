import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import CoreMotionClient
import RocketLaunch

@MainActor
final class RocketLaunchCoreTests: XCTestCase {
    @Dependency(\.coreMotionClient) var coreMotionClient

  func test_is_flying() async {
    let store = TestStore(
      initialState: RocketLaunchCore.State(),
      reducer: RocketLaunchCore()
    )
    
    await store.send(.flying(0))
    await store.send(.flying(3)) {
      $0.isFlying = true
    }
    }
}
