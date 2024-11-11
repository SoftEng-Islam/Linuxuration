#!/bin/bash

# Specify the directory with videos
read -r -p "Enter the directory path containing the videos: " video_dir

# Check if the directory exists
if [ ! -d "$video_dir" ]; then
  echo "Directory does not exist. Exiting..."
  exit 1
fi

# Create an output directory for compressed videos
output_dir="$video_dir/compressed"
mkdir -p "$output_dir"

# Loop through video files and compress them
for video in "$video_dir"/*.{mp4,mkv,avi,mov,ts}; do
  # Skip if no matching files are found
  [ -e "$video" ] || continue
  
  # Get the filename without the directory
  filename=$(basename "$video")

  # Compress the video
  ffmpeg -i "$video" -vcodec libx265 -crf 30 -preset fast "$output_dir/$filename"
  # ffmpeg -i "$video" -vcodec libx264 -crf 30 -preset fast "$output_dir/$filename"

  echo "Compressed $video and saved to $output_dir/$filename"
done

echo "All videos have been compressed and saved to $output_dir."
