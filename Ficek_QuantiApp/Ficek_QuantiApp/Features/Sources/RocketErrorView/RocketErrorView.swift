import Foundation
import ComposableArchitecture
import SwiftUI
import UIToolkit

public struct RocketErrorView: View {
  public var body: some View {
    
    VStack {
      Text("Oops")
        .font(.largeTitle)
      Text("Something went wrong")
      
      Image.rocketError
        .resizable()
        .frame(width: 150, height: 150)
        .background(.opacity(0))
      
//      Button("Refresh") { }
//      .foregroundColor(.black)
//      .background {
//        RoundedRectangle(cornerRadius: 5)
//          .foregroundColor(.pinkColor)
//          .padding(-20)
//      }
//      .padding(.top, 100)
    }
  }
}

struct RocketListView_Previews: PreviewProvider {
  static var previews: some View {
    RocketErrorView()
  }
}

