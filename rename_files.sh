#!/bin/bash

# Script to rename files from *_form_widget.dart to *_write_form.dart
DIR="/Users/ptlam/Documents/personal/lam/projects/health_connector/examples/health_connector_toolbox/lib/src/features/write_health_record/widgets/forms"

# Find all *_form_widget.dart files and rename them
find "$DIR" -type f -name "*_form_widget.dart" | while read -r file; do
    # Get directory and filename
    dir=$(dirname "$file")
    filename=$(basename "$file")
    
    # Create new filename by replacing _form_widget.dart with _write_form.dart
    newfilename="${filename/_form_widget.dart/_write_form.dart}"
    newfile="$dir/$newfilename"
    
    echo "Renaming: $filename -> $newfilename"
    mv "$file" "$newfile"
done

echo "✅ File renaming complete!"

# Now update all import statements in Dart files
echo "Updating import statements..."

# Find all .dart files in the project and update imports
find "/Users/ptlam/Documents/personal/lam/projects/health_connector/examples/health_connector_toolbox" -type f -name "*.dart" -exec sed -i '' 's/_form_widget\.dart/_write_form.dart/g' {} \;

echo "✅ Import statements updated!"
