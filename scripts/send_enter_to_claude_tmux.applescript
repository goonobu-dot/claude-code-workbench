on run
    set tmuxPath to system attribute "TMUX_BIN"
    if tmuxPath is "" then
        set tmuxPath to "/opt/homebrew/bin/tmux"
    end if
    set sessionName to "claude-code-9"
    set shellCommand to quoted form of tmuxPath & " send-keys -t " & quoted form of sessionName & " Enter"
    do shell script shellCommand
end run
