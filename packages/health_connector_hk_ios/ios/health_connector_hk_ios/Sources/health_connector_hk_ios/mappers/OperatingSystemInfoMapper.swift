import Foundation

extension OperatingSystemVersion {
    /// Converts this Foundation version to the platform-channel DTO.
    func toOperatingSystemInfoDto() -> OperatingSystemInfoDto {
        OperatingSystemInfoDto(
            majorVersion: Int64(majorVersion),
            minorVersion: Int64(minorVersion),
            patchVersion: Int64(patchVersion)
        )
    }
}
