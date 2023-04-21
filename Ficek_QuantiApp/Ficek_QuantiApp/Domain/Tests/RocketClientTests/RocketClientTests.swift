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
    
    func test_fetch_sucessful() throws {
        
        let sut = withDependencies { dependency in
            
            let testScheduler: TestScheduler<DispatchQueue.SchedulerTimeType, DispatchQueue.SchedulerOptions>!
            testScheduler = DispatchQueue.test
            
            let networkClient = NetworkClient(
                urlRequester: .live(urlSessionConfiguration: .default),
                networkMonitorClient: .mockJust(value: .available, delayedFor: 0, scheduler: testScheduler)
            )
            
            let requestClient = RequestClient { networkClient in
//                let mockHeaders = [
//                    HTTPHeader(name: "Content-Type",
//                               value: "application/json; charset=utf-8")
//                ]
//
//                let mockBody = try! JSONEncoder().encode([Rocket].mock)
                
                return Just([RocketDTO].mock)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            }
         
            dependency.networkClient = networkClient
            dependency.requestClient = requestClient
        } operation: {
            RocketClient.liveValue
        }
        
        let result = try awaitPublisher(sut.fetchAllRockets())
        XCTAssertNoDifference(result, [Rocket].mock)
    }
//
//    func test_fail_request_bad_decoding() throws {
//        let expectation = expectation(description: "Awaiting Failure")
//        var cancellables = Set<AnyCancellable>()
//
//        let sut = withDependencies {
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
//                    case .finished: XCTFail()
//                    case .failure(let error):
//                        XCTAssertEqual(error, .networkError)
//                    }
//                    expectation.fulfill()
//                }, receiveValue: { _ in }
//            )
//            .store(in: &cancellables)
//
//        waitForExpectations(timeout: 5)
//    }
}

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
