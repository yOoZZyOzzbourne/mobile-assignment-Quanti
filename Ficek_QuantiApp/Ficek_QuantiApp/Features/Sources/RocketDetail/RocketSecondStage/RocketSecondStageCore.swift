import Foundation
import ComposableArchitecture
import Dependencies
import RocketClient
import RocketLaunch

public struct RocketSecondStageCore: ReducerProtocol {
  
  public init() { }
  
  public struct State: Equatable, Identifiable {
    public var id: String { rocket.id }
    public var rocket: Rocket
   
    public init(
      rocket: Rocket
    ) {
      self.rocket = rocket
    }
  }
  
  public enum Action: Equatable { }
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
  
}
