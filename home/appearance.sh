#!/usr/bin/env bash

export LS_COLORS='di=1;35:ex=01;33'

s="$HOME"/.config/appearance/background
if [ ! -f "$s" ]; then
    mkdir -p "$HOME"/.config/appearance
    echo light > "$s"
fi

export SYSTEM_COLOR_THEME="$(cat "$s")"
export TTY_FONT_SIZE="10"
export TTY_FONT_FAMILY="JetBrainsMono Nerd Font Mono"
export ALACRITTY_WINDOW_DECORATION="None"
if [ "$(uname)" = "Darwin" ]; then
    export TTY_FONT_SIZE="13"
    export ALACRITTY_WINDOW_DECORATION="Buttonless"
fi

# Colors are taken from https://github.com/catppuccin/nvim.
#
# Terminal variant does not come with bright colors pallet. The dark theme variant uses 10%
# saturation less of a normal variant, where the light version uses 10% more respectively.
#
# Mocha Theme (dark variant).
export TTY_COLOR_BG0_DARK="#1e1e2e"
export TTY_COLOR_BG1_DARK="#313244"
export TTY_COLOR_BG2_DARK="#45475a"
export TTY_COLOR_FG0_DARK="#cdd6f4"
export TTY_COLOR_FG1_DARK="#a6adc8"
export TTY_COLOR_BLACK_DARK="#6c7086"
export TTY_COLOR_RED_DARK="#f38ba8"
export TTY_COLOR_GREEN_DARK="#a6e3a1"
export TTY_COLOR_YELLOW_DARK="#f9e2af"
export TTY_COLOR_BLUE_DARK="#89b4fa"
export TTY_COLOR_MAGENTA_DARK="#f5c2e7"
export TTY_COLOR_CYAN_DARK="#89dceb"
export TTY_COLOR_WHITE_DARK="#bac2de"
export TTY_COLOR_BRIGHT_BLACK_DARK="#78787a"
export TTY_COLOR_BRIGHT_RED_DARK="#ec92a8"
export TTY_COLOR_BRIGHT_GREEN_DARK="#addba9"
export TTY_COLOR_BRIGHT_YELLOW_DARK="#f4e2b4"
export TTY_COLOR_BRIGHT_BLUE_DARK="#8fb4f4"
export TTY_COLOR_BRIGHT_MAGENTA_DARK="#f1c6e7"
export TTY_COLOR_BRIGHT_CYAN_DARK="#90d7e4"
export TTY_COLOR_BRIGHT_WHITE_DARK="#bfc4d9"
export TTY_INACTIVE_PANE_BRIGHTNESS_DARK="0.8"
# Latte Theme (light variant).
export TTY_COLOR_BG0_LIGHT="#eff1f5"
export TTY_COLOR_BG1_LIGHT="#ccd0da"
export TTY_COLOR_BG2_LIGHT="#bcc0cc"
export TTY_COLOR_FG0_LIGHT="#4c4f69"
export TTY_COLOR_FG1_LIGHT="#6c6f85"
export TTY_COLOR_BLACK_LIGHT="#9ca0b0"
export TTY_COLOR_RED_LIGHT="#d20f39"
export TTY_COLOR_GREEN_LIGHT="#40a02b"
export TTY_COLOR_YELLOW_LIGHT="#df8e1d"
export TTY_COLOR_BLUE_LIGHT="#1e66f5"
export TTY_COLOR_MAGENTA_LIGHT="#ea76cb"
export TTY_COLOR_CYAN_LIGHT="#04a5e5"
export TTY_COLOR_WHITE_LIGHT="#5c5f77"
export TTY_COLOR_BRIGHT_BLACK_LIGHT="#939ab9"
export TTY_COLOR_BRIGHT_RED_LIGHT="#de0332"
export TTY_COLOR_BRIGHT_GREEN_LIGHT="#37ab20"
export TTY_COLOR_BRIGHT_YELLOW_LIGHT="#ec8e10"
export TTY_COLOR_BRIGHT_BLUE_LIGHT="#1462ff"
export TTY_COLOR_BRIGHT_MAGENTA_LIGHT="#f26ecd"
export TTY_COLOR_BRIGHT_CYAN_LIGHT="#0090e9"
export TTY_COLOR_BRIGHT_WHITE_LIGHT="#515682"
export TTY_INACTIVE_PANE_BRIGHTNESS_LIGHT="0.93"

if [ "$SYSTEM_COLOR_THEME" = "dark" ]; then
    export TTY_COLOR_BG0="${TTY_COLOR_BG0_DARK}"
    export TTY_COLOR_BG1="${TTY_COLOR_BG1_DARK}"
    export TTY_COLOR_BG2="${TTY_COLOR_BG2_DARK}"
    export TTY_COLOR_FG0="${TTY_COLOR_FG0_DARK}"
    export TTY_COLOR_FG1="${TTY_COLOR_FG1_DARK}"
    export TTY_COLOR_BLACK="${TTY_COLOR_BLACK_DARK}"
    export TTY_COLOR_RED="${TTY_COLOR_RED_DARK}"
    export TTY_COLOR_GREEN="${TTY_COLOR_GREEN_DARK}"
    export TTY_COLOR_YELLOW="${TTY_COLOR_YELLOW_DARK}"
    export TTY_COLOR_BLUE="${TTY_COLOR_BLUE_DARK}"
    export TTY_COLOR_MAGENTA="${TTY_COLOR_MAGENTA_DARK}"
    export TTY_COLOR_CYAN="${TTY_COLOR_CYAN_DARK}"
    export TTY_COLOR_WHITE="${TTY_COLOR_WHITE_DARK}"
    export TTY_COLOR_BRIGHT_BLACK="${TTY_COLOR_BRIGHT_BLACK_DARK}"
    export TTY_COLOR_BRIGHT_RED="${TTY_COLOR_BRIGHT_RED_DARK}"
    export TTY_COLOR_BRIGHT_GREEN="${TTY_COLOR_BRIGHT_GREEN_DARK}"
    export TTY_COLOR_BRIGHT_YELLOW="${TTY_COLOR_BRIGHT_YELLOW_DARK}"
    export TTY_COLOR_BRIGHT_BLUE="${TTY_COLOR_BRIGHT_BLUE_DARK}"
    export TTY_COLOR_BRIGHT_MAGENTA="${TTY_COLOR_BRIGHT_MAGENTA_DARK}"
    export TTY_COLOR_BRIGHT_CYAN="${TTY_COLOR_BRIGHT_CYAN_DARK}"
    export TTY_COLOR_BRIGHT_WHITE="${TTY_COLOR_BRIGHT_WHITE_DARK}"
    export TTY_INACTIVE_PANE_BRIGHTNESS="0.8"
else
    export TTY_COLOR_BG0="${TTY_COLOR_BG0_LIGHT}"
    export TTY_COLOR_BG1="${TTY_COLOR_BG1_LIGHT}"
    export TTY_COLOR_BG2="${TTY_COLOR_BG2_LIGHT}"
    export TTY_COLOR_FG0="${TTY_COLOR_FG0_LIGHT}"
    export TTY_COLOR_FG1="${TTY_COLOR_FG1_LIGHT}"
    export TTY_COLOR_BLACK="${TTY_COLOR_BLACK_LIGHT}"
    export TTY_COLOR_RED="${TTY_COLOR_RED_LIGHT}"
    export TTY_COLOR_GREEN="${TTY_COLOR_GREEN_LIGHT}"
    export TTY_COLOR_YELLOW="${TTY_COLOR_YELLOW_LIGHT}"
    export TTY_COLOR_BLUE="${TTY_COLOR_BLUE_LIGHT}"
    export TTY_COLOR_MAGENTA="${TTY_COLOR_MAGENTA_LIGHT}"
    export TTY_COLOR_CYAN="${TTY_COLOR_CYAN_LIGHT}"
    export TTY_COLOR_WHITE="${TTY_COLOR_WHITE_LIGHT}"
    export TTY_COLOR_BRIGHT_BLACK="${TTY_COLOR_BRIGHT_BLACK_LIGHT}"
    export TTY_COLOR_BRIGHT_RED="${TTY_COLOR_BRIGHT_RED_LIGHT}"
    export TTY_COLOR_BRIGHT_GREEN="${TTY_COLOR_BRIGHT_GREEN_LIGHT}"
    export TTY_COLOR_BRIGHT_YELLOW="${TTY_COLOR_BRIGHT_YELLOW_LIGHT}"
    export TTY_COLOR_BRIGHT_BLUE="${TTY_COLOR_BRIGHT_BLUE_LIGHT}"
    export TTY_COLOR_BRIGHT_MAGENTA="${TTY_COLOR_BRIGHT_MAGENTA_LIGHT}"
    export TTY_COLOR_BRIGHT_CYAN="${TTY_COLOR_BRIGHT_CYAN_LIGHT}"
    export TTY_COLOR_BRIGHT_WHITE="${TTY_COLOR_BRIGHT_WHITE_LIGHT}"
    export TTY_INACTIVE_PANE_BRIGHTNESS="0.93"
fi

