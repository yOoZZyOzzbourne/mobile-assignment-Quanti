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
                //TODO: If it fits, let it be
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

public typealias HeightConverter = ModelConverter<Height, HeightDTO>

public extension HeightConverter {
    static func live() -> Self {
        .init(
            externalModelConverter: { height in
                guard
                    let meters = height.meters,
                    let feet = height.feet
                else {
                    return nil
                }
                
                return HeightDTO(meters: meters, feet: feet)
            },
            domainModelConverter: { heightDTO in
                guard
                    let meters = heightDTO.meters,
                    let feet = heightDTO.feet
                else {
                    return nil
                }
                
                return Height(meters: meters, feet: feet)
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
                
                return EnginesDTO(number: number, type: type, version: engine.version)
            },
            domainModelConverter: { engineDTO in
                guard
                    let number = engineDTO.number,
                    let type = engineDTO.type
                else {
                    return nil
                }
                
                return Engines(number: number, type: type, version: engineDTO.version)
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
                   // let burnTimeSEC = firstStage.burnTimeSEC
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
                   // let burnTimeSEC = firstStageDTO.burnTimeSEC
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
                   // let burnTimeSEC = secondStage.burnTimeSEC
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
                   // let burnTimeSEC = secondStageDTO.burnTimeSEC
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

public typealias RocketConverter = ModelConverter<Rocket, RocketDTO>

public extension RocketConverter {
    static func live(
        massConverter: MassConverter,
        secondStageConverter: SecondStageConverter,
        firstStageConverter: FirstStageConverter,
        enginesConverter: EnginesConverter,
        diameterConverter: DiameterConverter,
        heightConverter: HeightConverter
    ) -> Self {
        .init(
            externalModelConverter: { rocket in
                guard
                    let mass = massConverter.externalModel(fromDomain: rocket.mass),
                    let engines = enginesConverter.externalModel(fromDomain: rocket.engines),
                    let diameter = diameterConverter.externalModel(fromDomain: rocket.diameter),
                    let secondStage = secondStageConverter.externalModel(fromDomain: rocket.secondStage),
                    let firstStage = firstStageConverter.externalModel(fromDomain: rocket.firstStage),
                    let height = heightConverter.externalModel(fromDomain: rocket.height)
                else {
                    return nil
                }
                
                return RocketDTO(
                    id: rocket.id,
                    firstFlight: rocket.firstFlight,
                    height: height,
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
                    let engines = enginesConverter.domainModel(fromExternal: rocketDTO.engines),
                    let diameter = diameterConverter.domainModel(fromExternal: rocketDTO.diameter),
                    let secondStage = secondStageConverter.domainModel(fromExternal: rocketDTO.secondStage),
                    let firstStage = firstStageConverter.domainModel(fromExternal: rocketDTO.firstStage),
                    let height = heightConverter.domainModel(fromExternal: rocketDTO.height)
                else {
                    return nil
                }
                
                return Rocket(
                    id: rocketDTO.id,
                    firstFlight: rocketDTO.firstFlight,
                    height: height,
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

public typealias RocketsConverter = ModelConverter<[Rocket], [RocketDTO]>

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

//TODO: Dependencies

//extension ModelConverter: TestDependencyKey where <#requirements#> {
//   
//    public static let testValue = Self(
//        unimplemented("\(Self.self).converter")
//    )
//
//}
//
//extension ModelConverter: TestDependencyKey where <#requirements#> {
//    <#witnesses#>
//}

//extension RocketsConverter: DependencyKey {
//    public static var liveValue: RocketsConverter {
//        return Self(
//            externalModelConverter: .live(),
//            domainModelConverter: .live()
//            )
//    }
//
//    public static let testValue = Self(
//        externalModelConverter: unimplemented("\(Self.self).converter"),
//        domainModelConverter: unimplemented("\(Self.self).converter")
//        )
//}
//
//
//extension RocketConverter {
//    static let test = Self(
//        externalModelConverter: unimplemented("\(Self.self).externalModelConverter"),
//        domainModelConverter: unimplemented("\(Self.self).domainModelConverter")
//      )
//}
//
//
//extension DependencyValues {
//    public var rocketsConverter: RocketsConverter {
//        get { self[RocketsConverter.self] }
//        set { self[RocketsConverter.self] = newValue }
//    }
//}

//DiameterConverter

//
//
extension ModelConverter: TestDependencyKey where <#requirements#> {
    <#witnesses#>
}

extension DiameterConverter: DependencyKey {
    public static var liveValue: DiameterConverter {
        return Self(
            externalModelConverter: { diameter in
                guard
                    let meters = diameter.meters,
                    let feet = diameter.feet
                else {
                    return nil
                }
                //TODO: If it fits, let it be
                return DiameterDTO(meters: meters, feet: feet)
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

    public static let testValue = Self(
        externalModelConverter: unimplemented("\(Self.self).converter"),
        domainModelConverter: unimplemented("\(Self.self).converter")
        )
}

extension DependencyValues {
    public var diameterConverter: DiameterConverter {
        get { self[DiameterConverter.self] }
        set { self[DiameterConverter.self] = newValue }
    }
}
