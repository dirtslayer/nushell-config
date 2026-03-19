# Show some history stats similar to how atuin does it
# this was from discord and i forgot to grab the conversation link
# 
def history-stats [
  --summary (-s): int = 10
  --last-cmds (-l): int
] {
  let top_commands = (
    history
    | if ($last_cmds != null) { last $last_cmds } else { $in }
    | get command
    | split column ' ' command
    | uniq -c
    | flatten
    | sort-by --reverse count
    | first $summary
  )

  let total_cmds = (history | length)
  let unique_cmds = (history | get command | uniq | length)

  print $"Top (ansi green)($summary)(ansi reset) most used commands:"
  let max = ($top_commands | get count | math max)
  $top_commands | each {|cmd|
    let in_ten = 10 * ($cmd.count / $max)
    print -n "["
    print -n (ansi red)
    for i in 0..<$in_ten {
      if $i == 2 {
        print -n (ansi yellow)
      } else if $i == 5 {
        print -n (ansi green)
      }
      if $i != 10 {
        print -n "▮"
      }
    }
    for x in $in_ten..<10 {
      if $x < 9 {
        print -n " "
      }
    }
    print $"(ansi reset)] (ansi xterm_grey)($cmd.count  | fill -a r -c ' ' -w 4)(ansi reset) (ansi default_bold)($cmd.command)(ansi reset)"
  }

  print $"(ansi green)Total commands:(ansi reset)   ($total_cmds)"
  print $"(ansi green)Unique commands:(ansi reset)  ($unique_cmds)"
}
