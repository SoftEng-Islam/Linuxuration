#!/bin/bash
# ----------------
# ffmpeg functions
# ----------------
# ffmpeg -i video.mkv subtitle.srt

# Directory where the videos are located
video_dir="/mnt/Data/11_TV-Series/Friends-S01-10"

# Loop through all video files in the directory
for video in "$video_dir"/**/*; do
  # Extract the filename without extension
  filename=$(basename "$video" | cut -d. -f1)

  # Count the number of subtitle streams
  stream_count=$(ffmpeg -i "$video" 2>&1 | grep -c "Stream.*Subtitle")

  if [ "$stream_count" -gt 0 ]; then
    # Loop through each subtitle stream
    for ((i = 0; i < stream_count; i++)); do
      output_srt="/home/softeng/Documents"
      ffmpeg -i "$video" -map 0:s:$i "$output_srt/$filename-sub$i.srt"

      if [ $? -eq 0 ]; then
        echo "Extracted subtitle stream $i for $video to $output_srt"
      else
        echo "Failed to extract subtitle stream $i for $video"
      fi
    done
  else
    echo "No subtitles found in $video"
  fi
done
