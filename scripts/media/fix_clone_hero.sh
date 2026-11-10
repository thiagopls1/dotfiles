for i in *.mp4; do
    [ -e "$i" ] || continue

    if ffmpeg -i "$i" \
        -c:v libvpx -crf 10 -b:v 40M \
        -c:a libvorbis \
        "${i%.mp4}.webm"; then
        rm -- "$i"
    else
        echo "Falha ao converter: $i" >&2
    fi
done
