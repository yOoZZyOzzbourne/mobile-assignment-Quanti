import Foundation
import Dependencies
import Combine

public struct RocketClient{
    public let fetchAllRockets: () -> AnyPublisher<[Rocket], RocketError>
}
