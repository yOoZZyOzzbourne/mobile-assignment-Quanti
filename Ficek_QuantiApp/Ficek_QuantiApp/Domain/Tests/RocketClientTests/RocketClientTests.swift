import Foundation
import XCTest
import ComposableArchitecture
import Combine
import XCTestDynamicOverlay
import RocketClient
import Networking
import XCTestHelper
import RequestBuilder

final class RocketClientTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    var testScheduler: TestScheduler<
        DispatchQueue.SchedulerTimeType,
        DispatchQueue.SchedulerOptions
    >! = DispatchQueue.test
    
    func test_fetch_sucessful() throws {
        
        let sut = withDependencies { dependency in
            let networkClient = NetworkClient(
                urlRequester: .live(urlSessionConfiguration: .default),
                networkMonitorClient: .mockJust(
                    value: .available,
                    delayedFor: 0,
                    scheduler: testScheduler
                )
            )
            
            let requestClient = RequestClient { networkClient in
           
                return Just([RocketDTO].mock)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
                
//                let mockHeaders = [
//                    HTTPHeader(name: "Content-Type",
//                               value: "application/json; charset=utf-8")
//                ]
//                let mockBody = try! JSONEncoder().encode([Rocket].mock)
            }
            
            dependency.networkClient = networkClient
            dependency.requestClient = requestClient
        } operation: {
            RocketClient.liveValue
        }
        
        let result = try awaitPublisher(sut.fetchAllRockets())
        XCTAssertNoDifference(result, .mock)
    }
}
//
//    func test_fail_request_no_connection() throws {
//        let expectation = expectation(description: "Awaiting Failure")
//        var cancellables = Set<AnyCancellable>()
//        var errorRecieved = false
//        let urlResponse = URLResponse(url: URL(string:"")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
//
////        func req() -> (URLRequest) -> AnyPublisher<(Data,URLResponse), URLError> {
////            return Just((data: Data(), response: urlResponse))
////                .setFailureType(to: URLError.self)
////                .eraseToAnyPublisher()
////        }
////
//
//        let sut = withDependencies { dependencies in
//            let failedNetworkClient = NetworkClient(
//                urlRequester: URLRequester(request: req() ),
//                networkMonitorClient:
//                        .mockSequence(
//                            withValues: [.unavailable],
//                            onScheduler: testScheduler, every: 1
//                        )
//            )
//
//            dependencies.networkClient = failedNetworkClient
//            dependencies.requestClient = .liveValue
//
//        } operation: {
//            RocketClient.liveValue
//        }
//
//        let result = sut.fetchAllRockets()
//
//        result
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished: XCTFail("Test should fail")
//                    case let .failure(error):
//                        if let networkError = error.underlyingError as? NetworkError {
//                            switch networkError {
//                            case .noConnection:
//                                errorRecieved = true
//                                expectation.fulfill()
//
//                            default:
//                                XCTFail("Error wasnt .noConnection")
//                            }
//                        } else {
//                            XCTFail("Error should be networkError")
//                        }
//
//                    }
//
//                }, receiveValue: { _ in }
//            )
//            .store(in: &cancellables)
//
//        waitForExpectations(timeout: 10)
//        XCTAssertTrue(errorRecieved, "Error was not recieved")
//    }
//}

//extension NetworkClientType {
//    func request(_ urlRequest: URLRequest) -> AnyPublisher<(headers: [RequestBuilder.HTTPHeader], body: Data), Networking.NetworkError> {
//        let mockHeaders = [
//            HTTPHeader(name: "Content-Type",
//                       value: "application/json; charset=utf-8")
//        ]
//        
//        let mockBody = try! JSONEncoder().encode([Rocket].mock)
//
//        return Just<(headers: [HTTPHeader], body: Data)> (
//            (headers: mockHeaders, body: mockBody))
//        .setFailureType(to: NetworkError.self)
//        .eraseToAnyPublisher()
//    }
//}
