import Foundation

//MARK: Rocket Struct
public struct Rocket: Equatable, Identifiable, Codable {
    public var id: String
    public var firstFlight: String
    public var height, diameter: Diameter
    public var mass: Mass
    public var firstStage: FirstStage
    public var secondStage: SecondStage
    public var engines: Engines
    public var flickrImages: [String]
    public var description: String
    public var name: String
    public var type: String
 
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case firstFlight = "first_flight"
//        case height, diameter, mass
//        case firstStage = "first_stage"
//        case secondStage = "second_stage"
//        case engines
//        case flickrImages = "flickr_images"
//        case description
//        case name = "name"
//        case type = "type"
//    }
}

public struct Diameter: Equatable, Codable {
    public var meters: Double?
    public var feet: Double?
}

public struct Engines: Equatable, Codable {
    public var number: Int?
    public var type: String?
    public var version: String?

//    enum CodingKeys: String, CodingKey {
//        case number
//        case type
//        case version
//    }
}

public struct FirstStage: Equatable, Codable {
   public var reusable: Bool?
   public var engines: Int?
   public var fuelAmountTons: Double?
   public var burnTimeSEC: Int?

//    enum CodingKeys: String, CodingKey {
//        case reusable, engines
//        case fuelAmountTons = "fuel_amount_tons"
//        case burnTimeSEC = "burn_time_sec"
//    }
}

public struct Mass: Equatable, Codable {
   public var kg: Int?
   public var lb: Int?
}

public struct SecondStage: Equatable, Codable {
   public var reusable: Bool?
   public var engines: Int?
   public var fuelAmountTons: Double?
   public var burnTimeSEC: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case reusable, engines
//        case fuelAmountTons = "fuel_amount_tons"
//        case burnTimeSEC = "burn_time_sec"
//    }
}
