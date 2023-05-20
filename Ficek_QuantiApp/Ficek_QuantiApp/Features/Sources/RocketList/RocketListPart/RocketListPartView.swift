import SwiftUI
import ComposableArchitecture
import RocketDetail
import UIToolkit

public struct RocketListPartView: View {
  public let store: StoreOf<RocketDetailCore>
  
  public init(
    store: StoreOf<RocketDetailCore>
  ) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      HStack {
        Image.rocket
          .padding(7)
        
        VStack(alignment: .leading) {
          Text(viewStore.rocket.name)
            .font(.callout)
          Text(viewStore.firstFlight)
            .font(.caption)
            .foregroundColor(.gray)
        }
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


