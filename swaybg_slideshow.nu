#!/usr/bin/env nu
# print "killing swaybg"
# pkill swaybg
# sleep 30sec

let folders = [ $"($env.HOME)/Downloads/Backgrounds" ]
 # , $"($env.HOME)/Pictures/background"]

loop {
let images = ls -l ...$folders | sort-by -r created | get name | wrap name
mut result = []
for $it in $images {
  $result = ($result | append { name:$it.name jid:(job spawn { swaybg -i $it.name })}); 
  # print $result
  # print ($result | length)  
  sleep 150sec
  loop  {
    if ($result | length) < 2 {
       # print "length less"
       break;
    }
   # print "length gt 1"
    let pop = $result | first
   # print "pop: "
   # print $pop  
     job kill $pop.jid
     $result = $result | skip 1
   # print "after skip 1"
   # print $result
 } 
}  
}
