import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketDetail
import RocketClient
import RocketLaunch

@MainActor
final class RocketDetailCoreTests: XCTestCase {
  
  func test_data_flow_rocketDetail() async {
    let store = TestStore(
      initialState: RocketDetailCore.State(rocket: .mock),
      reducer: RocketDetailCore()
    )
    //RocketDetailState
    XCTAssertNoDifference(store.state.name, Rocket.mock.name)
    XCTAssertNoDifference(store.state.id, Rocket.mock.id)
    
    //RocketDetailChieldViews
    XCTAssertNoDifference(store.state.rocketFirstStage.rocket, store.state.rocket)
    XCTAssertNoDifference(store.state.rocketSecondStage.rocket, store.state.rocket)
    XCTAssertNoDifference(store.state.rocketPhotos.rocket, store.state.rocket)
    XCTAssertNoDifference(store.state.rocketParameters.rocket, store.state.rocket)
    
    //RocketDetailChild - RocketLaunch
    XCTAssertNoDifference(store.state.rocketLaunch, .init())
  }
}
