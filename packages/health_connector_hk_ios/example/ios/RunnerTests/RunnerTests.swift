import Foundation
import HealthKit
@testable import health_connector_hk_ios
import XCTest

final class RunnerTests: XCTestCase {
    func testOperatingSystemVersionMapsEveryComponent() {
        // Given
        let version = OperatingSystemVersion(
            majorVersion: 17,
            minorVersion: 4,
            patchVersion: 1
        )

        // When
        let dto = version.toOperatingSystemInfoDto()

        // Then
        XCTAssertEqual(dto.majorVersion, 17)
        XCTAssertEqual(dto.minorVersion, 4)
        XCTAssertEqual(dto.patchVersion, 1)
    }

    func testAppleStandHourStatusMapperMapsStoodStatus() throws {
        let status = try AppleStandHourStatusDto(
            standHourValue: HKCategoryValueAppleStandHour.stood.rawValue
        )

        XCTAssertEqual(status, .stood)
    }

    func testAppleStandHourStatusMapperMapsIdleStatus() throws {
        let status = try AppleStandHourStatusDto(
            standHourValue: HKCategoryValueAppleStandHour.idle.rawValue
        )

        XCTAssertEqual(status, .idle)
    }

    func testAppleStandHourStatusMapperRejectsUnknownStatusWithoutExposingValue() {
        XCTAssertThrowsError(try AppleStandHourStatusDto(standHourValue: Int.max)) { error in
            guard case let HealthConnectorError.invalidArgument(message, _, context) = error else {
                return XCTFail("Expected invalidArgument, got \(error)")
            }

            XCTAssertEqual(message, "Invalid Apple Stand Hour category value")
            XCTAssertEqual(context?["data_type"] as? String, "appleStandHour")
            XCTAssertNil(context?["value"])
        }
    }

    func testAppleStandHourMapperRejectsWrongCategoryWithoutExposingIdentifier() throws {
        let sleepType = try XCTUnwrap(HKObjectType.categoryType(forIdentifier: .sleepAnalysis))
        let sample = HKCategorySample(
            type: sleepType,
            value: HKCategoryValueSleepAnalysis.inBed.rawValue,
            start: Date(timeIntervalSince1970: 0),
            end: Date(timeIntervalSince1970: 3600)
        )

        XCTAssertThrowsError(try sample.toAppleStandHourRecordDto()) { error in
            guard case let HealthConnectorError.invalidArgument(message, _, context) = error else {
                return XCTFail("Expected invalidArgument, got \(error)")
            }

            XCTAssertEqual(message, "Expected Apple Stand Hour category type")
            XCTAssertEqual(context?["data_type"] as? String, "appleStandHour")
            XCTAssertNil(context?["actual"])
        }
    }

    func testAppleStandHourAggregationCountsOnlyStoodSamples() throws {
        let samples = try [
            makeAppleStandHourSample(value: HKCategoryValueAppleStandHour.stood.rawValue),
            makeAppleStandHourSample(value: HKCategoryValueAppleStandHour.idle.rawValue),
            makeAppleStandHourSample(value: HKCategoryValueAppleStandHour.stood.rawValue),
        ]

        XCTAssertEqual(AppleStandHourHandler.countStoodHours(in: samples), 2.0)
    }

    private func makeAppleStandHourSample(value: Int) throws -> HKCategorySample {
        let type = try XCTUnwrap(HKObjectType.categoryType(forIdentifier: .appleStandHour))

        return HKCategorySample(
            type: type,
            value: value,
            start: Date(timeIntervalSince1970: 0),
            end: Date(timeIntervalSince1970: 3600)
        )
    }
}
