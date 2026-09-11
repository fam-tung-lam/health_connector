import Foundation
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
}
