import Foundation
import Dependencies
import XCTest
import XCTestDynamicOverlay
import XCTestHelper
import Combine
import ComposableArchitecture
import ModelConvertible
@testable import RocketClient
import Networking

final class RocketRonverterSadTests: XCTestCase {
    let rocketDTO = RocketDTO.mock
    let rocket = Rocket.mock
    
    override func invokeTest() {
        withDependencies {
            $0.heightConverter = .live()
            $0.enginesConverter = .live()
            $0.secondStageConverter = .live()
            $0.firstStageConverter = .live()
            $0.massConverter = .live()
            $0.diameterConverter = .live()
        } operation: {
          super.invokeTest()
        }
      }
    
    func test_diameterConverter_fail() {
        let expectation = expectation(description: "Awaiting Failure")
        var cancellables = Set<AnyCancellable>()
        var errorRecieved = false
        
        let converter = withDependencies { dependency in
        } operation: {
            DiameterConverterKey.liveValue
        }
        
        let sut =
        Just(DiameterDTO(meters: nil, feet: nil))
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        sut
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: XCTFail("Test should fail")
                    case let .failure(error):
                        if error.underlyingError is NetworkError {
                            XCTFail("Error shouldnt be networkError")
                        } else {
                            errorRecieved = true
                        }
                    }
                    expectation.fulfill()
                    
                }, receiveValue: { _ in }
            )
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        XCTAssertTrue(errorRecieved, "Error was not recieved")
    }
    
    func test_rocketConverter_fail() {
        let expectation = expectation(description: "Awaiting Failure")
        var cancellables = Set<AnyCancellable>()
        var errorRecieved = false
        
        let converter = withDependencies { dependency in
        } operation: {
            RocketConverterKey.liveValue
        }
        
        let sut =
        Just([RocketDTO].mockTest.first!)
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        sut
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: XCTFail("Test should fail")
                    case let .failure(error):
                        if error.underlyingError is NetworkError {
                            XCTFail("Error shouldnt be networkError")
                        } else {
                            errorRecieved = true
                        }
                    }
                    expectation.fulfill()
                    
                }, receiveValue: { _ in }
            )
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        XCTAssertTrue(errorRecieved, "Error was not recieved")
    }
}
