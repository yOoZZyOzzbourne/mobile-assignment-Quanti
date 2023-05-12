import SwiftUI
import ComposableArchitecture
import RocketLaunch
import UIToolkit

struct RocketFirstStageView: View {
  let store: StoreOf<RocketFirstStageCore>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(alignment: .leading, spacing: 16) {
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
