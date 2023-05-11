import Foundation

//MARK: RocketDTO Struct
public struct RocketDTO: Codable, Equatable, Identifiable {
  public var id: String
  public var firstFlight: String
  public var height: HeightDTO
  public var diameter: DiameterDTO
  public var mass: MassDTO
  public var firstStage: FirstStageDTO
  public var secondStage: SecondStageDTO
  public var engines: EnginesDTO
  public var flickrImages: [String]
  public var description: String
  public var name: String
  public var type: String
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case firstFlight = "first_flight"
    case height
    case diameter
    case mass
    case firstStage = "first_stage"
    case secondStage = "second_stage"
    case engines
    case flickrImages = "flickr_images"
    case description
    case name = "name"
    case type = "type"
  }
}
//TODO: Each value - new row
public struct DiameterDTO: Codable, Equatable {
  public var meters: Double?
  public var feet: Double?
}

public struct EnginesDTO: Codable, Equatable {
  public var number: Int?
  public var type: String?
  public var version: String
  
  enum CodingKeys: String, CodingKey {
    case number
    case type
    case version
  }
}

public struct FirstStageDTO: Codable, Equatable {
  public var reusable: Bool?
  public var engines: Int?
  public var fuelAmountTons: Double?
  public var burnTimeSEC: Int?
  
  enum CodingKeys: String, CodingKey {
    case reusable
    case engines
    case fuelAmountTons = "fuel_amount_tons"
    case burnTimeSEC = "burn_time_sec"
  }
}

public struct MassDTO: Codable, Equatable  {
  public var kg: Int?
  public var lb: Int?
}

public struct SecondStageDTO: Codable, Equatable {
  public var reusable: Bool?
  public var engines: Int?
  public var fuelAmountTons: Double?
  public var burnTimeSEC: Int?
  
  enum CodingKeys: String, CodingKey {
    case reusable
    case engines
    case fuelAmountTons = "fuel_amount_tons"
    case burnTimeSEC = "burn_time_sec"
  }
}

public struct HeightDTO: Codable, Equatable {
  public var meters: Double?
  public var feet: Double?
}
