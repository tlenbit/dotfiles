# -*- sh -*-

# Start a new tmux session with texas inside.
if [ -z "$TMUX" ]; then
    tmux -L texas new-session 'LAUNCH_TEXAS=1 zsh'
    exit
fi

[ -z "$TEXAS_CONFIG_SIZE" ] && TEXAS_CONFIG_SIZE=70

local TEXAS_ADDITIONAL_FLAGS=()
[ "$TEXAS_CONFIG_HORIZONTAL" = 1 ] && TEXAS_ADDITIONAL_FLAGS+=("-h")

if [ "$TEXAS_CONFIG_NOSWAP" = 1 ]; then
    TEXAS_RANGER_PID=$(tmux split-window $TEXAS_ADDITIONAL_FLAGS -p "$TEXAS_CONFIG_SIZE" -P -F '#{pane_pid}' "LAUNCH_TEXAS=$LAUNCH_TEXAS TEXAS_SHELL_PID=$$ ranger")
else
    TEXAS_RANGER_PID=$(tmux split-window $TEXAS_ADDITIONAL_FLAGS -p "$((100 - TEXAS_CONFIG_SIZE))" -P -F '#{pane_pid}' "LAUNCH_TEXAS=$LAUNCH_TEXAS TEXAS_SHELL_PID=$$ ranger")
    tmux swap-pane -D
fi

# Do not bind a key in a non-dedicated tmux daemon. Tmux binds are
# global per daemon so that would contaminate the user environment.
if [ "$LAUNCH_TEXAS" = 1 ]; then
    local TEXAS_SWITCH_COMMAND
    TEXAS_SWITCH_COMMAND=$(cat <<'EOF'
if [ "$(tmux display-message -p '#{window_panes}')" -gt 1 ]; then
    tmux select-pane -t :.+
else
    tmux next-window
fi
EOF
)
    [ -z "$TEXAS_CONFIG_SWITCH_KEY" ] && TEXAS_CONFIG_SWITCH_KEY="C-o"
    tmux bind -n "$TEXAS_CONFIG_SWITCH_KEY" run -b "$TEXAS_SWITCH_COMMAND"

    [ -f "$TEXAS_CONFIG_TMUX_CONFIG" ] && tmux source "$TEXAS_CONFIG_TMUX_CONFIG"
fi

# Unset the variable only here because the ranger plugin reacts to it.
unset LAUNCH_TEXAS

autoload -U add-zsh-hook

texas--sh-to-ranger-sync() {
    if ! kill -USR1 $TEXAS_RANGER_PID 2> /dev/null; then
        # ranger is no longer running, let's clean up the zsh state.

        # The ranger's PID is no longer needed.
        unset TEXAS_RANGER_PID

        # Remove the hook because there is no ranger to communicate with.
        chpwd_functions=${chpwd_functions:#texas--sh-to-ranger-sync}
    fi
}
add-zsh-hook chpwd texas--sh-to-ranger-sync

texas--exit-cleanup() {
    kill -HUP $TEXAS_RANGER_PID
}
add-zsh-hook zshexit texas--exit-cleanup

texas--ranger-to-sh-sync() {
    # This trap may be called either during a command execution or
    # not. If it's the latter, zle will be active and we can change
    # the cwd safely. If a command is being executed, do nothing. The
    # cwd will be updated on the next signal from ranger after the
    # command finishes its execution.
    if zle; then
        cd -qP /proc/$TEXAS_RANGER_PID/cwd
        zle reset-prompt
    fi
}
trap texas--ranger-to-sh-sync USR1
