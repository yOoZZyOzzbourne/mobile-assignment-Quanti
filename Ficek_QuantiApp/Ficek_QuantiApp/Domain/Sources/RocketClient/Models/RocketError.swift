import Foundation
import ErrorReporting
import ModelConvertible

//TODO: Protocols to extensions
public struct RocketError: ErrorReporting {
    public var underlyingError: ErrorReporting?
    
    public var stackID: UUID
   
    public enum Cause: Error, CustomStringConvertible {
        //TODO: No more networkingError
        case networkError
        case modelConvertibleError
        case urlRequestBuilderError
        
        public var description: String {
            switch self {
            case .modelConvertibleError:
                return "modelConvertibleError"
            case .networkError:
                return "networkError"
            case .urlRequestBuilderError:
                return "urlRequestBuilderError"
            }
        }
    }
    
    public var causeDescription: String {
        cause.description
    }
    
    public let cause: Cause
    
    init(
        stackID: UUID = UUID(),
        cause: Cause,
        underlyingError: ErrorReporting? = nil
    ) {
        self.underlyingError = underlyingError
        self.stackID = stackID
        self.cause = cause
    }
}

extension RocketError: Equatable {
    public static func == (lhs: RocketError, rhs: RocketError) -> Bool {
        lhs.isEqual(to: rhs)
    }
}

//public extension RocketError {
//    static var invalidResponse: Self {
//        RocketError(cause: .invalidResponse)
//    }
//
//    static var timeoutError: Self {
//        RocketError(cause: .timeout)
//    }
//    static var urlError: Self {
//        RocketError(cause: .urlError)
//    }
//}

extension RocketError: NetworkErrorCapable {
    public static var networkError: Self {
        .init(cause: .networkError)
    }
}

extension RocketError: ModelConvertibleErrorCapable {
    public static var modelConvertibleError: Self {
        .init(cause: .modelConvertibleError)
    }
}

extension RocketError: URLRequestBuilderErrorCapable {
    public static var urlRequestBuilderError: Self {
        .init(cause: .urlRequestBuilderError)
    }
}
