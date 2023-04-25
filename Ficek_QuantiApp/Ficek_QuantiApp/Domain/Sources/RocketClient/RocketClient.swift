import Foundation
import Dependencies
import Combine
import Networking
import RequestBuilder

public struct RocketClient{
    
    public enum RocketRequest: String {
       // private var baseURL: String { return "https://api.spacexdata.com/v4" }
        case allRockets = "https://api.spacexdata.com/v4/rockets"
    }
    
    public let fetchAllRockets: () -> AnyPublisher<[Rocket], RocketError>
}

