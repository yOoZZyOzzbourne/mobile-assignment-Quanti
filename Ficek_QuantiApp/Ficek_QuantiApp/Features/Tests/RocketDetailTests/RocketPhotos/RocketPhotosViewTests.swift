import Foundation
import XCTest
import ComposableArchitecture
import SwiftUI
import RocketDetail
import RocketClient

@MainActor
final class RocketPhotosViewTests: XCTestCase {
  
  func test_viewState_init_rocketPhotos() async {
    let viewStore = RocketPhotosView.ViewState(state: .init(rocket: .mock))
    
    XCTAssertNoDifference(viewStore.rocketImages, Rocket.mock.flickrImages)
  
    let viewStore2 = RocketPhotosView.ViewState(state: .init(rocket: .mock2))
    
    XCTAssertNoDifference(viewStore2.rocketImages, Rocket.mock2.flickrImages)
  }
}
