import Foundation
import ErrorReporting
import ModelConvertible

public struct RocketError: ErrorReporting, Equatable, ModelConvertibleErrorCapable {
    public static var modelConvertibleError: RocketError = .modelConvertibleError
    
    public static func == (lhs: RocketError, rhs: RocketError) -> Bool {
        lhs.isEqual(to: rhs)
    }
    
    public var underlyingError: ErrorReporting?
    
    public var stackID: UUID
    
//    public var causeDescription: String
    
//    case internalError
//    case badUrl
//    case networkError
    
    public enum Cause: Error, CustomStringConvertible {
      case urlError(URLError)
      case invalidResponse
      case unauthorized
      case clientError(statusCode: Int)
      case serverError(statusCode: Int)
      case noConnection
      case jsonDecodingError(Error)
      case urlRequestBuilderError
      case timeout

      public var description: String {
        switch self {
        case let .urlError(urlError):
          return "urlError(urlError: \(urlError))"
        case .invalidResponse:
          return "invalidResponse"
        case .unauthorized:
          return "unauthorized"
        case let .clientError(statusCode):
          return "clientError(statusCode: \(statusCode))"
        case let .serverError(statusCode):
          return "serverError(statusCode: \(statusCode))"
        case .noConnection:
          return "noConnection"
        case let .jsonDecodingError(error):
          return "jsonDecodingError(error: \(error))"
        case .urlRequestBuilderError:
          return "urlRequestBuilderError"
        case .timeout:
          return "timeout"
        }
      }
    }

    public var causeDescription: String {
      cause.description
    }

    public let cause: Cause

    init(stackID: UUID = UUID(), cause: Cause = .invalidResponse) {
      self.stackID = stackID
      self.cause = cause
    }
    
}
