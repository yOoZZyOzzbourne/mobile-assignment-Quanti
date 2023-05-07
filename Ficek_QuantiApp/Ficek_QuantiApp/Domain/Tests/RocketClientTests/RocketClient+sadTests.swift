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
    
    func test_network_not_functioning() throws {
        let expectation = expectation(description: "Awaiting Success")
        var cancellables = Set<AnyCancellable>()
        var errorRecieved = false
        let urlResponse = URLResponse(
            url: URL(string:"https://api.spacexdata.com/v4/rockets")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        
        let sut = withDependencies { dependency in
            
            let mockUrlRequester = URLRequester { _ in
                 Just((Data(), urlResponse))
                    .setFailureType(to: URLError.self)
                    .eraseToAnyPublisher()
            }
            
            let failedNetworkClient = NetworkClient(
                urlRequester: mockUrlRequester,
                networkMonitorClient: .live(onQueue: .main)
            )
            
            dependency.networkClient = failedNetworkClient
        } operation: {
            RocketClient.liveValue
        }
        
        let result = sut.fetchAllRockets()
        
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
        
        waitForExpectations(timeout: 10)
        XCTAssertTrue(errorRecieved, "Error was not recieved")
        }
    
    func test_fail_convertor() throws {
        let expectation = expectation(description: "Awaiting Success")
        var cancellables = Set<AnyCancellable>()
        let successResponse = try JSONEncoder().encode([RocketDTO].mockTest)
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

       let sut = withDependencies { dependency in
            let networkClient = NetworkClient(
                urlRequester: mockUrlRequester,
                networkMonitorClient: .live(onQueue: .main)
            )
            
            dependency.networkClient = networkClient
        } operation: {
            RocketClient.liveValue
        }
        
       sut.fetchAllRockets()
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case let .failure(error):
                            if error.underlyingError is NetworkError {
                                XCTFail("Error shouldnt be networkError")
                            } else {
                                XCTFail("Shouldnt fail")
                            }
                        }
                        expectation.fulfill()
                        
                    }, receiveValue: { rocket in
                        XCTAssertNotEqual(rocket, [Rocket].mockTest)
                    }
                )
                .store(in: &cancellables)

            waitForExpectations(timeout: 10)
    }
  
  func test_network_not_functioning_async() async throws {
    var errorRecieved = false
    let urlResponse = URLResponse(
      url: URL(string:"https://api.spacexdata.com/v4/rockets")!,
      mimeType: nil,
      expectedContentLength: 0,
      textEncodingName: nil
    )
    
    let sut = withDependencies { dependency in
      
      let mockUrlRequester = URLRequester { _ in
        Just((Data(), urlResponse))
          .setFailureType(to: URLError.self)
          .eraseToAnyPublisher()
      }
      
      let failedNetworkClient = NetworkClient(
        urlRequester: mockUrlRequester,
        networkMonitorClient: .live(onQueue: .main)
      )
      
      dependency.networkClient = failedNetworkClient
    } operation: {
      RocketClient.liveValue
    }
    
    do {
      let _ = try await sut.fetchAsync()
    } catch is NetworkError {
      errorRecieved = true
    }
      XCTAssertTrue(errorRecieved, "Error was not recieved")
    }
  
  func test_fail_convertor_async() async throws {
      let successResponse = try JSONEncoder().encode([RocketDTO].mockTest)
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

     let sut = withDependencies { dependency in
          let networkClient = NetworkClient(
              urlRequester: mockUrlRequester,
              networkMonitorClient: .live(onQueue: .main)
          )
       
          dependency.networkClient = networkClient
      } operation: {
          RocketClient.liveValue
      }
      
    do {
      let _ = try await sut.fetchAsync()
    } catch {
       XCTFail("Test shouldnt fail")
    }
  }
}
