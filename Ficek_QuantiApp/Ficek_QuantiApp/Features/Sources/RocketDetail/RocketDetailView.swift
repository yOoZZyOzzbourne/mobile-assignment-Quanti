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
                    RocketParametersView(store: store)
                    RocketFirstStageView(store: store)
                        .padding()
                    RocketSecondStageView(store: store)
                        .padding()
                    RocketPhotosView(store: store)
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
