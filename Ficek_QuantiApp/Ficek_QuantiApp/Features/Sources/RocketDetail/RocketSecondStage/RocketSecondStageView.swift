import SwiftUI
import ComposableArchitecture
import RocketLaunch
import UIToolkit

public struct RocketSecondStageView: View {
  let store: StoreOf<RocketSecondStageCore>
  @ObservedObject public var viewStore: ViewStore<ViewState, RocketSecondStageCore.Action>
  
  public struct ViewState: Equatable {
    public let reusableSecondSt: LocalizedStringKey
    public let enginesSecondSt: LocalizedStringKey
    public let fuelAmmountSecondSt: String
    public let burnTimeSecondSt: LocalizedStringKey
    
    public init(state: RocketSecondStageCore.State) {
      self.reusableSecondSt = state.rocket.secondStage.reusable ?? false ? .reusable : .notReusable
      self.enginesSecondSt = .engines(state.rocket.secondStage.engines ?? 0)
      self.fuelAmmountSecondSt = "\(state.rocket.secondStage.fuelAmountTons ?? 0) tons of fuel"
      self.burnTimeSecondSt = .secondsBurnTime(state.rocket.secondStage.burnTimeSEC ?? 0)
    }
  }
  
  public init(store: StoreOf<RocketSecondStageCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { ViewState(state: $0) })
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 16){
      Text("Second Stage")
        .font(.headline)
      Group {
        HStack(spacing: 16) {
          Image.reusable
          Text(viewStore.reusableSecondSt)
        }
        HStack(spacing: 16) {
          Image.engine
          Text(viewStore.enginesSecondSt)
        }
        HStack(spacing: 16) {
          Image.fuel
          Text(viewStore.fuelAmmountSecondSt)
        }
        HStack(spacing: 16) {
          Image.burn
          Text(viewStore.burnTimeSecondSt)
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

struct RocketSecondStageView_Previews: PreviewProvider {
  static var previews: some View {
    RocketSecondStageView(
      store: Store(
        initialState: RocketSecondStageCore.State(rocket: .mock),
        reducer: RocketSecondStageCore()
      )
    )
  }
}
