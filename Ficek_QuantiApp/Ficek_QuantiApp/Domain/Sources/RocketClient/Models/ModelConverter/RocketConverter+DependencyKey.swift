import Foundation
import Dependencies
import ModelConvertible
//DiameterHeightConverterEnginesConverterFirstStageConverterSecondStageConverterMassConverterRocketConverter
enum DiameterConverterKey: DependencyKey {
    public static var liveValue: DiameterConverter = .live()
    public static var testValue: DiameterConverter = .test()
}

enum HeightConverterKey: DependencyKey {
    public static var liveValue: HeightConverter = .live()
    public static var testValue: HeightConverter = .test()
}

enum EnginesConverterKey: DependencyKey {
    public static var liveValue: EnginesConverter = .live()
    public static var testValue: EnginesConverter = .test()
}

enum FirstStageConverterKey: DependencyKey {
    public static var liveValue: FirstStageConverter = .live()
    public static var testValue: FirstStageConverter = .test()
}

enum SecondStageConverterKey: DependencyKey {
    public static var liveValue: SecondStageConverter = .live()
    public static var testValue: SecondStageConverter = .test()
}

enum MassConverterKey: DependencyKey {
    public static var liveValue: MassConverter = .live()
    public static var testValue: MassConverter = .test()
}

enum RocketConverterKey: DependencyKey {
    public static var liveValue: RocketConverter = .live()
    public static var testValue: RocketConverter = .test()
}

enum RocketsConverterKey: DependencyKey {
    public static var liveValue: RocketsConverter = .live()
    public static var testValue: RocketsConverter = .test()
}
