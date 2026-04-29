#!/usr/bin/env nu

# completion for l
#def "nu-complete l" [] {
#    [[value description]; [boo scarry] [yikes alert]]
#}

# ls grid that shows git status modified with a red * 
def "l" [
#  command?: string@"nu-complete l"
  --help
] {
  let gs = ^git status | complete
  let isgitrepo = $gs.exit_code == 0
  if $isgitrepo { 
    let modified = (
      $gs.stdout | lines 
      | parse "{x}modified:{modified}"
      | reject x
      | str trim
      | get modified
    )
   ls -a 
    | upsert m {|f| if $f.name in $modified {$"(ansi red)*(ansi reset)"}}
    | rename --column {name: fname}
    | upsert name {|f| $"($f.fname)($f.m)"}
    | grid -c
  } else {
    print 
    ls -a | grid -c
  }
}

# gist list grid
def gl [] {
  gh gist list | get description | grid
}

# list gist grid
def lg [] {
  gl
}

# list repos grid
def lr [] {
  gh repo list | get name | grid
}

# repos list grid
def rl [] {
  lr
}

# keybindings grid
def kbg [] {
  $env.config.keybindings 
    | sort-by modifier 
    | upsert name {|r| $"($r.modifier) ($r.keycode) ($r.name)"}
    | grid
} 

def main [] {
  l
}
