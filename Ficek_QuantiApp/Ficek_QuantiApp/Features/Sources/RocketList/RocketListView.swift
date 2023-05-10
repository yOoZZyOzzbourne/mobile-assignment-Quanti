import SwiftUI
import ComposableArchitecture
import RocketDetail
import UIToolkit

public struct RocketListView: View {
   public let store: StoreOf<RocketListCore>
    
    public init(store: StoreOf<RocketListCore>) {
        self.store = store
    }
    
   public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .leading) {
                NavigationStack {
                    List {
                        ForEachStore(
                            self.store.scope(
                                state: \.rocketItems,
                                action: RocketListCore.Action.rockets(id:action:))) { rocket in
                                    NavigationLink(
                                        destination: {
                                            RocketDetailView(store: rocket)
                                        },
                                        label: {
                                            RocketListPartView(store: rocket)
                                        }
                                    )
                                }
                    }
                    .navigationTitle("Rockets")
                    .onAppear {
                        viewStore.send(.task)
                    }
                    .alert(
                        self.store.scope(state: \.alert),
                        dismiss: .alertCancelTapped
                    )
                }
            }
        }
    }
}

struct RocketListView_Previews: PreviewProvider {
    static var previews: some View {
        RocketListView(
            store:
                Store(
                    initialState: RocketListCore.State(),
                    reducer: RocketListCore()
                )
        )
    }
}
