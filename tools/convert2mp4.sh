file=$1
filename="${1%.*}"

echo "Converting $file to MP4 format..."

ffmpeg -i $file "$filename.mp4"
