
#windows
#source `..\nu_scripts\custom-completions\gh\gh-completions.nu`
#source `.\config_local_gh.nu`

#linux
#source "../nu_scripts/custom-completions/gh/gh-completions.nu"
#source "./config_local_gh.nu"
source "./l.nu"

$env.config.rm.always_trash = true

$env.PROMPT_COMMAND_RIGHT = {|| ''}
$env.config.show_banner = false

$env.EDITOR = hx

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
# source "/home/dd/.config/nushell/nupm/toolkit.nu"
# set-nupm-env yank (had weird results not expanding .)

#source `./config_local_nupm.nu`


# the rest is a new nupm config local,
# here for now, the old one not used but havent
# deleted yet because might need parts later


mut xdgd_h = $env.XDG_DATA_HOME?
if ( $xdgd_h | is-empty ) { 
	print "config_local_nupm: [warn] unset XDG_DATA_HOME"
	$xdgd_h = $env.HOME + (char psep) + '.config'
	print $"config_local_nupm: [warn] setting XDG_DATA_HOME to ($xdgd_h)"
	$env.XDG_DATA_HOME =  $xdgd_h
} 

$env.NUPM_HOME = ($env.XDG_DATA_HOME | path join "nupm")
print $"config_local_nupm: [warn] setting NUPM_HOME to ($env.NUPM_HOME)"

$env.NU_LIB_DIRS = [
    ...$env.NU_LIB_DIRS
    ($env.NUPM_HOME | path join "modules")
]

$env.PATH = (
    $env.PATH
        | split row (char esep)
        | prepend ($env.NUPM_HOME | path join "scripts")
        | uniq
)
