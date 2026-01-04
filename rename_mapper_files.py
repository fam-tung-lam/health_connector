#!/usr/bin/env python3
"""
Script to rename files from *_mappers.dart to *_mapper.dart
and update all import/export statements that reference them.
"""

import os
import re
from pathlib import Path


def find_files_to_rename(base_dir: Path) -> list[tuple[Path, Path]]:
    """
    Find all files ending with _mappers.dart and their new names.
    
    Returns:
        List of tuples (old_path, new_path)
    """
    renames = []

    for dart_file in base_dir.rglob("*_mappers.dart"):
        new_name = dart_file.name.replace("_mappers.dart", "_mapper.dart")
        new_path = dart_file.parent / new_name
        renames.append((dart_file, new_path))

    return renames


def update_imports_in_file(file_path: Path, old_filename: str, new_filename: str) -> int:
    """
    Update import/export statements in a file.
    
    Returns:
        Number of replacements made
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Replace in import and export statements
        # Match: import '...' or export '...' containing the old filename
        old_pattern = old_filename.replace("_mappers.dart", "_mappers")
        new_pattern = new_filename.replace("_mapper.dart", "_mapper")

        modified_content = content.replace(old_pattern, new_pattern)

        if content != modified_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(modified_content)

            count = content.count(old_pattern)
            return count

        return 0
    except Exception as e:
        print(f"Error updating imports in {file_path}: {e}")
        return 0


def main():
    import sys

    # Base directory - accept from command line or use default
    if len(sys.argv) > 1:
        base_dir = Path(sys.argv[1])
        if not base_dir.is_absolute():
            base_dir = Path(__file__).parent / base_dir
    else:
        print("Usage: python3 rename_mapper_files.py <directory>")
        return

    if not base_dir.exists():
        print(f"Error: Directory not found: {base_dir}")
        return

    print(f"Scanning directory: {base_dir}")
    print(f"Finding files to rename (*_mappers.dart -> *_mapper.dart)...\n")

    # Find all files to rename
    renames = find_files_to_rename(base_dir)

    if not renames:
        print("No files found matching pattern *_mappers.dart")
        return

    # Get all dart files that might contain imports
    project_root = base_dir
    while project_root.parent != project_root:
        if (project_root / "pubspec.yaml").exists():
            break
        project_root = project_root.parent

    all_dart_files = list(project_root.rglob("*.dart"))

    print(f"Found {len(renames)} files to rename")
    print(f"Scanning {len(all_dart_files)} Dart files for import updates...\n")

    # Rename files and track changes
    renamed_count = 0
    import_updates = 0

    for old_path, new_path in renames:
        # Update imports in all dart files
        old_filename = old_path.name
        new_filename = new_path.name

        for dart_file in all_dart_files:
            count = update_imports_in_file(dart_file, old_filename, new_filename)
            if count > 0:
                import_updates += count

        # Rename the file
        try:
            old_path.rename(new_path)
            renamed_count += 1
            print(f"✓ Renamed: {old_path.relative_to(base_dir)} -> {new_filename}")
        except Exception as e:
            print(f"✗ Error renaming {old_path}: {e}")

    print(f"\n{'=' * 60}")
    print(f"Summary:")
    print(f"  Files renamed: {renamed_count}")
    print(f"  Import/export statements updated: {import_updates}")
    print(f"{'=' * 60}")


if __name__ == "__main__":
    main()
