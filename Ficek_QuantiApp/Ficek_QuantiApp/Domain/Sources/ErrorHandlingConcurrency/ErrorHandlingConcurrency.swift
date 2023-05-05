import Foundation
import ComposableArchitecture
import Networking

public protocol ErrorHandlingConcurrency: Error, CustomDebugStringConvertible, CustomStringConvertible {
  var causeUIDescription: String { get }
  var causeName: String { get }
}

struct GeneralAsyncError: ErrorHandlingConcurrency {
    var debugDescription: String
    var description: String
    
    public enum Cause: Error, CustomStringConvertible {
        case badURL
        case noConnection
        
        public var description: String {
            switch self {
                
            case .badURL:
                return "badURL"
            case .noConnection:
                return "noConnection"
            }
        }
        
        public var UIdescription: String {
            switch self {
                
            case .badURL:
                return "The url is invalid"
            case .noConnection:
                return "Cannot connect to the intertet"
            }
        }
        
        public var name: String {
            switch self {
                
            case .badURL:
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
