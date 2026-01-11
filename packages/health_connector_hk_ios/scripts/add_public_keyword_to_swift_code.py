#!/usr/bin/env python3
"""
Script to add 'public' keyword to Swift Pigeon generated code.

This script fixes Swift visibility errors by adding the 'public' keyword to:
- All DTO enum declarations (e.g., enum SomeDto:)
- All DTO struct declarations (e.g., struct SomeDto:)
- HealthConnectorErrorDto error class
- Base protocol declarations (MeasurementUnitDto, HealthRecordDto, DeleteRecordsRequestDto)
- Hashable/Equatable protocol conformance methods (static func ==, func hash)

This is necessary because Pigeon generates public protocols (like HealthConnectorHKIOSApi)
that reference these types, but doesn't generate them with public visibility. Swift requires
all types used in public protocol signatures to also be public.
"""

import re
import sys
from pathlib import Path


def add_public_keyword_to_swift_code(content: str) -> str:
    """
    Add 'public' keyword to enums, structs, protocols, and their methods.

    Args:
        content: The Swift file content

    Returns:
        Modified content with public keywords added
    """
    lines = content.split('\n')
    result_lines = []

    for line in lines:
        # Add public to DTO enum declarations
        # Match: enum SomeDto: Int {
        if re.match(r'^enum \w+Dto:', line):
            line = 'public ' + line

        # Add public to DTO struct declarations
        # Match: struct SomeDto: Hashable {
        elif re.match(r'^struct \w+Dto:', line):
            line = 'public ' + line

        # Add public to HealthConnectorErrorDto error class
        # Match: final class HealthConnectorErrorDto: Error {
        elif re.match(r'^final class HealthConnectorErrorDto:', line):
            line = 'public ' + line

        # Add public to sealed base protocol declarations
        # Match: protocol MeasurementUnitDto {, protocol HealthRecordDto {, protocol DeleteRecordsRequestDto {
        elif re.match(r'^protocol (MeasurementUnitDto|HealthRecordDto|DeleteRecordsRequestDto) \{', line):
            line = 'public ' + line

        # Add public to static func == in structs (Equatable conformance)
        # Match:   static func == (lhs: Type, rhs: Type) -> Bool {
        elif re.match(r'^\s+static func ==', line):
            line = re.sub(r'^(\s+)static func ==', r'\1public static func ==', line)

        # Add public to func hash in structs (Hashable conformance)
        # Match:   func hash(into hasher: inout Hasher) {
        elif re.match(r'^\s+func hash\(into', line):
            line = re.sub(r'^(\s+)func hash\(', r'\1public func hash(', line)

        result_lines.append(line)

    return '\n'.join(result_lines)


def main():
    """Main function to process the Swift Pigeon file."""
    if len(sys.argv) != 2:
        print("Usage: python3 add_public_to_swift_pigeon.py <path_to_swift_file>")
        print("Example: python3 add_public_to_swift_pigeon.py ios/health_connector/Sources/health_connector/data/pigeon/HealthConnectorHKIOSApi.g.swift")
        sys.exit(1)

    file_path = Path(sys.argv[1])

    if not file_path.exists():
        print(f"Error: File not found: {file_path}")
        sys.exit(1)

    if not file_path.suffix == '.swift':
        print(f"Error: File must be a .swift file: {file_path}")
        sys.exit(1)

    print(f"Processing: {file_path}")

    # Read the file
    content = file_path.read_text(encoding='utf-8')

    # Add public keywords
    modified_content = add_public_keyword_to_swift_code(content)

    # Write back to file
    file_path.write_text(modified_content, encoding='utf-8')

    print(f"✓ Successfully added 'public' keywords to {file_path}")


if __name__ == '__main__':
    main()
