import SwiftUI
import ComposableArchitecture

public struct RocketLaunchView: View {
  public let store: StoreOf<RocketLaunchCore>
  
  public init(
    store: StoreOf<RocketLaunchCore>
  ) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      GeometryReader { geo in
        VStack(spacing: -380) {
          viewStore.image
            .padding()
            .frame(
              width: geo.size.width,
              height: 1000,
              alignment: viewStore.isFlying ? .top : .center
            )
            .animation(viewStore.animation, value: viewStore.isFlying)
          
          Text(viewStore.launchText)
            .font(.callout)
            .task {
              await viewStore.send(.onAppear).finish()
            }
        }
      }
    }
    .navigationTitle("Launch")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct RocketLaunchView_Previews: PreviewProvider {
  static var previews: some View {
    RocketLaunchView(
      store: Store(
        initialState: RocketLaunchCore.State(),
        reducer: RocketLaunchCore()
      )
    )
  }
}
