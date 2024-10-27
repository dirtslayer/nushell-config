 def "pamac search" [ 
  term 
 ] {
  ^pamac search $term o+e>|  lines
     | each { if $in =~ '^\S' { [null, $in] } else { [$in] } }
     | flatten
     | split list null
     | each {|e|  ($e.0 | from ssv -n) 
       | upsert  desc ($e | range 1.. | str trim | to text 
       | str replace (char newline) (char space))  
     }
     | flatten
     | rename pkg ver src desc
 }

