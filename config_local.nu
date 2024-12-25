
#windows
#source `..\nu_scripts\custom-completions\gh\gh-completions.nu`
#source `.\config_local_gh.nu`

#linux
#source "../nu_scripts/custom-completions/gh/gh-completions.nu"
#source "./config_local_gh.nu"
source "./l.nu"



$env.config.rm.always_trash = true
$env.PROMPT_MULTILINE_INDICATOR = {|| " " }

#use "/home/dd/git/nu_scripts/modules/prompt/basic-git.nu" basic-git-left-prompt


$env.PROMPT_COMMAND_RIGHT = {|| ''}

$env.config.show_banner = false

$env.EDITOR = 'hx'

# may have to edit this in ~/.config/nushell/config.nu
# reasons: many
$env.config.history.file_format = 'sqlite'

# disabled to get normal menu back but still need crl-j
# source `./config_local_keybinding.nu`
# add control j to insert new line
$env.config.keybindings = ({
name : insert_line
modifier : control
keycode : char_j
mode : [emacs, vi_insert, vi_normal]
event: {edit: InsertNewline}
} | append $env.config.keybindings)

# moving to windows had to disable nupm stuff
# for now, linux has $env.HOME
# whereas windows has $env.HOMEDRIVE and $env.HOMEPATH instead

#source `./config_local_nupm.nu`
source `./config_local_pamac.nu`

$env.config.hooks.env_change = {
            PWD: [ # run if the PWD environment is different since the last repl input
                  {
        condition: {|_, after| not ($after | path join 'toolkit.nu' | path exists)}
        code: "hide toolkit"
      },
      {
        condition: {|_, after| $after | path join 'toolkit.nu' | path exists}
        code: "
        print $'(ansi default_underline)(ansi default_bold)toolkit(ansi reset) module (ansi green_italic)detected(ansi reset)...'
        print $'(ansi yellow_italic)activating(ansi reset) (ansi default_underline)(ansi default_bold)toolkit(ansi reset) module with `(ansi default_dimmed)(ansi default_italic)use toolkit.nu(ansi reset)`'
        use toolkit.nu
        "
      },{
        condition: { true } 
        code: 'print $"(l)"'
    }
        ]
        
        display_output: ["if (term size).columns >= 100 { table -e } else { table }"] # run to display the output of a pipeline
        command_not_found: [{ null }] # return an error message when a command is not found
    }
