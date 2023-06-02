import SwiftUI
import ComposableArchitecture
import UIToolkit

public struct RocketLaunchView: View {
  public let store: StoreOf<RocketLaunchCore>
  @ObservedObject public var viewStore: ViewStore<ViewState, RocketLaunchCore.Action>
  
  public struct ViewState: Equatable {
    public let image: Image
    public let launchText: String
    public let animation: Animation
    public let isFlying: Bool
    
   public init(state: RocketLaunchCore.State) {
      self.image = state.isFlying ? .rocketFlying : .rocketIdle
      self.launchText = state.isFlying ? "Launch successfull!" : "Lift the phone to launch the rocket"
      self.animation = Animation.spring()
      self.isFlying = state.isFlying
    }
  }
  
  public init(store: StoreOf<RocketLaunchCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { ViewState(state: $0) })
  }
  
  public var body: some View {
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
