# place a grid on the screen and move * around grid with arrows
# 

let width = 40
let height = 20
# place cursor on the terminal top left is 1,1
def 'ansi moveto' [ row: int = 1 , col : int = 1 ] {
  $"\e[($row);($col)H"
}

def main [] {
  mut x = 0
  mut y = 0
  mut outb = ''
    print $"(ansi cls)"
  loop {
    $outb = (char newline)
    $x = ([([$x $width] | math min) 0] | math max)
    $y = ([([$y $height] | math min) 0] | math max)
    for i in 0..$height {
      for j in 0..$width {
        if $j == $x and $i == $y {
          # print -n "*"
          $outb = ([ $outb, "*" ] | str join)  
        } else {
          # print -n "."
          $outb = ([$outb, "."] | str join)
        }
      }
      # print ""
      $outb = ([$outb, ( char newline)] | str join)
    }
    print $"(ansi moveto)(ansi cursor_off)($outb)"
    let inp = (input listen --types [ key ] --raw)
    match $inp {
      {type: key code: enter} => (ansi cursor_on; break)
      {type: key code: up} => ($y = $y - 1)
      {type: key code: down} => ($y = $y + 1)
      {type: key code: left} => ($x = $x - 1)
      {type: key code: right} => ($x = $x + 1)
      _ => ()
    }
  }
}
