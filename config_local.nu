
#windows
#source `..\nu_scripts\custom-completions\gh\gh-completions.nu`
#source `.\config_local_gh.nu`

#linux
#source "../nu_scripts/custom-completions/gh/gh-completions.nu"
#source "./config_local_gh.nu"
source "./l.nu"

$env.config.rm.always_trash = true
$env.PROMPT_MULTILINE_INDICATOR = {|| " " }
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

