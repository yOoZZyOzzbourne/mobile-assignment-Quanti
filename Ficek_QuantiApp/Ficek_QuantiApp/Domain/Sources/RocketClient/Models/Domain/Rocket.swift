import Foundation

//MARK: Rocket Struct
public struct Rocket: Equatable, Identifiable {
  public var id: String
  public var firstFlight: String
  public var height: Height
  public var diameter: Diameter
  public var mass: Mass
  public var firstStage: FirstStage
  public var secondStage: SecondStage
  public var engines: Engines
  public var flickrImages: [String]
  public var description: String
  public var name: String
  public var type: String
}

public struct Diameter: Equatable {
  public var meters: Double?
  public var feet: Double?
}

public struct Engines: Equatable {
  public var number: Int?
  public var type: String?
  public var version: String
}

public struct FirstStage: Equatable {
  public var reusable: Bool?
  public var engines: Int?
  public var fuelAmountTons: Double?
  public var burnTimeSEC: Int?
}

public struct Mass: Equatable {
  public var kg: Int?
  public var lb: Int?
}

public struct SecondStage: Equatable {
  public var reusable: Bool?
  public var engines: Int?
  public var fuelAmountTons: Double?
  public var burnTimeSEC: Int?
}

public struct Height: Equatable {
  public var meters: Double?
  public var feet: Double?
}
