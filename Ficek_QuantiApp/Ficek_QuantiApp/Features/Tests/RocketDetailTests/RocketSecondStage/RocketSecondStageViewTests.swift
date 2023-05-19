import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketDetail
import RocketClient
import UIToolkit

@MainActor
final class RocketSecondStageViewTests: XCTestCase {
  
  func test_viewState_init_rocketSecondStage() async {
    let store = Store(
      initialState: RocketSecondStageCore.State(rocket: .mock),
      reducer: RocketSecondStageCore()
    )
    
    let view = RocketSecondStageView(store: store)
    let viewStore = view.viewStore
    
    XCTAssertNoDifference(viewStore.burnTimeSecondSt, .secondsBurnTime(Rocket.mock.secondStage.burnTimeSEC ?? 0))
    XCTAssertNoDifference(viewStore.fuelAmmountSecondSt, "\(Rocket.mock.secondStage.fuelAmountTons ?? 0) tons of fuel")
    XCTAssertNoDifference(viewStore.enginesSecondSt, .engines(Rocket.mock.secondStage.engines ?? 0))
    XCTAssertNoDifference(viewStore.reusableSecondSt, Rocket.mock.secondStage.reusable ?? false ? .reusable : .notReusable)
    
    let store2 = Store(
      initialState: RocketSecondStageCore.State(rocket: .mock2),
      reducer: RocketSecondStageCore()
    )
    
    let view2 = RocketSecondStageView(store: store2)
    let viewStore2 = view2.viewStore
   
    XCTAssertNoDifference(viewStore2.burnTimeSecondSt, .secondsBurnTime(Rocket.mock2.secondStage.burnTimeSEC ?? 0))
    XCTAssertNoDifference(viewStore2.fuelAmmountSecondSt, "\(Rocket.mock2.secondStage.fuelAmountTons ?? 0) tons of fuel")
    XCTAssertNoDifference(viewStore2.enginesSecondSt, .engines(Rocket.mock2.secondStage.engines ?? 0))
    XCTAssertNoDifference(viewStore2.reusableSecondSt, Rocket.mock2.secondStage.reusable ?? false ? .reusable : .notReusable)
  }
}
