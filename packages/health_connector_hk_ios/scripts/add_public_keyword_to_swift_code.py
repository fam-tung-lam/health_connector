#!/usr/bin/env python3
"""
Script to add 'public' keyword to Swift Pigeon generated code.

This script adds the 'public' keyword to:
- All enum declarations
- All struct declarations
- All struct 'static func ==' methods
- All struct 'func hash' methods
"""

import re
import sys
from pathlib import Path


def add_public_keyword_to_swift_code(content: str) -> str:
    """
    Add 'public' keyword to enums, structs, and their methods.

    Args:
        content: The Swift file content

    Returns:
        Modified content with public keywords added
    """
    lines = content.split('\n')
    result_lines = []

    for line in lines:
        # Add public to enum declarations
        # Match: enum SomeName: Type {
        if re.match(r'^enum \w+', line):
            line = 'public ' + line

        # Add public to struct declarations
        # Match: struct SomeName: Protocol {
        elif re.match(r'^struct \w+', line):
            line = 'public ' + line

        # Add public to static func == in structs
        # Match:   static func == (lhs: Type, rhs: Type) -> Bool {
        elif re.match(r'^\s+static func ==', line):
            line = re.sub(r'^(\s+)static func ==', r'\1public static func ==', line)

        # Add public to func hash in structs
        # Match:   func hash(into hasher: inout Hasher) {
        elif re.match(r'^\s+func hash\(into hasher:', line):
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
