import SwiftUI
import ComposableArchitecture
import RocketDetail
import UIToolkit

public struct RocketListPartView: View {
  public let store: StoreOf<RocketDetailCore>
  @ObservedObject var viewStore: ViewStore<ViewState, RocketDetailCore.Action>
  
  struct ViewState: Equatable {
    let name: String
    let firstFlight: String
    
    init(state: RocketDetailCore.State) {
      self.name = state.rocket.name
      self.firstFlight = "First flight: \(state.rocket.firstFlight)"
    }
  }
  
  public init(store: StoreOf<RocketDetailCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { ViewState(state: $0) })
  }
  
  public var body: some View {
    HStack {
      Image.rocket
        .padding(7)
      
      VStack(alignment: .leading) {
        Text(viewStore.name)
          .font(.callout)
        Text(viewStore.firstFlight)
          .font(.caption)
          .foregroundColor(.gray)
      }
    }
  }
}

struct RocketListPartView_Previews: PreviewProvider {
  static var previews: some View {
    RocketListPartView(
      store: Store(
        initialState: RocketDetailCore.State(rocket: .mock, rocketLaunch: .init()),
        reducer: RocketDetailCore()
      )
    )
  }
}


