import Foundation
import ComposableArchitecture
import Dependencies
import CoreMotionClient

public struct RocketLaunchCore: ReducerProtocol {
  
  public init() { }
  
  public struct State: Equatable {
    public var isFlying: Bool = false
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case onAppear
    case flying(Double)
  }
  
  @Dependency(\.coreMotionClient) var coreMotionClient
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .onAppear:
      return .run { send in
        for try await event in try await self.coreMotionClient.xRotationRate(OperationQueue()) {
          await send(.flying(event))
        }
      }
      
    case let .flying(result):
      if result > 2 || result < -2 {
        state.isFlying = true
      }
      
      return .none
    }
  }
}

