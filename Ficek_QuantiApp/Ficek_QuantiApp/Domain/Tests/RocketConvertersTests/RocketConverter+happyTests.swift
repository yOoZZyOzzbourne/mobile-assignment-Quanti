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

final class RocketRonverterHappyTests: XCTestCase {
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
    func test_diameterConverter_success() {
        
        let converter = withDependencies { dependency in
        } operation: {
            DiameterConverterKey.liveValue
        }
        
        let sut =
        Just(rocketDTO.diameter)
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        let result = try! awaitPublisher(sut)
        XCTAssertNoDifference(result, rocket.diameter)
        
        let sut2 =
        Just(rocket.diameter)
            .setFailureType(to: RocketError.self)
            .convertToExternalModel(using: converter)
            .eraseToAnyPublisher()
        
        let result2 = try! awaitPublisher(sut2)
        XCTAssertNoDifference(result2, rocketDTO.diameter)
    }
    
    func test_heightConverter_success() {
        let converter = withDependencies { dependency in
        } operation: {
            HeightConverterKey.liveValue
        }
        
        let sut =
        Just(rocketDTO.height)
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        let result = try! awaitPublisher(sut)
        XCTAssertNoDifference(result, rocket.height)
        
        let sut2 =
        Just(rocket.height)
            .setFailureType(to: RocketError.self)
            .convertToExternalModel(using: converter)
            .eraseToAnyPublisher()
        
        let result2 = try! awaitPublisher(sut2)
        XCTAssertNoDifference(result2, rocketDTO.height)
    }
    
    func test_massConverter_success() {
        let converter = withDependencies { dependency in
        } operation: {
            MassConverterKey.liveValue
        }
        
        let sut =
        Just(rocketDTO.mass)
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        let result = try! awaitPublisher(sut)
        XCTAssertNoDifference(result, rocket.mass)
        
        let sut2 =
        Just(rocket.mass)
            .setFailureType(to: RocketError.self)
            .convertToExternalModel(using: converter)
            .eraseToAnyPublisher()
        
        let result2 = try! awaitPublisher(sut2)
        XCTAssertNoDifference(result2, rocketDTO.mass)
    }
    
    func test_firstStageConverter_success() {
        let converter = withDependencies { dependency in
        } operation: {
            FirstStageConverterKey.liveValue
        }
        
        let sut =
        Just(rocketDTO.firstStage)
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        let result = try! awaitPublisher(sut)
        XCTAssertNoDifference(result, rocket.firstStage)
        
        let sut2 =
        Just(rocket.firstStage)
            .setFailureType(to: RocketError.self)
            .convertToExternalModel(using: converter)
            .eraseToAnyPublisher()
        
        let result2 = try! awaitPublisher(sut2)
        XCTAssertNoDifference(result2, rocketDTO.firstStage)
    }
    
    func test_secondStageConverter_success() {
        let converter = withDependencies { dependency in
        } operation: {
            SecondStageConverterKey.liveValue
        }
        
        let sut =
        Just(rocketDTO.secondStage)
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        let result = try! awaitPublisher(sut)
        XCTAssertNoDifference(result, rocket.secondStage)
        
        let sut2 =
        Just(rocket.secondStage)
            .setFailureType(to: RocketError.self)
            .convertToExternalModel(using: converter)
            .eraseToAnyPublisher()
        
        let result2 = try! awaitPublisher(sut2)
        XCTAssertNoDifference(result2, rocketDTO.secondStage)
    }
    
    func test_enginesConverter_success() {
        let converter = withDependencies { dependency in
        } operation: {
            EnginesConverterKey.liveValue
        }
        
        let sut =
        Just(rocketDTO.engines)
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        let result = try! awaitPublisher(sut)
        XCTAssertNoDifference(result, rocket.engines)
        
        let sut2 =
        Just(rocket.engines)
            .setFailureType(to: RocketError.self)
            .convertToExternalModel(using: converter)
            .eraseToAnyPublisher()
        
        let result2 = try! awaitPublisher(sut2)
        XCTAssertNoDifference(result2, rocketDTO.engines)
    }

    func test_rocketConverter_success() {
        let converter = withDependencies { dependency in
        } operation: {
            RocketConverterKey.liveValue
        }
        
        let sut =
        Just(rocketDTO)
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        let result = try! awaitPublisher(sut)
        XCTAssertNoDifference(result, rocket)
        
        let sut2 =
        Just(rocket)
            .setFailureType(to: RocketError.self)
            .convertToExternalModel(using: converter)
            .eraseToAnyPublisher()
        
        let result2 = try! awaitPublisher(sut2)
        XCTAssertNoDifference(result2, rocketDTO)
    }
    
    func test_rocketsConverter_success() {
        let converter = withDependencies { dependency in
            dependency.rocketConverter = .live()
        } operation: {
            RocketsConverterKey.liveValue
        }
        
        let sut =
        Just([RocketDTO].mock)
            .setFailureType(to: RocketError.self)
            .convertToDomainModel(using: converter)
            .eraseToAnyPublisher()
        
        let result = try! awaitPublisher(sut)
        XCTAssertNoDifference(result, [Rocket].mock)
        
        let sut2 =
        Just([Rocket].mock)
            .setFailureType(to: RocketError.self)
            .convertToExternalModel(using: converter)
            .eraseToAnyPublisher()
        
        let result2 = try! awaitPublisher(sut2)
        XCTAssertNoDifference(result2, [RocketDTO].mock)
    }
}
