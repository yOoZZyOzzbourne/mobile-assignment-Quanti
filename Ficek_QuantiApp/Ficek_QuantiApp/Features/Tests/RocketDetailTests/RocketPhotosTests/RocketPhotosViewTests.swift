import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketDetail
import RocketClient

@MainActor
final class RocketPhotosViewTests: XCTestCase {
  
  func test_viewState_init_rocketPhotos() async {
    let store = Store(
      initialState: RocketPhotosCore.State(rocket: .mock),
      reducer: RocketPhotosCore()
    )
    
    let view = RocketPhotosView(store: store)
    let viewStore = view.viewStore
    
    XCTAssertNoDifference(viewStore.rocketImages, Rocket.mock.flickrImages)
  
    let store2 = Store(
      initialState: RocketPhotosCore.State(rocket: .mock2),
      reducer: RocketPhotosCore()
    )
    
    let view2 = RocketPhotosView(store: store2)
    let viewStore2 = view2.viewStore
    
    XCTAssertNoDifference(viewStore2.rocketImages, Rocket.mock2.flickrImages)
  }
}
