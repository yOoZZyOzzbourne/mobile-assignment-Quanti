import Foundation
import Dependencies
import Networking
import RequestBuilder
import Combine

public struct APIClient {
    public init(
        request: @escaping (Request) -> AnyPublisher<(headers: [HTTPHeader], body: Data), NetworkError>
    ) {
        self.request = request
    }
    
    public let request: (Request) -> AnyPublisher<(headers: [HTTPHeader], body: Data), NetworkError>
}


