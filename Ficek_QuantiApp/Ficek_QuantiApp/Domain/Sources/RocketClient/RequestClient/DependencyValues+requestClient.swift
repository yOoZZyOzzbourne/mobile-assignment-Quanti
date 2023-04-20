import Foundation
import Dependencies

extension DependencyValues {
    public var requestClient: RequestClient {
        get { self[RequestClient.self] }
        set { self[RequestClient.self] = newValue }
    }
}
