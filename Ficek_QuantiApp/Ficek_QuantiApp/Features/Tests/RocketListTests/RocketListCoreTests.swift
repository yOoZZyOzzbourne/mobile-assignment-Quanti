import Foundation
import XCTest
import ComposableArchitecture
import Combine
import XCTestDynamicOverlay
import RocketClient
import RocketList
import RocketDetail

@MainActor
final class RocketListCoreTests: XCTestCase {
    func test_rocket_fetch_successful() async {
        let store = TestStore(
            initialState: RocketListCore.State(),
            reducer: RocketListCore()
        )
        
//        await store.send(.fetchRockets(.success([Rocket].mock))) {
//            $0.rocketItems = IdentifiedArrayOf(
//                uniqueElements: [Rocket].mock.map { RocketDetailCore.State(rocket: $0) }
//            )
//        }
        
//        await store.send(.fetchAsync(.failure(RocketError.networkError))) {
//            $0.self.alert = .errorAlert(error: RocketError.networkError)
//        }
//    }
}
