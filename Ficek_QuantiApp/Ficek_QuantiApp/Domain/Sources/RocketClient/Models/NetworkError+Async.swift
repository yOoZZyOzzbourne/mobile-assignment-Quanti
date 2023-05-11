import Foundation
import Networking
import ErrorHandlingConcurrency
import ErrorReporting

extension NetworkError: ModelConvertibleErrorCapable {
  public static var modelConvertibleError: NetworkError {
    .timeoutError
  }
}

extension NetworkError: ErrorHandlingConcurrency {
  public var causeUIDescription: String {
    switch cause {
    case .invalidResponse:
      return "Invalid response"
    case .urlError:
      return "Error with url"
    case .unauthorized:
      return "Bad credentials"
    case .clientError:
      return "Client error"
    case .serverError:
      return "Server error"
    case .noConnection:
      return "No connection"
    case .jsonDecodingError:
      return "Internal error"
    case .urlRequestBuilderError:
      return "Internal error"
    case .timeout:
      return "Timeout"
    }
  }
  
  public var causeName: String {
    switch cause {
    case .invalidResponse:
      return "Invalid response"
    case .urlError:
      return "Url error"
    case .unauthorized:
      return "Unauthorized"
    case .clientError:
      return "Client error"
    case .serverError:
      return "Server error"
    case .noConnection:
      return "No connection"
    case .jsonDecodingError:
      return "Json decoding error"
    case .urlRequestBuilderError:
      return "Url request error"
    case .timeout:
      return "Timeout"
    }
  }
}
