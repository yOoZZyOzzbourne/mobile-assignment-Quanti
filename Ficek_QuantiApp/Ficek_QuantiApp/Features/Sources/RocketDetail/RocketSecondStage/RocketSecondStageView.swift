import SwiftUI
import ComposableArchitecture
import RocketLaunch
import UIToolkit

struct RocketSecondStageView: View {
  let store: StoreOf<RocketSecondStageCore>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
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
