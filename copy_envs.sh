#!/bin/bash

# Set output directory in the directory where the script is run from
output_dir="$(pwd)/env_files_export"

find "$1" -type d | while read -r dir; do
    if [ -d "$dir/.git" ]; then
        dirname="$(basename "$dir")"
        parentname="$(basename "$(dirname "$dir")")"
        # Find .env files (excluding .env.example)
        find "$dir" -maxdepth 2 -type f -name ".env*" ! -name ".env.example" | while read -r envfile; do
            envbase="$(basename "$envfile")"
            # Only process .env or .env.* (excluding .env.example)
            if [[ "$envbase" == ".env" ]] || [[ "$envbase" == .env.* ]]; then
                # Compose new filename: {original_env_filename}.{directory}
                new_envbase="$envbase.$dirname"
                # Compose output path: ./env_files_export/{parent}/
                target_dir="$output_dir/$parentname"
                mkdir -p "$target_dir"
                echo "Copying '$envfile' to '$target_dir/$new_envbase'"
                if cp "$envfile" "$target_dir/$new_envbase"; then
                    echo "Copied $envfile to $target_dir/$new_envbase"
                else
                    echo "Failed to copy $envfile to $target_dir/$new_envbase" >&2
                fi
            fi
        done
    fi
done
