import Foundation
import ComposableArchitecture
import RocketDetail
import RocketClient
import Combine

public struct RocketListCore: ReducerProtocol{
    
    public init() {
    }
    
   public struct State: Equatable {
       public var rocketItems: IdentifiedArrayOf<RocketDetailCore.State> = []
       
       public init() {
       }
    }
    
   public enum Action {
        case rockets(id: RocketDetailCore.State.ID, action: RocketDetailCore.Action)
        
        case task
        case fetchRockets(Result<[Rocket], RocketError>)
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
                    uniqueElements: result.map { RocketDetailCore.State(rocket: $0)
                    }
                )
                return .none
                
            case .fetchRockets(.failure(_)):
               // print(error)
                return .none
            
            }
        }
        .forEach(\.rocketItems, action: /Action.rockets(id:action:)) {
            RocketDetailCore()
        }
    }
}



