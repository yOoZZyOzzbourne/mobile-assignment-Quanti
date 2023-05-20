import Foundation
import Dependencies
import ModelConvertible

extension DependencyValues {
  public var diameterConverter: DiameterConverter {
    get { self[DiameterConverterKey.self] }
    set { self[DiameterConverterKey.self] = newValue }
  }
}

extension DependencyValues {
  public var heightConverter: HeightConverter {
    get { self[HeightConverterKey.self] }
    set { self[HeightConverterKey.self] = newValue }
  }
}

extension DependencyValues {
  public var enginesConverter: EnginesConverter {
    get { self[EnginesConverterKey.self] }
    set { self[EnginesConverterKey.self] = newValue }
  }
}

extension DependencyValues {
  public var firstStageConverter: FirstStageConverter {
    get { self[FirstStageConverterKey.self] }
    set { self[FirstStageConverterKey.self] = newValue }
  }
}

extension DependencyValues {
  public var secondStageConverter: SecondStageConverter {
    get { self[SecondStageConverterKey.self] }
    set { self[SecondStageConverterKey.self] = newValue }
  }
}

extension DependencyValues {
  public var massConverter: MassConverter {
    get { self[MassConverterKey.self] }
    set { self[MassConverterKey.self] = newValue }
  }
}

extension DependencyValues {
  public var rocketConverter: RocketConverter {
    get { self[RocketConverterKey.self] }
    set { self[RocketConverterKey.self] = newValue }
  }
}

extension DependencyValues {
  public var rocketsConverter: RocketsConverter {
    get { self[RocketsConverterKey.self] }
    set { self[RocketsConverterKey.self] = newValue }
  }
}
