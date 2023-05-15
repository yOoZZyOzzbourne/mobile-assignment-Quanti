import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketDetail
import RocketClient
import UIToolkit

@MainActor
final class RocketFirstStageViewTests: XCTestCase {
  
  func test_viewState_init_rocketFirstStage() async {
    let store = Store(
      initialState: RocketFirstStageCore.State(rocket: .mock),
      reducer: RocketFirstStageCore()
    )
    
    let view = RocketFirstStageView(store: store)
    let viewStore = view.viewStore
    
    XCTAssertNoDifference(viewStore.burnTimeFirstSt, .secondsBurnTime(Rocket.mock.firstStage.burnTimeSEC ?? 0))
    XCTAssertNoDifference(viewStore.fuelAmmountFirstSt, "\(Rocket.mock.firstStage.fuelAmountTons ?? 0) tons of fuel")
    XCTAssertNoDifference(viewStore.enginesFirstSt, .engines(Rocket.mock.firstStage.engines ?? 0))
    XCTAssertNoDifference(viewStore.reusableFirstSt, Rocket.mock.firstStage.reusable ?? false ? .reusable : .notReusable)
    
    let store2 = Store(
      initialState: RocketFirstStageCore.State(rocket: .mock2),
      reducer: RocketFirstStageCore()
    )
    
    let view2 = RocketFirstStageView(store: store2)
    let viewStore2 = view2.viewStore
   
    XCTAssertNoDifference(viewStore2.burnTimeFirstSt, .secondsBurnTime(Rocket.mock2.firstStage.burnTimeSEC ?? 0))
    XCTAssertNoDifference(viewStore2.fuelAmmountFirstSt, "\(Rocket.mock2.firstStage.fuelAmountTons ?? 0) tons of fuel")
    XCTAssertNoDifference(viewStore2.enginesFirstSt, .engines(Rocket.mock2.firstStage.engines ?? 0))
    XCTAssertNoDifference(viewStore2.reusableFirstSt, Rocket.mock2.firstStage.reusable ?? false ? .reusable : .notReusable)
  }
}
