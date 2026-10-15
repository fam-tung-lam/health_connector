import HealthKit

extension UserCharacteristicTypeDto {
    func toHKCharacteristicType() throws -> HKCharacteristicType {
        let identifier: HKCharacteristicTypeIdentifier = switch self {
        case .birthDate: .dateOfBirth
        case .biologicalSex: .biologicalSex
        }
        guard let type = HKObjectType.characteristicType(forIdentifier: identifier) else {
            throw HealthConnectorError.unsupportedOperation(
                message: "HealthKit characteristic is unavailable"
            )
        }
        return type
    }
}
