import Foundation
import Dependencies
import Combine
import Networking
import NetworkMonitoring
import APIClient
import RequestBuilder
import RequestBuilderClient
import ModelConvertible
import ErrorReporting

extension RocketClient: DependencyKey {
    
    public static var liveValue: RocketClient {
        
        @Dependency(\.apiClient) var apiClient
        @Dependency(\.requestBuilderClient) var requestBuilder
    
        return Self(
            fetchAllRockets: {
                let request = Request(
                    endpoint: "https://api.spacexdata.com/v4/rockets"
                )
                let networkClient =  NetworkClient(
                    urlRequester: .live(urlSessionConfiguration: .default),
                    networkMonitorClient: .live(onQueue: DispatchQueue.main)
                )
               
                let converter = RocketsConverter()
                

//                let req: AnyPublisher<[RocketDTO], RocketError> =
//                request
//                    .execute(using: networkClient)
//                    .mapErrorReporting(to: RocketError())
//                    //.convertToDomainModel(using: converter)
//                    .eraseToAnyPublisher()
//                //
//                return req
////                let r = req
//                    .convertToDomainModel(using: RocketsConverter())

      
                
                return request.execute(using: networkClient)
                    .mapErrorReporting(to: RocketError())
                    .convertToDomainModel(using: converter)
                    .eraseToAnyPublisher()
                  
              
            }
        )
    }
    
    public static let testValue = RocketClient(
        fetchAllRockets: unimplemented("\(Self.self).fetchAllRockets")
    )
    
    public static let previewValue = RocketClient(
        fetchAllRockets: {
            return Just([Rocket].mock)
                .setFailureType(to: RocketError.self)
                .eraseToAnyPublisher()
        }
    )
}

public typealias DiameterConverter = ModelConverter<Diameter, DiameterDTO>

public extension DiameterConverter {
  static func live() -> Self {
    .init(
      externalModelConverter: { diameter in
        guard
            let meters = diameter.meters,
            let feet = diameter.feet
        else {
          return nil
        }
          return DiameterDTO(meters: meters, feet: feet)
      },
      domainModelConverter: { diameterDTO in
        guard
            let meters = diameterDTO.meters,
            let feet = diameterDTO.feet
        else {
          return nil
        }
          return Diameter(meters: meters, feet: feet)
      }
    )
  }
}

public typealias EnginesConverter = ModelConverter<Engines, EnginesDTO>

public extension EnginesConverter {
  static func live() -> Self {
    .init(
      externalModelConverter: { engine in
        guard
            let number = engine.number,
            let type = engine.type,
            let version = engine.version
        else {
          return nil
        }
        return EnginesDTO(number: number, type: type, version: version)
      },
      domainModelConverter: { engineDTO in
        guard
            let number = engineDTO.number,
            let type = engineDTO.type,
            let version = engineDTO.version
        else {
          return nil
        }
          return Engines(number: number, type: type, version: version)
      }
    )
  }
}

public typealias FirstStageConverter = ModelConverter<FirstStage, FirstStageDTO>

public extension FirstStageConverter {
  static func live() -> Self {
    .init(
      externalModelConverter: { firstStage in
        guard
            let reusable = firstStage.reusable,
            let engines = firstStage.engines,
            let fuelAmountTons = firstStage.fuelAmountTons,
            let burnTimeSEC = firstStage.burnTimeSEC
        else {
          return nil
        }
        return FirstStageDTO(reusable: reusable, engines: engines, fuelAmountTons: fuelAmountTons, burnTimeSEC: burnTimeSEC)
      },
      domainModelConverter: { firstStageDTO in
        guard
            let reusable = firstStageDTO.reusable,
            let engines = firstStageDTO.engines,
            let fuelAmountTons = firstStageDTO.fuelAmountTons,
            let burnTimeSEC = firstStageDTO.burnTimeSEC
        else {
          return nil
        }
        return FirstStage(reusable: reusable, engines: engines, fuelAmountTons: fuelAmountTons, burnTimeSEC: burnTimeSEC)
      }
    )
  }
}

public typealias SecondStageConverter = ModelConverter<SecondStage, SecondStageDTO>

public extension SecondStageConverter {
  static func live() -> Self {
    .init(
      externalModelConverter: { secondStage in
        guard
            let reusable = secondStage.reusable,
            let engines = secondStage.engines,
            let fuelAmountTons = secondStage.fuelAmountTons,
            let burnTimeSEC = secondStage.burnTimeSEC
        else {
          return nil
        }
        return SecondStageDTO(reusable: reusable, engines: engines, fuelAmountTons: fuelAmountTons, burnTimeSEC: burnTimeSEC)
      },
      domainModelConverter: { secondStageDTO in
        guard
            let reusable = secondStageDTO.reusable,
            let engines = secondStageDTO.engines,
            let fuelAmountTons = secondStageDTO.fuelAmountTons,
            let burnTimeSEC = secondStageDTO.burnTimeSEC
        else {
          return nil
        }
        return SecondStage(reusable: reusable, engines: engines, fuelAmountTons: fuelAmountTons, burnTimeSEC: burnTimeSEC)
      }
    )
  }
}

public typealias MassConverter = ModelConverter<Mass, MassDTO>

public extension MassConverter {
  static func live() -> Self {
    .init(
      externalModelConverter: { mass in
        guard
            let kg = mass.kg,
            let lb = mass.lb
        else {
          return nil
        }
        return MassDTO(kg: kg, lb: lb)
      },
      domainModelConverter: { massDTO in
        guard
            let kg = massDTO.kg,
            let lb = massDTO.lb
        else {
          return nil
        }
          return Mass(kg: kg, lb: lb)
      }
    )
  }
}

public typealias RocketConverter = ModelConverter<Rocket,RocketDTO>

public extension RocketConverter {
  static func live(
    massConverter: MassConverter,
    secondStageConverter: SecondStageConverter,
    firstStageConverter: FirstStageConverter,
    enginesConverter: EnginesConverter,
    diameterConverter: DiameterConverter
    ) -> Self {
    .init(
      externalModelConverter: { rocket in
        guard
            let mass = massConverter.externalModel(fromDomain: rocket.mass),
            let secondStage = secondStageConverter.externalModel(fromDomain: rocket.secondStage),
            let firstStage = firstStageConverter.externalModel(fromDomain: rocket.firstStage),
            let engines = enginesConverter.externalModel(fromDomain: rocket.engines),
            let diameter = diameterConverter.externalModel(fromDomain: rocket.diameter)
        else {
          return nil
        }

          return RocketDTO(id: rocket.id, firstFlight: rocket.firstFlight, height: diameter, diameter: diameter, mass: mass, firstStage: firstStage, secondStage: secondStage, engines: engines, flickrImages: rocket.flickrImages, description: rocket.description, name: rocket.name, type: rocket.type)
      },
      domainModelConverter: { rocketDTO in
        guard
            let mass = massConverter.domainModel(fromExternal: rocketDTO.mass),
            let secondStage = secondStageConverter.domainModel(fromExternal: rocketDTO.secondStage),
            let firstStage = firstStageConverter.domainModel(fromExternal: rocketDTO.firstStage),
            let engines = enginesConverter.domainModel(fromExternal: rocketDTO.engines),
            let diameter = diameterConverter.domainModel(fromExternal: rocketDTO.diameter)
        else {
          return nil
        }

        return Rocket(id: rocketDTO.id, firstFlight: rocketDTO.firstFlight, height: diameter, diameter: diameter, mass: mass, firstStage: firstStage, secondStage: secondStage, engines: engines, flickrImages: rocketDTO.flickrImages, description: rocketDTO.description, name: rocketDTO.name, type: rocketDTO.type)
      }
    )
  }
}


public typealias RocketsConverter = ModelConverter<[Rocket],[RocketDTO]>

public extension RocketsConverter {
  static func live(
    rocketConverter: RocketConverter
    ) -> Self {
    .init(
      externalModelConverter: { rocket in
          var rockets: Array<RocketDTO> = []
          for r in rocket {
              rockets.append(rocketConverter.externalModel(fromDomain: r) ?? .mock)
          }
//          return rocket.compactMap(rocketConverter.externalModel(fromDomain:))
       return rockets
      },
      domainModelConverter: { rocketDTO in
          //return rocketDTO.compactMap(rocketConverter.domainModel(fromExternal:))
          var rocketsDTO: Array<Rocket> = []
          for r in rocketDTO {
              rocketsDTO.append(rocketConverter.domainModel(fromExternal: r) ?? .mock)
          }
//          return rocket.compactMap(rocketConverter.externalModel(fromDomain:))
       return rocketsDTO
      }
    )
  }
}
