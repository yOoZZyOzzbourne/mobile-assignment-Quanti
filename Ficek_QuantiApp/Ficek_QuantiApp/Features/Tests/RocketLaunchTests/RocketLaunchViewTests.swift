import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketLaunch
import RocketClient

@MainActor
final class RocketLaunchViewTests: XCTestCase {
  
  func test_viewState_init_rocketLaunch() async {
    let viewStore = RocketLaunchView.ViewState(state: .init())
    
    XCTAssertNoDifference(viewStore.isFlying, false)
    XCTAssertNoDifference(viewStore.image, .rocketIdle)
    XCTAssertNoDifference(viewStore.launchText, "Lift the phone to launch the rocket")
    XCTAssertNoDifference(viewStore.positionX, 0)
    XCTAssertNoDifference(viewStore.positionY, 0)
  }
}
