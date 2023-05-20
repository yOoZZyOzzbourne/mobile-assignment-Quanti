import SwiftUI
import ComposableArchitecture
import RocketList
import RocketDetail

@main
struct Ficek_QuantiApp: App {
  var body: some Scene {
    WindowGroup {
      RocketListView(
        store: Store(
          initialState: RocketListCore.State(),
          reducer: RocketListCore()._printChanges()
        )
      )
    }
  }
}
