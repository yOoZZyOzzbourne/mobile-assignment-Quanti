//
//  RocketListCoreTests.swift
//  
//
//  Created by Martin Ficek on 10.04.2023.
//

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
    func testRocketListCore() async {
        let store = TestStore(
            initialState: RocketListCore.State(),
            reducer: RocketListCore()
        )
        
        await store.send(.fetchRockets(.success([Rocket].mock))) {
            $0.rocketItems = IdentifiedArrayOf(
                uniqueElements: [Rocket].mock.map { RocketDetailCore.State(rocket: $0) }
            )
        }
    }
}
