import Foundation
import HealthKit

/// Reads characteristics from the client's existing store.
struct HealthConnectorUserCharacteristicService {
    private let store: HKHealthStore

    init(store: HKHealthStore) {
        self.store = store
    }

    func readBirthDate() throws -> BirtDateDto? {
        try read {
            let components = try store.dateOfBirthComponents()
            guard let year = components.year,
                  let month = components.month,
                  let day = components.day
            else {
                throw HealthConnectorError.invalidArgument(
                    message: "HealthKit returned an incomplete birth date"
                )
            }
            return BirtDateDto(year: Int64(year), month: Int64(month), day: Int64(day))
        }
    }

    func readBiologicalSex() throws -> BiologicalSexDto? {
        try read {
            try store.biologicalSex().biologicalSex.toDto()
        }
    }

    private func read<Value>(_ operation: () throws -> Value) throws -> Value? {
        do {
            return try operation()
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as HKError {
            if error.code == .errorNoData {
                return nil
            }
            throw HealthConnectorError.create(from: error)
        } catch {
            throw HealthConnectorError.create(from: error)
        }
    }
}
