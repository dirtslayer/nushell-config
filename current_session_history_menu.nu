$env.config.history.file_format = 'sqlite'

$env.config.menus = ({
      # session menu
      name: current_session_history_menu
      only_buffer_difference: false
      marker: "# "
      type: {
        layout: list
        page_size: 10
    }
    style: {
      text: green
      selected_text: green_reverse
      description_text: yellow
    }
    source: { |buffer, position|
      history -l 
      | where session_id == (history session)
      | select command
      | where command =~ $buffer
      | each { |it| {value: $it.command } }
      | reverse
      | uniq
    }
  }
  | append $env.config.menus )

$env.config.keybindings = ({
      name: "current_session_history_menu"
      modifier: alt
      keycode: char_r
      mode: emacs
      event: { send: menu name: current_session_history_menu }
    } | append $env.config.keybindings )
