use std
std ellie
std path add ($env.HOME)/.cargo/bin
std path add ($env.HOME)/.local/bin
std path add ($env.HOME)/.opencode/bin
source `./l.nu`
$env.config.rm.always_trash = true
$env.PROMPT_MULTILINE_INDICATOR = {|| " " }
$env.PROMPT_COMMAND_RIGHT = {|| ''}
$env.PROMPT_COMMAND = {|| [ (whoami) " " (hostname) ]  | str join }
$env.PROMPT_INDICATOR = " 🥔 "
$env.config.show_banner = false
$env.EDITOR = 'hx'
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


$env.config.hooks.env_change = {
  PWD: [ # PWD is different
  {
    condition: { true } 
    code: {  /home/dd/pub/nushell-config/l.nu }
  },
  ]
        
  # display_output: ["if (term size).columns >= 100 { table -e } else { table }"] # run to display the output of a pipeline
  # command_not_found: [{ null }] # return an error message when a command is not found
}

source ./config_local_mise.nu

const NU_PLUGIN_DIRS = [
  ($nu.current-exe | path dirname)
  ...$NU_PLUGIN_DIRS
]
