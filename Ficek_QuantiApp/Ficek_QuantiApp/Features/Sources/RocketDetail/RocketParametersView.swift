import SwiftUI
import ComposableArchitecture
import Resources
import RocketLaunch

struct RocketParametersView: View {
    let store: StoreOf<RocketParametersCore>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .leading, spacing: 16) {
                Text("Overview")
                    .font(.headline)
                Text(viewStore.rocket.description)
                    .font(.subheadline)
                Text("Parameters")
                    .font(.headline)
                HStack(alignment: .center, spacing: 36) {
                    Group {
                        VStack(spacing: 4) {
                            Text(viewStore.height)
                                .font(.system(size: 24))
                                .bold()
                            Text("height")
                                .font(.headline)
                        }
                        VStack(spacing: 4) {
                            Text(viewStore.diameter)
                                .font(.system(size: 24))
                                .bold()
                            Text("diameter")
                                .font(.headline)
                        }
                        VStack(spacing: 4) {
                            Text(viewStore.mass)
                                .font(.system(size: 24))
                                .bold()
                            Text("mass")
                                .font(.headline)
                        }
                    }
                    .frame(width: 108, height: 108)
                    .background (
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(SharedColors.pinkColor)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .foregroundColor(Color.white)
            }
            .padding()
        }
    }
}

struct RocketParametersView_Previews: PreviewProvider {
    static var previews: some View {
        RocketParametersView(
            store: Store(
                initialState: RocketParametersCore.State(rocket: .mock),
                reducer: RocketParametersCore()
            )
        )
    }
}
