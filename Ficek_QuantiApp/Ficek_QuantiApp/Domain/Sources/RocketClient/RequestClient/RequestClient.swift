import Foundation
import Dependencies
import RequestBuilder
import Networking
import Combine

public struct RequestClient {
    public var execute: (NetworkClient) -> AnyPublisher<[RocketDTO], NetworkError>
    
    public init(execute: @escaping (NetworkClient) -> AnyPublisher<[RocketDTO], NetworkError>) {
        self.execute = execute
    }
}
