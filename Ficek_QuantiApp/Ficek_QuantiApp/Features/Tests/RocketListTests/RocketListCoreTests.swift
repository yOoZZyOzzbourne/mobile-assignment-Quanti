import Foundation
import XCTest
import ComposableArchitecture
import Combine
import XCTestDynamicOverlay
import RocketClient
import RocketList
import RocketDetail
import Networking

@MainActor
final class RocketListCoreTests: XCTestCase {
  let store = TestStore(
    initialState: RocketListCore.State(),
    reducer: RocketListCore()
  )
  
  func test_rocket_fetch_successful() async {
    await store.send(.fetchAsync(.success([Rocket].mock))) {
      $0.rocketItems = IdentifiedArrayOf(
        uniqueElements: [Rocket].mock.map { RocketDetailCore.State(rocket: $0) }
      )
    }
    
    await store.send(.fetchAsync(.failure(NetworkError.timeoutError))) {
      $0.alert = .errorAlert(error: NetworkError.timeoutError)
    }
    
    await store.send(.alertCancelTapped) {
      $0.alert = nil
    }
    
    await store.send(.fetchCombine(.failure(.networkError))) {
      $0.alert = .errorAlert(error: RocketError.networkError)
    }
    
    await store.send(.fetchCombine(.success([Rocket].mockTest))) {
      $0.rocketItems = IdentifiedArrayOf(
        uniqueElements: [Rocket].mockTest.map { RocketDetailCore.State(rocket: $0) }
      )
    }
  }
  
  func test_data_flow_success() async {
//MARK: ConcurrencyTest
    store.dependencies.rocketClient.fetchAllRocketsAsync = {
      [Rocket].mock
    }
    var clock = TestClock()
    store.dependencies.continuousClock = clock
    await store.send(.onAppear)
    await clock.advance(by: .seconds(5))

    await store.receive(.fetchAsync(.success([Rocket].mock))) {
      $0.rocketItems = IdentifiedArrayOf(
        uniqueElements: [Rocket].mock.map { RocketDetailCore.State(rocket: $0) }
      )
    }
//MARK: CombineTest
//    store.dependencies.rocketClient.fetchAllRocketsCombine = {
//      Just([Rocket].mock)
//        .setFailureType(to: RocketError.self)
//        .eraseToAnyPublisher()
//    }
//    store.dependencies.mainQueue = .immediate
//    await store.send(.onAppear)
//
//    await store.receive(.fetchCombine(.success([Rocket].mock))) {
//      $0.rocketItems = IdentifiedArrayOf(
//        uniqueElements: [Rocket].mock.map { RocketDetailCore.State(rocket: $0) }
//      )
//    }
  }
}
