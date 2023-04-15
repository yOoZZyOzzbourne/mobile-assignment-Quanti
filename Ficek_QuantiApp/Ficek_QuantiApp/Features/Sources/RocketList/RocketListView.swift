//
//  RocketListView.swift
//  Ficek_QuantiApp
//
//  Created by Martin Ficek on 24.02.2023.
//

import SwiftUI
import ComposableArchitecture
import RocketDetail

public struct RocketListView: View {
   public let store: StoreOf<RocketListCore>
    
    public init(store: StoreOf<RocketListCore>) {
        self.store = store
    }
    
   public var body: some View {
        WithViewStore(self.store, observe: \.rocketItems) { viewStore in
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
                    .navigationBarTitleDisplayMode(.large)
                    .onAppear{
                        viewStore.send(.task)
                    }
                }
            }
        }
    }
}

struct RocketListView_Previews: PreviewProvider {
    static var previews: some View {
        RocketListView(store: Store(initialState: RocketListCore.State(), reducer: RocketListCore()))
    }
}
