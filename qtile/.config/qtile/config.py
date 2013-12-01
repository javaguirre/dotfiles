import time

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget

mod = "mod1"

keys = [
    # Switch between windows in current stack pane
    Key(
        [mod], "k",
        lazy.layout.down()
    ),
    Key(
        [mod], "j",
        lazy.layout.up()
    ),

    # Move windows up or down in current stack
    Key(
        [mod, "control"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [mod, "control"], "j",
        lazy.layout.shuffle_up()
    ),

    # Switch window focus to other pane(s) of stack
    Key(
        [mod], "space",
        lazy.layout.next()
    ),

    # Swap panes of split stack
    Key(
        [mod, "shift"], "space",
        lazy.layout.rotate()
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"], "Return",
        lazy.layout.toggle_split()
    ),
    Key([mod, "shift"], "Return", lazy.spawn("st")),
    Key([mod, "shift"], "b", lazy.spawn("firefox-nightly")),
    Key([mod, "shift"], "t", lazy.spawn("st-light")),
    Key([mod, "shift"], "p", lazy.spawn("pavucontrol")),
    Key([mod, "control"], "l", lazy.spawn("slock")),
    Key([mod, "control"], "s", lazy.spawn("import -window root -delay 200 /home/javaguirre/screenshot%.f.png" % time.time())),

    # Toggle between different layouts as defined below
    Key([mod], "t", lazy.nextlayout()),
    Key([mod, "shift"], "c", lazy.window.kill()),

    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod], "p", lazy.spawncmd()),
    Key([mod, "shift"], "q", lazy.shutdown())
]

groups = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    Group("8"),
    Group("9")
]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

dgroups_key_binder = None
dgroups_app_rules = []

layouts = [
    layout.Max(),
    layout.Stack(stacks=2)
]

font_options = {'font': 'Hermit', 'fontsize': 13, 'background': '660000'}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(this_current_screen_border='ffffff', font='Hermit', fontsize=8),
                widget.Prompt(**font_options),
                widget.WindowName(**font_options),
                widget.TextBox("", name="default", **font_options),
                widget.Battery(**font_options),
                widget.Sep(foreground='ffffff', **font_options),
                widget.ThermalSensor(**font_options),
                widget.Sep(foreground='ffffff', **font_options),
                widget.Volume(**font_options),
                widget.Sep(foreground='ffffff', **font_options),
                widget.Systray(),
                widget.Clock('%H:%M %a, %d-%m-%Y', **font_options),
            ],
            20,
        ),
    ),
]

main = None
follow_mouse_focus = True
cursor_warp = False
floating_layout = layout.Floating()
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]
auto_fullscreen = True
widget_defaults = {}
