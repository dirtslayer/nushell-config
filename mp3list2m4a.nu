
# all songs in the m3u (just a song list no m3u header)
# no spaces | separated with last | removed
let flist = ( open `songs.m3u` | lines | each { $"($in)|" } | str join | str substring 0..-2  )

# prepend build -i param for ffmpeg
let param = $"concat:($flist)"

# use ffmpeg to join mp3s into one m4a
ffmpeg -i $param -c:a aac -vn "artist - album.m4a"



# kid3-cli notes
