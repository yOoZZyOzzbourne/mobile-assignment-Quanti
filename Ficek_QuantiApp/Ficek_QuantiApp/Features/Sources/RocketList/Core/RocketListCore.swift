import Foundation
import ComposableArchitecture
import RocketDetail
import RocketClient
import Combine
import SwiftUI
import Networking
import ErrorReporting
import ModelConvertible
import ErrorHandlingConcurrency
import UIToolkit

public struct RocketListCore: ReducerProtocol{
    
    public init() {
    }
    
    public struct State: Equatable{
        public var rocketItems: IdentifiedArrayOf<RocketDetailCore.State> = []
        public var alert: AlertState<Action>? = nil
        
        public init() {
        }
    }
    
  public enum Action: Equatable {
        case rockets(id: RocketDetailCore.State.ID, action: RocketDetailCore.Action)
        
        case onAppear
        case fetchRockets(Result<[Rocket], RocketError>)
        case alertCancelTapped
        case fetchAsync(TaskResult<[Rocket]>)
    }
    
    @Dependency(\.rocketClient.fetchAllRockets) var fetchAllRockets
    @Dependency(\.rocketClient.fetchAsync) var fetchAsync
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .onAppear:
              //MARK: Combine
//                return fetchAllRockets()
//                    .receive(on: DispatchQueue.main)
//                    .catchToEffect(Action.fetchRockets)
              //MARK: Async
                return .task {
                    await .fetchAsync(
                        TaskResult {
                            return try await fetchAsync()
                        }
                    )
                }
                
            case .fetchRockets(.success(let result)):
                state.rocketItems = IdentifiedArrayOf(
                    uniqueElements: result.map {
                      RocketDetailCore.State(rocket: $0)
                    }
                )
                
                return .none
                
            case .fetchRockets(.failure(let error)):
                if let networkError = error.underlyingError as? NetworkError {
                    switch networkError {
                    case .noConnection:
                        state.alert = AlertState(
                            title: TextState("No connection"),
                            message: TextState("Phone canot connect to internet"),
                            primaryButton: .default(TextState("Try again"),action: .send(.onAppear)),
                            secondaryButton: .cancel(TextState("Cancel"))
                        )

                    case .timeoutError:
                        return .send(.onAppear)

                    case .serverError(statusCode: 500):
                        state.alert = AlertState(
                            title: TextState("Server is down"),
                            message: TextState("Wait and try again"),
                            primaryButton: .default(TextState("Try again"),action: .send(.onAppear)),
                            secondaryButton: .cancel(TextState("Cancel"))
                        )

                    default:
                        print("Response was invalid")
                    }
                }
                
                return .none
                
            case .alertCancelTapped:
                state.alert = nil
                return .none
                
            case .fetchAsync(.success(let result)):
                state.rocketItems = IdentifiedArrayOf(
                    uniqueElements: result.map {
                      RocketDetailCore.State(rocket: $0)
                    }
                )
                
                return .none
            case .fetchAsync(.failure(let error)):
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



