import Foundation
import ErrorReporting
import ModelConvertible

public struct RocketError: ErrorReporting, ModelConvertibleErrorCapable {
    public var underlyingError: ErrorReporting?
    
    public var stackID: UUID
    
    public static var modelConvertibleError: Self {
        .init(cause: .modelConvertibleError)
    }
    
    public enum Cause: Error, CustomStringConvertible {
        case urlError
        case invalidResponse
        case timeout
        case modelConvertibleError
        
        public var description: String {
            switch self {
            case .invalidResponse:
                return "invalidResponse"
            case .timeout:
                return "timeout"
            case .modelConvertibleError:
                return "modelConvertibleError"
            case .urlError:
                return "urlError"
            }
        }
    }
    
    public var causeDescription: String {
        cause.description
    }
    
    public let cause: Cause
    
    init(
        stackID: UUID = UUID(),
        cause: Cause = .timeout,
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

public extension RocketError {
    static var invalidResponse: Self {
        RocketError(cause: .invalidResponse)
    }
    
    static var timeoutError: Self {
        RocketError(cause: .timeout)
    }
    static var urlError: Self {
        RocketError(cause: .urlError)
    }
}
