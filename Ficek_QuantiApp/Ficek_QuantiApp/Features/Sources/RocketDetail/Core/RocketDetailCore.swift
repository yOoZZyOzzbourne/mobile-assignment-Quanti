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
        public var firstFlight: String { "First flight: \(rocket.firstFlight)"}
      
      public var rocketLaunch: RocketLaunchCore.State
      public var rocketFirstStage: RocketFirstStageCore.State?
      public var rocketSecondStage: RocketSecondStageCore.State?
      public var rocketPhotos: RocketPhotosCore.State?
      public var rocketParameters: RocketParametersCore.State?
        
      public init(
        rocket: Rocket,
        rocketLaunch: RocketLaunchCore.State = .init()
      ) {
        self.rocket = rocket
        self.rocketLaunch = rocketLaunch
        self.rocketFirstStage = .init(rocket: rocket)
        self.rocketSecondStage = .init(rocket: rocket)
        self.rocketPhotos = .init(rocket: rocket)
        self.rocketParameters = .init(rocket: rocket)
      }
    }
    
    public enum Action: Equatable {
      case rocketLaunch(RocketLaunchCore.Action)
      case rocketFirstStage(RocketFirstStageCore.Action)
      case rocketSecondStage(RocketSecondStageCore.Action)
      case rocketParameters(RocketParametersCore.Action)
      case rocketPhotos(RocketPhotosCore.Action)
    }
    
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .rocketLaunch:
        return .none
      }
    }
    .ifLet(\.rocketFirstStage, action: /Action.rocketFirstStage) {
      RocketFirstStageCore()
    }
    .ifLet(\.rocketSecondStage, action: /Action.rocketSecondStage) {
      RocketSecondStageCore()
    }
    .ifLet(\.rocketParameters, action: /Action.rocketParameters) {
      RocketParametersCore()
    }
    .ifLet(\.rocketPhotos, action: /Action.rocketPhotos) {
      RocketPhotosCore()
    }
    
    Scope(state: \.rocketLaunch, action: /Action.rocketLaunch) {
      RocketLaunchCore()
    }
  }
}
