# Get a yes/no response from the user via keypress, returned as a boolean value.
# The user may hit the 'y' and 'n' keys; modifier keys do not affect the results.
# If --default is set, the 'enter' key may also be used to represent either 'y' or 'n'.
# Example:
# if (confirm 'Detonate?' -d y) {print 'Boom!'}
export def confirm [
    prompt: string = '' # A prompt to display to the user
    --default(-d):string # A default response returned by the 'enter' key; one of [y n], case-insensitive
    ]: nothing -> bool {

    mut settings: record<keys: list<string>, default: bool, choice: string> = {
        keys: [y n]
        default: false
        choice: '(y/n)'
    }

    if ($default | is-empty) {
        # pass
    } else if ($default | str downcase) in [y n] {
        $settings.keys = [y n enter]
        $settings.default = ($default in [y Y])
        $settings.choice = if $settings.default {
            '(Y/n)'
        } else {
            '(y/N)'
        }
    } else {
        error make {
            msg: 'Invalid default value passed.'
            label: {
                text: 'Must be one of [y n]'
                span: (metadata $default).span
            }
        }
    }

    print --no-newline $'($prompt) ($settings.choice) '

    mut keydown: string = ''
    while $keydown not-in $settings.keys {
        $keydown = (input listen --types [key] | get code | str downcase)
    }

    let result: bool = (match $keydown {
        y => true
        n => false
        enter => $settings.default
    })

    print (if $result {'y'} else {'n'})
    $result
}
