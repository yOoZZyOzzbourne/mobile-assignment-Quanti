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
    public let positionY: Double
    public let positionX: Double
    public let positionZ: Double
    public let maxTopPosition: Double = -400
    public let maxLeftPosition: Double = -150
    public let maxRightPosition: Double = 150
    
    public init(state: RocketLaunchCore.State) {
      self.isFlying = state.isFlying
      self.image = isFlying ? .rocketFlying : .rocketIdle
      self.launchText = isFlying ? "Launch successfull!" : "Lift the phone to launch the rocket"
      self.animation = Animation.spring()
      //MARK: Due to mismatch in Coordinates from CoreMotion and SwiftUI, position Y is defined by state.positionX and vise versa
      self.positionY = state.positionX < maxTopPosition ? maxTopPosition : state.positionX
      self.positionX = state.positionY < maxLeftPosition
        ? maxLeftPosition
        : (state.positionY > maxRightPosition ? maxRightPosition : state.positionY)
      self.positionZ = state.positionZ
    }
  }
  
  public init(store: StoreOf<RocketLaunchCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { ViewState(state: $0) })
  }
  
  public var body: some View {
    ZStack {
      if viewStore.isFlying {
        GifView(fileName: "stars")
          .scaledToFill()
          .rotationEffect(Angle(degrees: viewStore.positionZ))
          .ignoresSafeArea()
      } else {
        Image.starsStationary
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
      }
      
      GeometryReader { geo in
        VStack(spacing: -380) {
          viewStore.image
            .padding()
            .frame(
              width: geo.size.width,
              height: 1000
            )
            .offset(y: viewStore.positionY)
            .rotationEffect(Angle(degrees: viewStore.positionZ))
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
