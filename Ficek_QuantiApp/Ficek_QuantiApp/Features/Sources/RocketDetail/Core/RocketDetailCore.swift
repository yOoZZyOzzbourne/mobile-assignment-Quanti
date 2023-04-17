import Foundation
import ComposableArchitecture
import Dependencies
import RocketClient

public struct RocketDetailCore: ReducerProtocol{
    
    public init() {
        
    }
    
    public struct State: Equatable, Identifiable {
        public var id: String { rocket.id }
        public var name: String { rocket.name }
        public var rocket: Rocket
        public var height: String {"\(Int(round(rocket.height.meters ?? 0)))m"}
        public var diameter: String { "\(Int(round(rocket.diameter.meters ?? 0)))m" }
        public var mass: String { "\(rocket.mass.kg ?? 1000 / 1000)t" }
        
        public var reusableFirstSt: String { rocket.firstStage.reusable ?? false
            ? "Reusable"
            : "Not reusable"
        }
        
        public var enginesFirstSt: String { "\(rocket.firstStage.engines ?? 0) engines" }
        public var fuelAmmountFirstSt: String { "\(rocket.firstStage.fuelAmountTons ?? 0) tons of fuel"}
        public var burnTimeFirstSt: String {
            rocket.firstStage.burnTimeSEC != nil
            ? "\(String(describing: rocket.firstStage.burnTimeSEC)) seconds burn time"
            : "Data not available"
        }
        
        public var reusableSecondSt: String { rocket.secondStage.reusable ?? false
            ? "Reusable"
            : "Not reusable" }
        public var firstFlight: String { "First flight: \(rocket.firstFlight)"}
        public var enginesSecondSt: String { "\(rocket.secondStage.engines ?? 0) engines" }
        public var fuelAmmountSecondSt: String { "\(rocket.secondStage.fuelAmountTons ?? 0) tons of fuel"}
        public var burnTimeSecondSt: String {  rocket.secondStage.burnTimeSEC != nil
            ? "\(String(describing: rocket.secondStage.burnTimeSEC)) seconds burn time"
            : "Data not available"
        }
        
        public init(rocket: Rocket) {
            self.rocket = rocket
        }
    }
    
    public enum Action: Equatable {
        
    }
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        
    }
}
