import Foundation
import ComposableArchitecture
import Dependencies
import CoreMotionClient

public struct RocketLaunchCore: ReducerProtocol {
  
  public init() { }
  
  public struct State: Equatable {
    public var isFlying: Bool = false
    public var flyingXindex: Double = 0
    public var positionX: Double = 0
    public var positionY: Double = 0
    public var positionZ: Double = 0
    public let positionMultiplier: Double = 5
    public let startPosition: Double = 0
    public let enoughToFly: Double = 1.5
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case onAppear
    case flying(Coordinates)
  }
  
  @Dependency(\.coreMotionClient) var coreMotionClient
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .onAppear:
      return .run { send in
        for try await event in try await self.coreMotionClient.rotationRate(OperationQueue()) {
          await send(.flying(event))
        }
      }
      
    case let .flying(result):
      if state.isFlying == true {
        if state.positionX > state.startPosition {
          state.isFlying = false
        }
        // The positionY is used when user wants to tilt the phone to the left or to the right on the X axis, switched to Z for better user experience.
//      state.positionY += result.y * state.positionMultiplier
        state.positionX -= result.x * state.positionMultiplier
        state.positionZ -= result.z
      }
      if result.x > state.enoughToFly {
        state.isFlying = true
      }
      
      return .none
    }
  }
}

