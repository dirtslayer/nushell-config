# keybindings grid
def kbg [] {
  $env.config.keybindings 
    | sort-by modifier 
    | upsert name {|r| $"($r.modifier) ($r.keycode) ($r.name)"}
    | grid
} 

# remove existing keybindings for tab and control n
$env.config.keybindings = ( $env.config.keybindings 
  | where name != 'completion_menu'
  | where name != 'ide_completion_menu'
  | where name != 'undo_or_previous_page_menu'
  | where name != 'undo_change' ) # control z

# add control j to insert new line
$env.config.keybindings = ({
name : insert_line
modifier : control
keycode : char_j
mode : [emacs, vi_insert, vi_normal]
event: {edit: InsertNewline}
} | append $env.config.keybindings)

# add ide_completion_menu for tab key
$env.config.keybindings = ({
name : tab_ide_completion_menu
modifier : none
keycode : tab
mode : [emacs, vi_insert, vi_normal]
event: {
                until: [
                    { send: menu name: ide_completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
} | append $env.config.keybindings)

