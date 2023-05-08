import Foundation
import ComposableArchitecture
import Dependencies
import RocketClient
import RocketLaunch

public struct RocketParametersCore: ReducerProtocol{
  
  public init() { }
  
  public struct State: Equatable, Identifiable {
    public var id: String { rocket.id }
    public var name: String { rocket.name }
    public var rocket: Rocket
    public var height: String {"\(Int(round(rocket.height.meters ?? 0)))m"}
    public var diameter: String { "\(Int(round(rocket.diameter.meters ?? 0)))m" }
    public var mass: String {
      if let mass = rocket.mass.kg {
        return "\(mass / 1000)t"
      } else {
        return "No data"
      }
    }
    
    public init(
      rocket: Rocket
    ) {
      self.rocket = rocket
    }
  }
  
  public enum Action: Equatable {
  }
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
}
