import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketLaunch
import RocketClient

@MainActor
final class RocketDetailViewTests: XCTestCase {
  
  func test_viewState_init_rocketLaunch() async {
    let store = Store(
      initialState: RocketLaunchCore.State(),
      reducer: RocketLaunchCore()
    )

    let view = RocketLaunchView(store: store)
    let viewStore = view.viewStore
    
    XCTAssertNoDifference(viewStore.isFlying, false)
    XCTAssertNoDifference(viewStore.image, .rocketIdle)
    XCTAssertNoDifference(viewStore.launchText, "Lift the phone to launch the rocket")
  }
}
