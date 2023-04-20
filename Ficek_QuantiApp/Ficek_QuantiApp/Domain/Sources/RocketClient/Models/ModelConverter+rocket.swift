import Foundation
import Dependencies
import ModelConvertible

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
                
                return DiameterDTO(
                    meters: meters,
                    feet: feet
                )
            },
            domainModelConverter: { diameterDTO in
                guard
                    let meters = diameterDTO.meters,
                    let feet = diameterDTO.feet
                else {
                    return nil
                }
                
                return Diameter(
                    meters: meters,
                    feet: feet
                )
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
                    let type = engine.type
                else {
                    return nil
                }
                
                return EnginesDTO(
                    number: number,
                    type: type,
                    version: engine.version
                )
            },
            domainModelConverter: { engineDTO in
                guard
                    let number = engineDTO.number,
                    let type = engineDTO.type
                else {
                    return nil
                }
                
                return Engines(
                    number: number,
                    type: type,
                    version: engineDTO.version
                )
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
                    let fuelAmountTons = firstStage.fuelAmountTons
                else {
                    return nil
                }
                
                return FirstStageDTO(
                    reusable: reusable,
                    engines: engines,
                    fuelAmountTons: fuelAmountTons,
                    burnTimeSEC: firstStage.burnTimeSEC
                )
            },
            domainModelConverter: { firstStageDTO in
                guard
                    let reusable = firstStageDTO.reusable,
                    let engines = firstStageDTO.engines,
                    let fuelAmountTons = firstStageDTO.fuelAmountTons
                else {
                    return nil
                }
                
                return FirstStage(
                    reusable: reusable,
                    engines: engines,
                    fuelAmountTons: fuelAmountTons,
                    burnTimeSEC: firstStageDTO.burnTimeSEC
                )
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
                    let fuelAmountTons = secondStage.fuelAmountTons
                else {
                    return nil
                }
                
                return SecondStageDTO(
                    reusable: reusable,
                    engines: engines,
                    fuelAmountTons: fuelAmountTons,
                    burnTimeSEC: secondStage.burnTimeSEC
                )
            },
            domainModelConverter: { secondStageDTO in
                guard
                    let reusable = secondStageDTO.reusable,
                    let engines = secondStageDTO.engines,
                    let fuelAmountTons = secondStageDTO.fuelAmountTons
                else {
                    return nil
                }
                
                return SecondStage(
                    reusable: reusable,
                    engines: engines,
                    fuelAmountTons: fuelAmountTons,
                    burnTimeSEC: secondStageDTO.burnTimeSEC
                )
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
                    let engines = enginesConverter.externalModel(fromDomain: rocket.engines),
                    let diameter = diameterConverter.externalModel(fromDomain: rocket.diameter),
                    let secondStage = secondStageConverter.externalModel(
                        fromDomain: rocket.secondStage
                    ),
                    let firstStage = firstStageConverter.externalModel(
                        fromDomain: rocket.firstStage
                    )
                else {
                    return nil
                }
                
                return RocketDTO(
                    id: rocket.id,
                    firstFlight: rocket.firstFlight,
                    height: diameter,
                    diameter: diameter,
                    mass: mass,
                    firstStage: firstStage,
                    secondStage: secondStage,
                    engines: engines,
                    flickrImages: rocket.flickrImages,
                    description: rocket.description,
                    name: rocket.name,
                    type: rocket.type
                )
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
                
                return Rocket(
                    id: rocketDTO.id,
                    firstFlight: rocketDTO.firstFlight,
                    height: diameter,
                    diameter: diameter,
                    mass: mass,
                    firstStage: firstStage,
                    secondStage: secondStage,
                    engines: engines,
                    flickrImages: rocketDTO.flickrImages,
                    description: rocketDTO.description,
                    name: rocketDTO.name,
                    type: rocketDTO.type
                )
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
                return rocket.compactMap(rocketConverter.externalModel(fromDomain:))
            },
            domainModelConverter: { rocketDTO in
                return rocketDTO.compactMap(rocketConverter.domainModel(fromExternal:))
            }
        )
    }
}


//extension ModelConverter: TestDependencyKey where <#requirements#> {
//   
//    public static let testValue = Self(
//        unimplemented("\(Self.self).converter")
//    )
//
//}
//
//extension RocketsConverter: DependencyKey {
//    public static var liveValue: RocketsConverter {
//        return Self(
//            
//            )
//    }
//}
//
//extension DependencyValues {
//    public var rocketsConverter: RocketsConverter {
//        get { self[RocketsConverter.self] }
//        set { self[RocketsConverter.self] = newValue }
//    }
//}
