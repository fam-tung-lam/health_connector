import Foundation
import HealthKit

extension MassDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .kilograms:
                .gramUnit(with: .kilo)
            case .grams:
                .gram()
            case .pounds:
                .pound()
            case .ounces:
                .ounce()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `MassDto`.
    ///
    /// Uses kilograms as the transfer unit for consistency.
    func toMassDto() -> MassDto {
        let kilograms = doubleValue(for: .gramUnit(with: .kilo))
        return MassDto(unit: .kilograms, value: kilograms)
    }
}

extension EnergyDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .kilocalories:
                .kilocalorie()
            case .kilojoules:
                .jouleUnit(with: .kilo)
            case .calories:
                .smallCalorie()
            case .joules:
                .joule()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to an `EnergyDto`.
    ///
    /// Uses kilocalories as the transfer unit for consistency.
    func toEnergyDto() -> EnergyDto {
        let kilocalories = doubleValue(for: .kilocalorie())
        return EnergyDto(unit: .kilocalories, value: kilocalories)
    }
}

extension LengthDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .meters:
                .meter()
            case .kilometers:
                .meterUnit(with: .kilo)
            case .miles:
                .mile()
            case .feet:
                .foot()
            case .inches:
                .inch()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `LengthDto`.
    ///
    /// Uses meters as the transfer unit for consistency.
    func toLengthDto() -> LengthDto {
        let meters = doubleValue(for: .meter())
        return LengthDto(unit: .meters, value: meters)
    }
}

extension TemperatureDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .celsius:
                .degreeCelsius()
            case .fahrenheit:
                .degreeFahrenheit()
            case .kelvin:
                .kelvin()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `TemperatureDto`.
    ///
    /// Uses celsius as the transfer unit for consistency.
    func toTemperatureDto() -> TemperatureDto {
        let celsius = doubleValue(for: .degreeCelsius())
        return TemperatureDto(unit: .celsius, value: celsius)
    }
}

extension PressureDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .millimetersOfMercury:
                .millimeterOfMercury()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `PressureDto`.
    ///
    /// Uses millimeters of mercury as the transfer unit.
    func toPressureDto() -> PressureDto {
        let mmHg = doubleValue(for: .millimeterOfMercury())
        return PressureDto(unit: .millimetersOfMercury, value: mmHg)
    }
}

extension VelocityDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .metersPerSecond:
                .meter().unitDivided(by: .second())
            case .kilometersPerHour:
                .meterUnit(with: .kilo).unitDivided(by: .hour())
            case .milesPerHour:
                .mile().unitDivided(by: .hour())
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `VelocityDto`.
    ///
    /// Uses meters per second as the transfer unit for consistency.
    func toVelocityDto() -> VelocityDto {
        let metersPerSecond = doubleValue(for: .meter().unitDivided(by: .second()))
        return VelocityDto(unit: .metersPerSecond, value: metersPerSecond)
    }
}

extension VolumeDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .liters:
                .liter()
            case .milliliters:
                .literUnit(with: .milli)
            case .fluidOuncesUs:
                .fluidOunceUS()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `VolumeDto`.
    ///
    /// Uses liters as the transfer unit for consistency.
    func toVolumeDto() -> VolumeDto {
        let liters = doubleValue(for: .liter())
        return VolumeDto(unit: .liters, value: liters)
    }
}

extension PowerDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    @available(iOS 16.0, *)
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .watts:
                .watt()
            case .kilowatts:
                .wattUnit(with: .kilo)
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `PowerDto`.
    ///
    /// Uses watts as the transfer unit for consistency.
    @available(iOS 16.0, *)
    func toPowerDto() -> PowerDto {
        let watts = doubleValue(for: .watt())
        return PowerDto(unit: .watts, value: watts)
    }
}

extension BloodGlucoseDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit =
            switch self.unit {
            case .millimolesPerLiter:
                // Molar mass of glucose is 180.16 g/mol
                HKUnit.moleUnit(with: .milli, molarMass: 180.16)
                    .unitDivided(by: .liter())
            case .milligramsPerDeciliter:
                HKUnit.gramUnit(with: .milli)
                    .unitDivided(by: HKUnit.literUnit(with: .deci))
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `BloodGlucoseDto`.
    ///
    /// Uses millimoles per liter as the transfer unit for consistency.
    func toBloodGlucoseDto() -> BloodGlucoseDto {
        // Molar mass of glucose is 180.16 g/mol
        let mmolPerL = doubleValue(
            for: HKUnit.moleUnit(with: .milli, molarMass: 180.16)
                .unitDivided(by: .liter()))
        return BloodGlucoseDto(unit: .millimolesPerLiter, value: mmolPerL)
    }
}

extension NumericDto {
    /// Converts this DTO to an Int64 value (for step counts).
    func toInt64() -> Int64 {
        Int64(value)
    }
}

extension Int64 {
    /// Converts an Int64 value (for step counts) to a `NumericDto`.
    ///
    /// Uses numeric unit for consistency.
    func toNumericDto() -> NumericDto {
        NumericDto(unit: .numeric, value: Double(self))
    }
}

extension PercentageDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let percentValue: Double =
            switch unit {
            case .decimal:
                value
            case .whole:
                value / 100.0
            }
        return HKQuantity(unit: .percent(), doubleValue: percentValue)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `PercentageDto`.
    ///
    /// Uses decimal as the transfer unit for consistency (0.0 to 1.0).
    func toPercentageDto() -> PercentageDto {
        let decimalValue = doubleValue(for: .percent())
        return PercentageDto(unit: .decimal, value: decimalValue)
    }
}

extension TimeDurationDto {
    /// Converts this DTO to a TimeInterval (seconds as Double).
    func toTimeInterval() -> TimeInterval {
        let seconds: Double =
            switch unit {
            case .seconds:
                value
            case .minutes:
                value * 60.0
            case .hours:
                value * 3600.0
            }
        return TimeInterval(seconds)
    }
}

extension TimeInterval {
    /// Converts a TimeInterval (seconds) to an TimeDurationDto.
    ///
    /// Uses seconds as the transfer unit for consistency.
    func toIntervalDto() -> TimeDurationDto {
        TimeDurationDto(unit: .seconds, value: self)
    }
}
