import Foundation
import ComposableArchitecture
import Dependencies
import CoreMotionClient

public struct RocketLaunchCore: ReducerProtocol {
  
  public init() { }
  
  public struct State: Equatable {
    public var isFlying: Bool = false
    public var flyingXindex: Double = 0
    public var positionY: Double = 0
    public var positionX: Double = 0
    public var positionZ: Double = 0
    public let positionMultiplier: Double = 5
    public let startPosition: Double = 0
    public let enoughToFly: Double = 1.5
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case onAppear
    case flying(Double, Double, Double)
  }
  
  @Dependency(\.coreMotionClient) var coreMotionClient
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .onAppear:
      return .run { send in
        for try await event in try await self.coreMotionClient.rotationRate(OperationQueue()) {
          await send(.flying(event.0, event.1, event.2))
        }
      }
      
    case let .flying(resultX, resultY, resultZ):
      if state.isFlying == true {
        if state.positionY > state.startPosition {
          state.isFlying = false
        }
//      state.positionX += resultX * state.positionMultiplier
        state.positionY -= resultY * state.positionMultiplier
        state.positionZ -= resultZ
      }
      if resultY > state.enoughToFly {
        state.isFlying = true
      }
      
      return .none
    }
  }
}

