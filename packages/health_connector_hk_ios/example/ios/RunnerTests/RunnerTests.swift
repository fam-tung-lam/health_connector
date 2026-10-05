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

    func testOffsetsUseHistoricalWinterAndSummerTime() throws {
        // Given
        let cases: [(dates: (start: String, end: String), offset: Int64)] = [
            (("2026-01-15T22:30:00Z", "2026-01-15T22:35:00Z"), 3600),
            (("2026-07-15T22:30:00Z", "2026-07-15T22:35:00Z"), 7200),
        ]

        for testCase in cases {
            let sample = try makeHydrationSample(
                start: testCase.dates.start,
                end: testCase.dates.end,
                metadata: [HKMetadataKeyTimeZone: "Europe/Berlin"]
            )

            // When
            let startOffset = StartTimeZoneOffsetKey.read(from: sample.metadata, at: sample.startDate)
            let endOffset = EndTimeZoneOffsetKey.read(from: sample.metadata, at: sample.endDate)

            // Then
            XCTAssertEqual(startOffset, testCase.offset)
            XCTAssertEqual(endOffset, testCase.offset)
        }
    }

    func testOffsetsFollowDaylightSavingTransitions() throws {
        // Given
        let cases: [(dates: (start: String, end: String), offsets: (start: Int64, end: Int64))] = [
            (("2026-03-29T00:30:00Z", "2026-03-29T01:30:00Z"), (3600, 7200)),
            (("2026-10-25T00:30:00Z", "2026-10-25T01:30:00Z"), (7200, 3600)),
        ]

        for testCase in cases {
            let sample = try makeHydrationSample(
                start: testCase.dates.start,
                end: testCase.dates.end,
                metadata: [HKMetadataKeyTimeZone: "Europe/Berlin"]
            )

            // When
            let startOffset = StartTimeZoneOffsetKey.read(from: sample.metadata, at: sample.startDate)
            let endOffset = EndTimeZoneOffsetKey.read(from: sample.metadata, at: sample.endDate)

            // Then
            XCTAssertEqual(startOffset, testCase.offsets.start)
            XCTAssertEqual(endOffset, testCase.offsets.end)
        }
    }

    func testExplicitOffsetsOverrideTheNativeTimeZone() throws {
        // Given
        let sample = try makeHydrationSample(
            start: "2026-03-29T00:30:00Z",
            end: "2026-03-29T01:30:00Z",
            metadata: [
                HKMetadataKeyTimeZone: "Europe/Berlin",
                StartTimeZoneOffsetKey.fullKey: NSNumber(value: -18000),
                EndTimeZoneOffsetKey.fullKey: NSNumber(value: -14400),
            ]
        )

        // When
        let startOffset = StartTimeZoneOffsetKey.read(from: sample.metadata, at: sample.startDate)
        let endOffset = EndTimeZoneOffsetKey.read(from: sample.metadata, at: sample.endDate)

        // Then
        XCTAssertEqual(startOffset, -18000)
        XCTAssertEqual(endOffset, -14400)
    }

    func testUnavailableOffsetsRemainUnknown() throws {
        // Given
        let sample = try makeHydrationSample(
            start: "2026-01-15T22:30:00Z",
            end: "2026-01-15T22:35:00Z",
            metadata: nil
        )

        // When
        let startOffset = StartTimeZoneOffsetKey.read(from: sample.metadata, at: sample.startDate)
        let endOffset = EndTimeZoneOffsetKey.read(from: sample.metadata, at: sample.endDate)

        // Then
        XCTAssertNil(startOffset)
        XCTAssertNil(endOffset)
    }

    func testInvalidTimeZoneLeavesOffsetsUnknown() {
        // Given
        let metadata: [String: Any] = [HKMetadataKeyTimeZone: "Invalid/TimeZone"]

        // When
        let startOffset = StartTimeZoneOffsetKey.read(from: metadata, at: Date(timeIntervalSince1970: 0))
        let endOffset = EndTimeZoneOffsetKey.read(from: metadata, at: Date(timeIntervalSince1970: 0))

        // Then
        XCTAssertNil(startOffset)
        XCTAssertNil(endOffset)
    }

    private func makeHydrationSample(
        start: String,
        end: String,
        metadata: [String: Any]?
    ) throws -> HKQuantitySample {
        let type = try XCTUnwrap(HKObjectType.quantityType(forIdentifier: .dietaryWater))
        let formatter = ISO8601DateFormatter()

        return try HKQuantitySample(
            type: type,
            quantity: HKQuantity(unit: .liter(), doubleValue: 0.25),
            start: XCTUnwrap(formatter.date(from: start)),
            end: XCTUnwrap(formatter.date(from: end)),
            metadata: metadata
        )
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
