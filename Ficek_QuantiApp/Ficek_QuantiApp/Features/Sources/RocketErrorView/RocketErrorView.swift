//
//  File.swift
//  
//
//  Created by Martin Ficek on 02.05.2023.
//

import Foundation
import Resources
import ComposableArchitecture
import SwiftUI

public struct RocketErrorView: View {
    
   public var body: some View {
    
       VStack {
           Text("Oops")
               .font(.largeTitle)
           Text("Something went wrong")
           
           SharedImages.rocketErrorImage
               .resizable()
               .frame(width: 150, height: 150)
               .background(.opacity(0))
          
           Button("Close the app") {
               fatalError()
           }
           .foregroundColor(.black)
           .background {
               RoundedRectangle(cornerRadius: 5)
                   .foregroundColor(SharedColors.pinkColor)
                   .padding(-20)
           }
           .padding(.top, 100)
       }
    }
}

struct RocketListView_Previews: PreviewProvider {
    static var previews: some View {
        RocketErrorView()
    }
}

