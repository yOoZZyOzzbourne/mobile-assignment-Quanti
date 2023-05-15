import SwiftUI
import ComposableArchitecture
import RocketLaunch
import UIToolkit

public struct RocketParametersView: View {
  let store: StoreOf<RocketParametersCore>
  @ObservedObject public var viewStore: ViewStore<ViewState, RocketParametersCore.Action>
  
  public struct ViewState: Equatable {
    public let name: String
    public let height: String
    public let diameter: String
    public let mass: String
    public let description: String
    
    public init(state: RocketParametersCore.State) {
      self.name = state.rocket.name
      self.height = "\(Int(round(state.rocket.height.meters ?? 0)))m"
      self.diameter = "\(Int(round(state.rocket.diameter.meters ?? 0)))m"
      self.mass = "\((state.rocket.mass.kg ?? 1000) / 1000)t"
      self.description = state.rocket.description
    }
  }
  
  public init(store: StoreOf<RocketParametersCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { ViewState(state: $0) })
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Overview")
        .font(.headline)
      Text(viewStore.description)
        .font(.subheadline)
      Text("Parameters")
        .font(.headline)
      HStack(alignment: .center, spacing: 36) {
        Group {
          VStack(spacing: 4) {
            Text(viewStore.height)
              .font(.system(size: 24))
              .bold()
            Text("height")
              .font(.headline)
          }
          VStack(spacing: 4) {
            Text(viewStore.diameter)
              .font(.system(size: 24))
              .bold()
            Text("diameter")
              .font(.headline)
          }
          VStack(spacing: 4) {
            Text(viewStore.mass)
              .font(.system(size: 24))
              .bold()
            Text("mass")
              .font(.headline)
          }
        }
        .frame(width: 108, height: 108)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .background (
          RoundedRectangle(cornerRadius: 16)
            .foregroundColor(Color.pinkColor)
        )
      }
      .foregroundColor(Color.white)
    }
    .padding()
  }
}

struct RocketParametersView_Previews: PreviewProvider {
  static var previews: some View {
    RocketParametersView(
      store: Store(
        initialState: RocketParametersCore.State(rocket: .mock),
        reducer: RocketParametersCore()
      )
    )
  }
}
