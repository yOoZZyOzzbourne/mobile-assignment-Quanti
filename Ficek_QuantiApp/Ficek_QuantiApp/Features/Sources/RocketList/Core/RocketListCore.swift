import Foundation
import ComposableArchitecture
import RocketDetail
import RocketClient
import Combine
import SwiftUI
import Networking
import ErrorReporting
import ModelConvertible

public struct RocketListCore: ReducerProtocol{
    
    public init() {
    }
    
    public struct State: Equatable{
        public static func == (lhs: RocketListCore.State, rhs: RocketListCore.State) -> Bool {
            lhs.rocketItems != rhs.rocketItems
        }
        
        public var rocketItems: IdentifiedArrayOf<RocketDetailCore.State> = []
        public var alert: AlertState<Action>? = nil
        
        public init() {
        }
    }
    
    public enum Action {
        case rockets(id: RocketDetailCore.State.ID, action: RocketDetailCore.Action)
        
        case task
        case fetchRockets(Result<[Rocket], RocketError>)
        case alertCancelTapped
    }
    
    @Dependency(\.rocketClient.fetchAllRockets) var fetchAllRockets
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .task:
                return fetchAllRockets()
                    .receive(on: DispatchQueue.main)
                    .catchToEffect(Action.fetchRockets)
                
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
                            primaryButton: .default(TextState("Try again"),action: .send(.task)),
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
            }
        }
        .forEach(\.rocketItems, action: /Action.rockets(id:action:)) {
            RocketDetailCore()
        }
    }
}



