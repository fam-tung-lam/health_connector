#!/usr/bin/env python3
"""
Script to rename 'mappers' to 'mapper' in all Dart files
within packages/health_connector_hk_ios/lib/src/mappers and its subfolders.
"""

import os
from pathlib import Path


def replace_in_file(file_path: Path, old_text: str, new_text: str) -> tuple[bool, int]:
    """
    Replace text in a file.
    
    Args:
        file_path: Path to the file
        old_text: Text to replace
        new_text: Replacement text
        
    Returns:
        Tuple of (was_modified, replacement_count)
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        modified_content = content.replace(old_text, new_text)

        if content != modified_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(modified_content)

            # Count occurrences
            count = content.count(old_text)
            return True, count

        return False, 0
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return False, 0


def main():
    import sys

    # Base directory - accept from command line or use default
    if len(sys.argv) > 1:
        base_dir = Path(sys.argv[1])
        if not base_dir.is_absolute():
            base_dir = Path(__file__).parent / base_dir
    else:
        base_dir = Path(__file__).parent / "packages/health_connector_hk_ios/lib/src/mappers"

    if not base_dir.exists():
        print(f"Error: Directory not found: {base_dir}")
        return

    print(f"Scanning directory: {base_dir}")
    print(f"Replacing 'mappers' with 'mapper' in all .dart files...\n")

    total_files = 0
    modified_files = 0
    total_replacements = 0

    # Find all .dart files recursively
    for dart_file in base_dir.rglob("*.dart"):
        total_files += 1
        was_modified, count = replace_in_file(dart_file, "mappers", "mapper")

        if was_modified:
            modified_files += 1
            total_replacements += count
            print(
                f"✓ Modified: {dart_file.relative_to(base_dir.parent.parent.parent)} ({count} replacements)")

    print(f"\n{'=' * 60}")
    print(f"Summary:")
    print(f"  Total files scanned: {total_files}")
    print(f"  Files modified: {modified_files}")
    print(f"  Total replacements: {total_replacements}")
    print(f"{'=' * 60}")


if __name__ == "__main__":
    main()
