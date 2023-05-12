import Foundation
import XCTest
import ComposableArchitecture
import Combine
import XCTestDynamicOverlay
import XCTestHelper
import RequestBuilder
@testable import Networking
@testable import RocketClient

final class RocketClientHappyTests: XCTestCase {
  var cancellables = Set<AnyCancellable>()
  
  var testScheduler: TestScheduler<
    DispatchQueue.SchedulerTimeType,
    DispatchQueue.SchedulerOptions
  >! = DispatchQueue.test
  
  override func invokeTest() {
    withDependencies {
      $0.heightConverter = .live()
      $0.enginesConverter = .live()
      $0.secondStageConverter = .live()
      $0.firstStageConverter = .live()
      $0.massConverter = .live()
      $0.diameterConverter = .live()
      $0.rocketConverter = .live()
      $0.rocketsConverter = .live()
    } operation: {
      super.invokeTest()
    }
  }
  
  func test_fetchAllRocketsCombine_sucessful() throws {
    let successResponse = try JSONEncoder().encode([RocketDTO].mock)
    let mockResponse = HTTPURLResponse(
      url: URL(string: "https://api.spacexdata.com/v4/rockets")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: [
        "\(HTTPHeaderName.acceptType.rawValue)": "\(AcceptTypeValue.json.rawValue)",
        "\(HTTPHeaderName.contentType.rawValue)": "\(ContentTypeValue.json.rawValue)"
      ]
    )
    
    let mockUrlRequester = URLRequester { _ in
      Just((successResponse, mockResponse!))
        .setFailureType(to: URLError.self)
        .eraseToAnyPublisher()
    }
    
    let networkClient = NetworkClient(
      urlRequester: mockUrlRequester,
      networkMonitorClient: .live(onQueue: .main)
    )
    
    let sut = withDependencies { dependency in
      dependency.networkClient = networkClient
    } operation: {
      RocketClient.liveValue
    }
    
    let result = try awaitPublisher(sut.fetchAllRocketsCombine())
    XCTAssertNoDifference(result, .mock)
  }
  
  
  func test_fetchAllRocketsAsync_sucessful() async throws {
    let successResponse = try JSONEncoder().encode([RocketDTO].mock)
    let mockResponse = HTTPURLResponse(
      url: URL(string: "https://api.spacexdata.com/v4/rockets")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: [
        "\(HTTPHeaderName.acceptType.rawValue)": "\(AcceptTypeValue.json.rawValue)",
        "\(HTTPHeaderName.contentType.rawValue)": "\(ContentTypeValue.json.rawValue)"
      ]
    )
    
    let mockUrlRequester = URLRequester { _ in
      Just((successResponse, mockResponse!))
        .setFailureType(to: URLError.self)
        .eraseToAnyPublisher()
    }
    
    let networkClient = NetworkClient(
      urlRequester: mockUrlRequester,
      networkMonitorClient: .live(onQueue: .main)
    )
    
    let sut = withDependencies { dependency in
      dependency.networkClient = networkClient
    } operation: {
      RocketClient.liveValue
    }
    
    let result = try await sut.fetchAllRocketsAsync()
    XCTAssertNoDifference(result, .mock)
  }
}
