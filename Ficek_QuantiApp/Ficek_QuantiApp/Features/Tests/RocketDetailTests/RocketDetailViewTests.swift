import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketDetail
import RocketClient

@MainActor
final class RocketDetailViewTests: XCTestCase {
  
  func test_viewState_init_rocketDetail() async {
    let viewStore = RocketDetailView.ViewState(state: .init(rocket: .mock))
    
    XCTAssertNoDifference(viewStore.name, Rocket.mock.name)
    XCTAssertNoDifference(viewStore.firstFlight, "First flight: \(Rocket.mock.firstFlight)")
    
    let viewStore2 = RocketDetailView.ViewState(state: .init(rocket: .mock2))
    
    XCTAssertNoDifference(viewStore2.name, Rocket.mock2.name)
    XCTAssertNoDifference(viewStore2.firstFlight, "First flight: \(Rocket.mock2.firstFlight)")
  }
}
