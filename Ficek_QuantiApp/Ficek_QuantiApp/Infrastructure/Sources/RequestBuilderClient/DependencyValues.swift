import Foundation
import Dependencies

extension DependencyValues {
    public var requestBuilderClient: RequestBuilderClient {
        get { self[RequestBuilderClient.self] }
        set { self[RequestBuilderClient.self] = newValue }
    }
}
