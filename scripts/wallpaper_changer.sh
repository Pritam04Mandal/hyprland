#!/bin/bash

# Define the directory containing your wallpapers
WALLPAPER_DIR="/home/pritam/Pictures/wallpaper/"

# Function to change wallpaper
change_wallpaper() {
	# Get the list of wallpapers in the directory
	WALLPAPERS=("$WALLPAPER_DIR"wallpaper*.jpg)

	# Check if there are any wallpapers
	if [ ${#WALLPAPERS[@]} -eq 0 ]; then
		echo "No wallpapers found in directory: $WALLPAPER_DIR"
		exit 1
	fi

	# Randomly select a wallpaper
	RANDOM_WALLPAPER="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"

	# Set the wallpaper using SwaBG
	swaybg -i "$RANDOM_WALLPAPER" -m fill

	# Check if setting the wallpaper was successful
	if [ $? -eq 0 ]; then
		echo "Wallpaper changed successfully."
	else
		echo "Failed to change wallpaper."
		return 1
	fi
}

# Attempt to change wallpaper with retries
retry_count=3
success=false
for ((i = 0; i < retry_count; i++)); do
	if change_wallpaper; then
		success=true
		break
	else
		echo "Retrying..."
		sleep 1
	fi
done

# If all retries fail, exit with an error
if ! $success; then
	echo "Failed to change wallpaper after $retry_count attempts."
	exit 1
fi
