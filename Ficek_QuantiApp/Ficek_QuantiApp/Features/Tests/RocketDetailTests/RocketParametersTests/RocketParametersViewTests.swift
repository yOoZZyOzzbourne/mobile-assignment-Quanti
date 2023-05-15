import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketDetail
import RocketClient

@MainActor
final class RocketParametersViewTests: XCTestCase {
  
  func test_viewState_init_rocketParameters() async {
    let store = Store(
      initialState: RocketParametersCore.State(rocket: .mock),
      reducer: RocketParametersCore()
    )
    
    let view = RocketParametersView(store: store)
    let viewStore = view.viewStore
    
    XCTAssertNoDifference(viewStore.name, Rocket.mock.name)
    XCTAssertNoDifference(viewStore.description, Rocket.mock.description)
    XCTAssertNoDifference(viewStore.mass, "\((Rocket.mock.mass.kg ?? 1000) / 1000)t")
    XCTAssertNoDifference(viewStore.diameter, "\(Int(round(Rocket.mock.diameter.meters ?? 0)))m")
    XCTAssertNoDifference(viewStore.height, "\(Int(round(Rocket.mock.height.meters ?? 0)))m")
  
    let store2 = Store(
      initialState: RocketParametersCore.State(rocket: .mock2),
      reducer: RocketParametersCore()
    )
    
    let view2 = RocketParametersView(store: store2)
    let viewStore2 = view2.viewStore
    
    XCTAssertNoDifference(viewStore2.name, Rocket.mock2.name)
    XCTAssertNoDifference(viewStore2.description, Rocket.mock2.description)
    XCTAssertNoDifference(viewStore2.mass, "\((Rocket.mock2.mass.kg ?? 1000) / 1000)t")
    XCTAssertNoDifference(viewStore2.diameter, "\(Int(round(Rocket.mock2.diameter.meters ?? 0)))m")
    XCTAssertNoDifference(viewStore2.height, "\(Int(round(Rocket.mock2.height.meters ?? 0)))m")
  }
}
