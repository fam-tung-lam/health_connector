#!/bin/bash

# Script to rename _form_widget to _write_form in all Dart files
# Directory to process
DIR="/Users/ptlam/Documents/personal/lam/projects/health_connector/examples/health_connector_toolbox/lib/src/features/write_health_record/widgets/forms"

# Find all .dart files and process them
find "$DIR" -type f -name "*.dart" | while read -r file; do
    echo "Processing: $file"
    # Use sed to replace _form_widget with _write_form
    # On macOS, sed requires -i '' for in-place editing
    sed -i '' 's/_form_widget/_write_form/g' "$file"
done

echo "✅ Renaming complete!"
