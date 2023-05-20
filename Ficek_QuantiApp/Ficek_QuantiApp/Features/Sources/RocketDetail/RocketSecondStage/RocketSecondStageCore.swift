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
    public var reusableSecondSt: String { rocket.secondStage.reusable ?? false ? "Reusable" : "Not reusable" }
    public var firstFlight: String { "First flight: \(rocket.firstFlight)" }
    public var enginesSecondSt: String { "\(rocket.secondStage.engines ?? 0) engines" }
    public var fuelAmmountSecondSt: String { "\(rocket.secondStage.fuelAmountTons ?? 0) tons of fuel" }
    public var burnTimeSecondSt: String {
      if let burnTime = rocket.secondStage.burnTimeSEC {
        return "\(burnTime) seconds burn time"
      } else {
        return "Data not available"
      }
    }
    
    public init(
      rocket: Rocket
    ) {
      self.rocket = rocket
    }
  }
  
  public enum Action: Equatable { }
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
  
}
