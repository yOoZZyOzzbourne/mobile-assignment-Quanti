import Foundation
import ComposableArchitecture
import Dependencies
import RocketClient
import RocketLaunch

public struct RocketFirstStageCore: ReducerProtocol{
    
    public init() { }
    
    public struct State: Equatable, Identifiable {
        public var id: String { rocket.id }
        public var rocket: Rocket
        public var reusableFirstSt: String { rocket.firstStage.reusable ?? false ? "Reusable" : "Not reusable" }
        public var enginesFirstSt: String { "\(rocket.firstStage.engines ?? 0) engines" }
        public var fuelAmmountFirstSt: String { "\(rocket.firstStage.fuelAmountTons ?? 0) tons of fuel" }
        public var burnTimeFirstSt: String {
            if let burnTime = rocket.firstStage.burnTimeSEC {
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
    
    public enum Action: Equatable {}
    
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
}
