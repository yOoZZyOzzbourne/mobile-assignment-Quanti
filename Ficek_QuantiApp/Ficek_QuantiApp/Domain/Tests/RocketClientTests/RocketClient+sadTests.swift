import Foundation
import XCTest
import ComposableArchitecture
import Combine
import XCTestDynamicOverlay
import XCTestHelper
import RequestBuilder
@testable import Networking
@testable import RocketClient

final class RocketClientSadTests: XCTestCase {
  var cancellables = Set<AnyCancellable>()

  func test_network_not_functioning_combine() throws {
    let expectation = expectation(description: "Awaiting Success")
    var cancellables = Set<AnyCancellable>()
    var errorRecieved = false
    let urlResponse = URLResponse(
      url: URL(string:"https://api.spacexdata.com/v4/rockets")!,
      mimeType: nil,
      expectedContentLength: 0,
      textEncodingName: nil
    )
    
    let mockUrlRequester = URLRequester { _ in
      Just((Data(), urlResponse))
        .setFailureType(to: URLError.self)
        .eraseToAnyPublisher()
    }
    
    let failedNetworkClient = NetworkClient(
      urlRequester: mockUrlRequester,
      networkMonitorClient: .live(onQueue: .main)
    )
    
    let sut = withDependencies { dependency in
      dependency.networkClient = failedNetworkClient
    } operation: {
      RocketClient.liveValue
    }
    
    let result = sut.fetchAllRocketsCombine()
    
    result
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished: XCTFail("Test should fail")
          case let .failure(error):
            if error.underlyingError is NetworkError {
              errorRecieved = true
              expectation.fulfill()
            } else {
              XCTFail("Error should be networkError")
            }
          }
          
        }, receiveValue: { _ in }
      )
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 0.1)
    XCTAssertTrue(errorRecieved, "Error was not recieved")
  }
  
  func test_fail_convertor_combine() throws {
    let expectation = expectation(description: "Awaiting Failure")
    var cancellables = Set<AnyCancellable>()
    let successResponse = try JSONEncoder().encode([RocketDTO].mock)
    var errorRecieved = false
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
    
    let rocketsConverter = RocketsConverter(
      externalModelConverter: { rocket in
        return nil
      }, domainModelConverter: { rocketDTO in
        return nil
      }
    )
    
    let sut = withDependencies { dependency in
      dependency.networkClient = networkClient
      dependency.rocketsConverter = rocketsConverter
    } operation: {
      RocketClient.liveValue
    }
    
    sut.fetchAllRocketsCombine()
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished: break
          case let .failure(error):
            if error.underlyingError is NetworkError {
              XCTFail("Error shouldnt be networkError")
            } else {
              errorRecieved = true
            }
          }
          expectation.fulfill()
          
        }, receiveValue: { rocket in
          XCTAssertNoDifference(rocket, [Rocket].mock)
        }
      )
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 0.1)
    XCTAssertTrue(errorRecieved, "Convertor passed")
  }
  
  func test_network_not_functioning_async() async throws {
    var errorRecieved = false
    let urlResponse = URLResponse(
      url: URL(string:"https://api.spacexdata.com/v4/rockets")!,
      mimeType: nil,
      expectedContentLength: 0,
      textEncodingName: nil
    )
    
    let mockUrlRequester = URLRequester { _ in
      Just((Data(), urlResponse))
        .setFailureType(to: URLError.self)
        .eraseToAnyPublisher()
    }
    
    let failedNetworkClient = NetworkClient(
      urlRequester: mockUrlRequester,
      networkMonitorClient: .live(onQueue: .main)
    )
    
    let sut = withDependencies { dependency in
      dependency.networkClient = failedNetworkClient
    } operation: {
      RocketClient.liveValue
    }
    
    do {
      let _ = try await sut.fetchAllRocketsAsync()
    } catch is NetworkError {
      errorRecieved = true
    }
    
    XCTAssertTrue(errorRecieved, "Error was not recieved")
  }
  
  func test_fail_convertor_async() async throws {
    let successResponse = try JSONEncoder().encode([RocketDTO].mockTest)
    var errorRecieved = false
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
    
    let rocketsConverter = RocketsConverter(
      externalModelConverter: { rocket in
        return nil
      }, domainModelConverter: { rocketDTO in
        return nil
      }
    )
    
    let sut = withDependencies { dependency in
      dependency.networkClient = networkClient
      dependency.rocketsConverter = rocketsConverter
    } operation: {
      RocketClient.liveValue
    }
    
    do {
      let _ = try await sut.fetchAllRocketsAsync()
    } catch {
      errorRecieved = true
    }
    
    XCTAssertTrue(errorRecieved, "Convertor passed")
  }
}
