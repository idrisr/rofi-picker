folder="$1"
selected_filename=$(\
        find "$folder" -type f  \( -name "*.pdf" -o -name "*.epub" \) -print0 \
        | xargs -0 -n 1 basename \
        | sort  \
    | rofi -dmenu -p "${1##*/}")

selected_path="$folder/$selected_filename"

if [ -n "$selected_filename" ] && [ -f "$selected_path" ]; then
    zathura "$selected_path" &
fi
