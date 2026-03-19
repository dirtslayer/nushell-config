# Darrell's Nushell Configs

## Updated Nushell version 0.111.0, March 2026

- If you haven't explored Nushell, you can learn more at Nushell.sh.

> [!WARNING]
> not a great idea to run code from the internet without reading it first


```
     __  ,
 .--()°'.'
'|, . ,'
 !_-(_\

```

- Supports copying with minimal prompt, no right prompt, no line prefix on
  newline
- Supports multi-line edits with ctrl-j to add new line, ctrl-o remains as edit
  with editor
- Displays directory listings on enter with l, which is defined in l.nu
- Directory listings show git modified files with a red star
- Doesn't display the directory name because I just typed it in the cd command 
- Some of the code in SAMPLE is stuff I've swiped from the Nushell discord
- My install script pulls the latest release from Github x86.
- Small scripts that are useful on Wayland (screenshot and swaybg_slideshow)
- Reminder scripts that are easy to forget like soft-reboot and mp3list2m4a

## Howto use 

- ensure $env.EDITOR is set and open config

```
$env.EDITOR = "hx"
config nu
```

add:

```
source config_local.nu

```
> [!CAUTION]
> Probably better to just make your own configs, but, I will leave mine here to
> show what I like. I think the thing you use the most is the thing you will
> want the most control over, which is cd and ls. So, have a look at my l.nu

> [!NOTE]
> $env is where all your settings end up. Let the defaults weight heavily, I've
> only changed what I need to change, like prompts and 1 keybind.
 
Check out some more Nushell code in my Dicter repository, it has a testing
framework called nu-unit-test!
