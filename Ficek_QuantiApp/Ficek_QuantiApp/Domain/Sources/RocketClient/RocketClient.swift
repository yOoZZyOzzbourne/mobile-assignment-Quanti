import Foundation
import Dependencies
import Combine
import RequestBuilder

public struct RocketClient {
    
    public enum RocketRequest: String {
       // private var baseURL: String { return "https://api.spacexdata.com/v4" }
        case allRockets = "https://api.spacexdata.com/v4/rockets"
    }
    
    public var fetchAllRockets: ()  -> AnyPublisher<[Rocket], RocketError>
        
    public var fetchAsync: () async throws -> [Rocket]
}

