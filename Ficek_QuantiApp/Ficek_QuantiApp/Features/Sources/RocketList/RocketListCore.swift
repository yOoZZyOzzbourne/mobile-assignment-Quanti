import Foundation
import ComposableArchitecture
import RocketDetail
import RocketClient
import Combine
import SwiftUI
import Networking
import ErrorReporting
import ModelConvertible
import TCAExtensions
import UIToolkit

public struct RocketListCore: ReducerProtocol {
  
  public init() { }
  
  public struct State: Equatable {
    public var rocketItems: IdentifiedArrayOf<RocketDetailCore.State> = []
    public var alert: AlertState<Action>? = nil
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case rockets(id: RocketDetailCore.State.ID, action: RocketDetailCore.Action)
    case onAppear
    case fetchRockets(Result<[Rocket], RocketError>)
    case alertCancelTapped
    case fetchAsync(TaskResult<[Rocket]>)
  }
  
  @Dependency(\.rocketClient.fetchAllRocketsCombine) var fetchAllRockets
  @Dependency(\.rocketClient.fetchAllRocketsAsync) var fetchAsync
  @Dependency(\.continuousClock) var clock
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
        
      case .onAppear:
        //MARK: Combine
        //                return fetchAllRocketsCombine()
        //                    .receive(on: DispatchQueue.main)
        //                    .catchToEffect(Action.fetchRockets)
        //MARK: Async
        return .task {
          await .fetchAsync(
            TaskResult {
              //This can be commented, only for testing Swift-Clocks
              try await clock.sleep(for: .seconds(5))
              return try await fetchAsync()
            }
          )
        }
        
      case let .fetchRockets(.success(result)):
        state.rocketItems = IdentifiedArrayOf(
          uniqueElements: result.map {
            RocketDetailCore.State(rocket: $0)
          }
        )
    
        return .none
        
      case let .fetchRockets(.failure(error)):
        state.alert = .errorAlert(error: error)
        return .none
        
      case .alertCancelTapped:
        state.alert = nil
        return .none
        
      case let .fetchAsync(.success(result)):
        state.rocketItems = IdentifiedArrayOf(
          uniqueElements: result.map {
            RocketDetailCore.State(rocket: $0)
          }
        )
        
        return .none
        
      case let .fetchAsync(.failure(error)):
        state.alert = .errorAlert(error: error)
        return .none
        
      case .rockets(id: _, action: _):
        return .none
      }
    }
    .forEach(\.rocketItems, action: /Action.rockets(id:action:)) {
      RocketDetailCore()
    }
  }
}



