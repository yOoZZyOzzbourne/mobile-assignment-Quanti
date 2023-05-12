import Foundation
import ErrorReporting

public struct RocketError: CombineErrorReporting, ErrorReporting {
  
  public var debugDescription: String = ""
  public var description: String = ""
  public var underlyingError: CombineErrorReporting?
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
  }
  
  public var causeDescription: String {
    cause.description
  }
  
  public let cause: Cause
  
  init(
    stackID: UUID = UUID(),
    cause: Cause,
    underlyingError: CombineErrorReporting? = nil
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

extension RocketError: ErrorForAlerts {
  public var causeUIDescription: String {
    switch cause {
    case .modelConvertibleError:
      return "Internal error"
    case .networkError:
      return "Error with network"
    case .urlRequestBuilderError:
      return "Internal error"
    }
  }
  
  public var causeName: String {
    switch cause {
    case .modelConvertibleError:
      return "Model Converter Error"
    case .networkError:
      return "Network Error"
    case .urlRequestBuilderError:
      return "Internal Error"
    }
  }
}
