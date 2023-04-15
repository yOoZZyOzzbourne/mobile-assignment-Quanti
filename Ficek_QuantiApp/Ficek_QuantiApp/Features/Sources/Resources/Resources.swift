import Foundation
import SwiftUI

public enum SharedImages {
    public static let rocketImage = Image("Rocket", bundle: .module)
    public static let burnImage = Image("Burn", bundle: .module)
    public static let engineImage = Image("Engine", bundle: .module)
    public static let fuelImage = Image("Fuel", bundle: .module)
    public static let reusableImage = Image("Reusable", bundle: .module)
    public static let rocketFlyingImage = Image("Rocket Flying", bundle: .module)
    public static let rocketIdleImage = Image("Rocket Idle", bundle: .module)
}

public enum SharedColors {
    public static let pinkColor = Color("PinkAsImages", bundle: .module)
    
}
