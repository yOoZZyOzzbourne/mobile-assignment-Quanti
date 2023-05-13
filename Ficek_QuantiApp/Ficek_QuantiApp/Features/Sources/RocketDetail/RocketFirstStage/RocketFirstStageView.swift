import SwiftUI
import ComposableArchitecture
import RocketLaunch
import UIToolkit

struct RocketFirstStageView: View {
  let store: StoreOf<RocketFirstStageCore>
  @ObservedObject var viewStore: ViewStore<ViewState, RocketFirstStageCore.Action>
  
  struct ViewState: Equatable {
    let reusableFirstSt: LocalizedStringKey
    let enginesFirstSt: LocalizedStringKey
    let fuelAmmountFirstSt: String
    let burnTimeFirstSt: LocalizedStringKey
    
    init(state: RocketFirstStageCore.State) {
      self.reusableFirstSt = state.rocket.firstStage.reusable ?? false ? .reusable : .notReusable
      self.enginesFirstSt = .engines(state.rocket.firstStage.engines ?? 0)
      self.fuelAmmountFirstSt = "\(state.rocket.firstStage.fuelAmountTons ?? 0) tons of fuel"
      self.burnTimeFirstSt = .secondsBurnTime(state.rocket.firstStage.burnTimeSEC ?? 0)
    }
  }
  
  public init(store: StoreOf<RocketFirstStageCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { ViewState(state: $0) })
  }
  
  
  var body: some View {
      VStack(alignment: .leading, spacing: 16){
        Text("First Stage")
          .font(.headline)
        Group {
          HStack(spacing: 16) {
            Image.reusable
            Text(viewStore.reusableFirstSt)
          }
          HStack(spacing: 16) {
            Image.engine
            Text(viewStore.enginesFirstSt)
          }
          HStack(spacing: 16) {
            Image.fuel
            Text(viewStore.fuelAmmountFirstSt)
          }
          HStack(spacing: 16) {
            Image.burn
            Text(viewStore.burnTimeFirstSt)
          }
        }
        .font(.subheadline)
      }
      .padding(16)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(Color(.gray).opacity(0.2))
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}

struct RocketFirstStageView_Previews: PreviewProvider {
  static var previews: some View {
    RocketFirstStageView(
      store: Store(
        initialState: RocketFirstStageCore.State(rocket: .mock),
        reducer: RocketFirstStageCore()
      )
    )
  }
}
