import SwiftUI
import ComposableArchitecture
import RocketLaunch

struct RocketPhotosView: View {
  let store: StoreOf<RocketPhotosCore>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(alignment: .leading) {
        Text("Photos")
          .font(.headline)
          .padding(.leading, 16)
        
        ForEach (viewStore.rocket.flickrImages, id: \.self) { image in
          
          AsyncImage(
            url: URL(string: image),
            content: {
              $0
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaledToFit()
                .padding(15)
            },
            placeholder: {
              ProgressView()
            }
          )
        }
      }
    }
  }
}

struct RocketPhotosView_Previews: PreviewProvider {
  static var previews: some View {
    RocketPhotosView(
      store: Store(
        initialState: RocketPhotosCore.State(rocket: .mock),
        reducer: RocketPhotosCore()
      )
    )
  }
}
