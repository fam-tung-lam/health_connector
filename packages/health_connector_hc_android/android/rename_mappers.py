import os

def rename_mappers():
    # Define the target directory relative to this script
    target_dir = os.path.join(os.path.dirname(__file__), 'src/main/kotlin/com/phamtunglam/health_connector_hc_android/mappers/health_record_mappers')
    
    # Check if directory exists
    if not os.path.exists(target_dir):
        print(f"Directory not found: {target_dir}")
        return

    print(f"Scanning directory: {target_dir}")
    
    count = 0
    for filename in os.listdir(target_dir):
        if filename.endswith("Mappers.kt"):
            # Construct the new filename
            new_filename = filename[:-10] + "Mapper.kt" # Remove 'Mappers.kt' and add 'Mapper.kt'
            
            old_path = os.path.join(target_dir, filename)
            new_path = os.path.join(target_dir, new_filename)
            
            print(f"Renaming: {filename} -> {new_filename}")
            os.rename(old_path, new_path)
            count += 1
            
    print(f"Finished. Renamed {count} files.")

if __name__ == "__main__":
    rename_mappers()
