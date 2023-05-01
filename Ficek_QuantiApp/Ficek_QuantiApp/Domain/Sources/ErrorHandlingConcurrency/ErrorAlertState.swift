import Foundation
import ComposableArchitecture
import SwiftUI
import ErrorReporting

public extension AlertState {
    static func errorAlert(error: Error?) -> AlertState {
        if let error = error as? ErrorHandlingConcurrency {
            return AlertState {
                TextState(error.causeUIDescription)
            } actions: {
                .cancel(TextState("Ok"))
            } message: {
                TextState(error.causeUIDescription)
            }
        } else {
            //            return unimplemented("\(Self.self) is not confronting ErrorHandlingConcurrency")
            return AlertState {
                TextState("Sorry")
            } actions: {
                .cancel(TextState("Ok"))
            } message: {
                TextState("Something went wrong")
            }
        }
    }
}

public extension Alert {
    static func errorAlert(error: Error?) -> Alert {
        if let error = error as? ErrorHandlingConcurrency {
            return Alert(
                title: Text(error.causeName),
                message: Text(error.causeUIDescription),
                dismissButton: .cancel(Text("Ok"))
            )
        } else {
            //            return unimplemented("\(Self.self) is not confronting ErrorHandlingConcurrency")
            return Alert(
                title: Text("Sorry"),
                message: Text("Something went wrong"),
                dismissButton: .cancel(Text("Ok"))
            )
        }
    }
}
