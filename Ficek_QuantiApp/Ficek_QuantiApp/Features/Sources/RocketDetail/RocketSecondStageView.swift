import SwiftUI
import ComposableArchitecture
import Resources
import RocketLaunch

struct RocketSecondStageView: View {
    let store: StoreOf<RocketDetailCore>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .leading, spacing: 16){
                Text("Second Stage")
                    .font(.headline)
                Group {
                    HStack(spacing: 16) {
                        SharedImages.reusableImage
                        Text(viewStore.reusableSecondSt)
                    }
                    HStack(spacing: 16) {
                        SharedImages.engineImage
                        Text(viewStore.enginesSecondSt)
                    }
                    HStack(spacing: 16) {
                        SharedImages.fuelImage
                        Text(viewStore.fuelAmmountSecondSt)
                    }
                    HStack(spacing: 16) {
                        SharedImages.burnImage
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
                initialState: RocketDetailCore.State(rocket: .mock, rocketLaunch: RocketLaunchCore.State.init()),
                reducer: RocketDetailCore()
            )
        )
    }
}
