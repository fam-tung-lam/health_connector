import HealthKit

extension HKBiologicalSex {
    func toDto() throws -> BiologicalSexDto {
        switch self {
        case .notSet:
            throw HKError(.errorNoData)
        case .female:
            return .female
        case .male:
            return .male
        case .other:
            return .other
        @unknown default:
            throw HealthConnectorError.unsupportedOperation(
                message: "Unrecognized HealthKit biological sex value"
            )
        }
    }
}
