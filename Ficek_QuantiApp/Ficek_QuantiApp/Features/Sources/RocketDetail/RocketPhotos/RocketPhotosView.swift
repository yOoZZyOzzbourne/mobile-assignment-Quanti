import SwiftUI
import ComposableArchitecture
import RocketLaunch

public struct RocketPhotosView: View {
  let store: StoreOf<RocketPhotosCore>
  @ObservedObject public var viewStore: ViewStore<ViewState, RocketPhotosCore.Action>
  
  public struct ViewState: Equatable {
    public let rocketImages: [String]
    
    public init(state: RocketPhotosCore.State) {
      self.rocketImages = state.rocket.flickrImages
    }
  }
  
  public init(store: StoreOf<RocketPhotosCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { ViewState(state: $0) })
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      Text("Photos")
        .font(.headline)
        .padding(.leading, 16)
      
      ForEach (viewStore.rocketImages, id: \.self) { image in
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
