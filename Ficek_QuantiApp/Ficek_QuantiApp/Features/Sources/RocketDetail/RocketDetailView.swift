import SwiftUI
import ComposableArchitecture
import RocketLaunch

public struct RocketDetailView: View {
  public let store: StoreOf<RocketDetailCore>
  
  public init(
    store: StoreOf<RocketDetailCore>
  ) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      ScrollView {
        VStack(alignment: .leading) {
          RocketParametersView(
            store: self.store.scope(
              state: \.rocketParameters,
              action: RocketDetailCore.Action.rocketParameters
            )
          )
          
          RocketFirstStageView(
            store: self.store.scope(
              state: \.rocketFirstStage,
              action: RocketDetailCore.Action.rocketFirstStage
            )
          )
          .padding()
          
          RocketSecondStageView(
            store: self.store.scope(
              state: \.rocketSecondStage,
              action: RocketDetailCore.Action.rocketSecondStage
            )
          )
          .padding()
          
          RocketPhotosView(
            store: self.store.scope(
              state: \.rocketPhotos,
              action: RocketDetailCore.Action.rocketPhotos
            )
          )
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigation) {
          NavigationLink(
            destination: IfLetStore(
              self.store.scope(
                state: \.rocketLaunch,
                action: RocketDetailCore.Action.rocketLaunch
              ),
              then: RocketLaunchView.init(store:)
            ),
            label: {
              Text("Launch")
            }
          )
        }
      }
      .navigationTitle(viewStore.name)
    }
  }
}

struct RocketDetailView_Previews: PreviewProvider {
  
  static var previews: some View {
    RocketDetailView(
      store: Store(
        initialState: RocketDetailCore.State(rocket: .mock),
        reducer: RocketDetailCore()
      )
    )
  }
}
