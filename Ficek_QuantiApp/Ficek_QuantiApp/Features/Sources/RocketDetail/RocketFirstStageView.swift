import SwiftUI
import ComposableArchitecture
import Resources

struct RocketFirstStageView: View {
    let store: StoreOf<RocketDetailCore>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .leading, spacing: 16){
                Text("First Stage")
                    .font(.headline)
                Group {
                    HStack(spacing: 16) {
                        SharedImages.reusableImage
                        Text(viewStore.reusableFirstSt)
                    }
                    HStack(spacing: 16) {
                        SharedImages.engineImage
                        Text(viewStore.enginesFirstSt)
                    }
                    HStack(spacing: 16) {
                        SharedImages.fuelImage
                        Text(viewStore.fuelAmmountFirstSt)
                    }
                    HStack(spacing: 16) {
                        SharedImages.burnImage
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
                initialState: RocketDetailCore.State(rocket: .mock),
                reducer: RocketDetailCore()
            )
        )
    }
}
