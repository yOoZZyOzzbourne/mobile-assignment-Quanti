import Foundation
import Dependencies
import Combine
import Networking

public struct RocketClient{
    public let fetchAllRockets: () -> AnyPublisher<[Rocket], RocketError>
}
