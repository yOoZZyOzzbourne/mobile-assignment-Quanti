import Foundation
import ComposableArchitecture
import SwiftUI
import ErrorReporting
import RocketClient

public extension AlertState {
  static func errorAlert(error: Error) -> AlertState {
    if let error = error as? ErrorForAlerts {
      return AlertState {
        TextState(error.causeName)
      } actions: {
        .cancel(TextState("Ok"))
      } message: {
        TextState(error.causeUIDescription)
      }
    } else {
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
  static func errorAlert(error: Error) -> Alert {
    if let error = error as? ErrorForAlerts {
      return Alert(
        title: Text(error.causeName),
        message: Text(error.causeUIDescription),
        dismissButton: .cancel(Text("Ok"))
      )
    } else {
      return Alert(
        title: Text("Sorry"),
        message: Text("Something went wrong"),
        dismissButton: .cancel(Text("Ok"))
      )
    }
  }
}
