import SwiftUI
import ComposableArchitecture
import RocketLaunch

public struct RocketDetailView: View {
    public let store: StoreOf<RocketDetailCore>
    
    public init(store: StoreOf<RocketDetailCore>) {
        self.store = store
    }
    
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      ScrollView {
        VStack(alignment: .leading) {
          IfLetStore(
            self.store.scope(
              state: \.rocketParameters,
              action: RocketDetailCore.Action.rocketParameters
            ),
            then: RocketParametersView.init(store:)
          )
          
          IfLetStore(
            self.store.scope(
              state: \.rocketFirstStage,
              action: RocketDetailCore.Action.rocketFirstStage
            ),
            then: RocketFirstStageView.init(store:)
          )
          .padding()
          
          IfLetStore(
            self.store.scope(
              state: \.rocketSecondStage,
              action: RocketDetailCore.Action.rocketSecondStage
            ),
            then: RocketSecondStageView.init(store:)
          )
          .padding()
          
          IfLetStore(
            self.store.scope(
              state: \.rocketPhotos,
              action: RocketDetailCore.Action.rocketPhotos
            ),
            then: RocketPhotosView.init(store:)
          )
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigation) {
          NavigationLink(
            destination: RocketLaunchView(
              store: self.store.scope(
                state: \.rocketLaunch,
                action: RocketDetailCore.Action.rocketLaunch
              )
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
