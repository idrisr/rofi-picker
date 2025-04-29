folder="$1"
declare -a basenames

while IFS= read -r -d $'\0' fullpath; do
    basenames+=("${fullpath##*/}")
done < <(find "$folder" -type f \( -name "*.pdf" -o -name "*.epub" \) -print0)

if [[ ${#basenames[@]} -gt 0 ]]; then
    sorted_basenames=$(printf "%s\n" "${basenames[@]}" | sort)
    selected_filename=$(echo "$sorted_basenames" | rofi -dmenu -p "${1##*/}")

    selected_path="$folder/$selected_filename"

    if [ -n "$selected_filename" ] && [ -f "$selected_path" ]; then
        zathura "$selected_path" &
    fi
fi
