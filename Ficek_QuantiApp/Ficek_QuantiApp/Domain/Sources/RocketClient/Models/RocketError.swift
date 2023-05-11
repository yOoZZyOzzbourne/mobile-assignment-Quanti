import Foundation
import ErrorReporting
import ModelConvertible
import ErrorHandlingConcurrency

public struct RocketError: ErrorReporting, ErrorHandlingConcurrency {
  
  public var underlyingError: ErrorReporting?
  public var stackID: UUID
  
  public enum Cause: Error, CustomStringConvertible {
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
    
    public var UIdescription: String {
      switch self {
      case .modelConvertibleError:
        return "Internal error"
      case .networkError:
        return "Error with network"
      case .urlRequestBuilderError:
        return "Internal error"
      }
    }
    
    public var name: String {
      switch self {
      case .modelConvertibleError:
        return "Model Converter Error"
      case .networkError:
        return "Network Error"
      case .urlRequestBuilderError:
        return "Internal Error"
      }
    }
  }
  
  public var causeDescription: String {
    cause.description
  }
  
  public var causeUIDescription: String {
    cause.UIdescription
  }
  
  public var causeName: String {
    cause.name
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
