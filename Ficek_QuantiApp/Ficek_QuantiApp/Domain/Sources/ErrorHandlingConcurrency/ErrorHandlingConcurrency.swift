import Foundation
import ComposableArchitecture
import Networking


public protocol ErrorHandlingConcurrency: Error {
  var causeUIDescription: String { get }
  var causeName: String { get }
}

struct GeneralAsyncError: ErrorHandlingConcurrency {
    public enum Cause: Error, CustomStringConvertible {
        case badUrl
        case noConnection
        
        public var description: String {
            switch self {
                
            case .badUrl:
                return "badUrl"
            case .noConnection:
                return "noConnection"
            }
        }
        
        public var UIdescription: String {
            switch self {
                
            case .badUrl:
                return "The url is invalid"
            case .noConnection:
                return "Cannot connect to the intertet"
            }
        }
        
        public var name: String {
            switch self {
                
            case .badUrl:
                return "Bad url"
            case .noConnection:
                return "No connection"
            }
        }
    }
    
    public var causeUIDescription: String {
        cause.UIdescription
    }
    
    public var causeName: String {
        cause.name
    }
    
    public let cause: Cause
}


//public struct ErrorAlertState {
//
//    public struct Input {
//        let state: any ReducerProtocol
//
//        public init(state: any ReducerProtocol) {
//            self.state = state
//        }
//    }
//
//    public let errorAlertState: (ErrorHandlingConcurrency) -> AlertState<Input>
//}
//
//extension ErrorAlertState: DependencyKey {
//
//    public static var liveValue: ErrorAlertState {
//
//        return Self(
//            errorAlertState: { input in
//
//
//            }
//        )
//    }
//}
//
//extension DependencyValues {
//    public var errorAlertState: ErrorAlertState {
//        get { self[ErrorAlertState.self] }
//        set { self[ErrorAlertState.self] = newValue }
//    }
//}
