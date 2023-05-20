import Foundation
import Dependencies
import XCTest
import XCTestDynamicOverlay
import TestUtils
import Combine
import ComposableArchitecture
import ModelConvertible
@testable import RocketClient
import Networking

final class RocketRonverterTests: XCTestCase {
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
    let converter = withDependencies { _ in
    } operation: {
      DiameterConverterKey.liveValue
    }
    
    XCTAssertNoDifference(converter.domainModel(fromExternal: rocketDTO.diameter), rocket.diameter)
    XCTAssertNoDifference(converter.externalModel(fromDomain: rocket.diameter), rocketDTO.diameter)
  }
  
  func test_heightConverter_success() {
    let converter = withDependencies { _ in
    } operation: {
      HeightConverterKey.liveValue
    }
    
    XCTAssertNoDifference(converter.domainModel(fromExternal: rocketDTO.height), rocket.height)
    XCTAssertNoDifference(converter.externalModel(fromDomain: rocket.height), rocketDTO.height)
  }
  
  func test_massConverter_success() {
    let converter = withDependencies { _ in
    } operation: {
      MassConverterKey.liveValue
    }
    
    XCTAssertNoDifference(converter.domainModel(fromExternal: rocketDTO.mass), rocket.mass)
    XCTAssertNoDifference(converter.externalModel(fromDomain: rocket.mass), rocketDTO.mass)
  }
  
  func test_firstStageConverter_success() {
    let converter = withDependencies { dependency in
    } operation: {
      FirstStageConverterKey.liveValue
    }
    
    XCTAssertNoDifference(converter.domainModel(fromExternal: rocketDTO.firstStage), rocket.firstStage)
    XCTAssertNoDifference(converter.externalModel(fromDomain: rocket.firstStage), rocketDTO.firstStage)
  }
  
  func test_secondStageConverter_success() {
    let converter = withDependencies { dependency in
    } operation: {
      SecondStageConverterKey.liveValue
    }
    
    XCTAssertNoDifference(converter.domainModel(fromExternal: rocketDTO.secondStage), rocket.secondStage)
    XCTAssertNoDifference(converter.externalModel(fromDomain: rocket.secondStage), rocketDTO.secondStage)
  }
  
  func test_enginesConverter_success() {
    let converter = withDependencies { dependency in
    } operation: {
      EnginesConverterKey.liveValue
    }
    
    XCTAssertNoDifference(converter.domainModel(fromExternal: rocketDTO.engines), rocket.engines)
    XCTAssertNoDifference(converter.externalModel(fromDomain: rocket.engines), rocketDTO.engines)
  }
  
  func test_rocketConverter_success() {
    let converter = withDependencies { dependency in
    } operation: {
      RocketConverterKey.liveValue
    }
    
    XCTAssertNoDifference(converter.domainModel(fromExternal: rocketDTO), rocket)
    XCTAssertNoDifference(converter.externalModel(fromDomain: rocket), rocketDTO)
  }
  
  func test_rocketsConverter_success() {
    let converter = withDependencies { dependency in
      dependency.rocketConverter = .live()
    } operation: {
      RocketsConverterKey.liveValue
    }
    
    XCTAssertNoDifference(converter.domainModel(fromExternal: [RocketDTO].mock), [Rocket].mock)
    XCTAssertNoDifference(converter.externalModel(fromDomain: [Rocket].mock), [RocketDTO].mock)
  }
}
