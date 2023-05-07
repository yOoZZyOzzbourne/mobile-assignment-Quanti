import Foundation
import ComposableArchitecture
import Dependencies
import RocketClient
import RocketLaunch

public struct RocketDetailCore: ReducerProtocol{
    
    public init() {}
    
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
        
        public var reusableSecondSt: String { rocket.secondStage.reusable ?? false ? "Reusable" : "Not reusable" }
        public var firstFlight: String { "First flight: \(rocket.firstFlight)"}
        public var enginesSecondSt: String { "\(rocket.secondStage.engines ?? 0) engines" }
        public var fuelAmmountSecondSt: String { "\(rocket.secondStage.fuelAmountTons ?? 0) tons of fuel"}
        public var burnTimeSecondSt: String {
            if let burnTime = rocket.secondStage.burnTimeSEC {
               return "\(burnTime) seconds burn time"
            } else {
               return "Data not available"
            }
        }
      public var rocketLaunch: RocketLaunchCore.State
        
      public init(
        rocket: Rocket,
        rocketLaunch: RocketLaunchCore.State = .init()
      ) {
            self.rocket = rocket
            self.rocketLaunch = rocketLaunch
        }
    }
    
    public enum Action: Equatable {
      case rocketLaunch(RocketLaunchCore.Action)
    }
    
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .rocketLaunch:
        return .none
      }
    }
    Scope(state: \.rocketLaunch, action: /Action.rocketLaunch) {
      RocketLaunchCore()
    }
  }
}
