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
    
    await store.send(.fetchRockets(.failure(.networkError)))
    
    await store.send(.fetchRockets(.success([Rocket].mockTest))) {
      $0.rocketItems = IdentifiedArrayOf(
        uniqueElements: [Rocket].mockTest.map { RocketDetailCore.State(rocket: $0) }
      )
    }
  }
  
  func test_data_flow_success() async {
    store.dependencies.rocketClient.fetchAllRocketsAsync = {
      [Rocket].mock
    }
    await store.send(.onAppear)
    
    await store.receive(.fetchAsync(.success([Rocket].mock))) {
      $0.rocketItems = IdentifiedArrayOf(
        uniqueElements: [Rocket].mock.map { RocketDetailCore.State(rocket: $0) }
      )
    }
  }
}
