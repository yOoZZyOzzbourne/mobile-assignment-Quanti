import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketDetail
import RocketClient

@MainActor
final class RocketParametersViewTests: XCTestCase {
  
  func test_viewState_init_rocketParameters() async {
    let viewStore = RocketParametersView.ViewState(state: .init(rocket: .mock))
    
    XCTAssertNoDifference(viewStore.name, Rocket.mock.name)
    XCTAssertNoDifference(viewStore.description, Rocket.mock.description)
    XCTAssertNoDifference(viewStore.mass, "\((Rocket.mock.mass.kg ?? 1000) / 1000)t")
    XCTAssertNoDifference(viewStore.diameter, "\(Int(round(Rocket.mock.diameter.meters ?? 0)))m")
    XCTAssertNoDifference(viewStore.height, "\(Int(round(Rocket.mock.height.meters ?? 0)))m")
  
    let viewStore2 = RocketParametersView.ViewState(state: .init(rocket: .mock2))
    
    XCTAssertNoDifference(viewStore2.name, Rocket.mock2.name)
    XCTAssertNoDifference(viewStore2.description, Rocket.mock2.description)
    XCTAssertNoDifference(viewStore2.mass, "\((Rocket.mock2.mass.kg ?? 1000) / 1000)t")
    XCTAssertNoDifference(viewStore2.diameter, "\(Int(round(Rocket.mock2.diameter.meters ?? 0)))m")
    XCTAssertNoDifference(viewStore2.height, "\(Int(round(Rocket.mock2.height.meters ?? 0)))m")
  }
}
