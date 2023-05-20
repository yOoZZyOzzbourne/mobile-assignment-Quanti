import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketDetail
import RocketClient

@MainActor
final class RocketDetailViewTests: XCTestCase {
  
  func test_viewState_init_rocketDetail() async {
    let store = Store(
      initialState: RocketDetailCore.State(rocket: .mock),
      reducer: RocketDetailCore()
    )

    let view = RocketDetailView(store: store)
    let viewStore = view.viewStore
    
    XCTAssertNoDifference(viewStore.name, Rocket.mock.name)
    XCTAssertNoDifference(viewStore.firstFlight, "First flight: \(Rocket.mock.firstFlight)")
    
    let store2 = Store(
      initialState: RocketDetailCore.State(rocket: .mock2),
      reducer: RocketDetailCore()
    )
    
    let view2 = RocketDetailView(store: store2)
    let viewStore2 = view2.viewStore
    
    XCTAssertNoDifference(viewStore2.name, Rocket.mock2.name)
    XCTAssertNoDifference(viewStore2.firstFlight, "First flight: \(Rocket.mock2.firstFlight)")
  }
}
