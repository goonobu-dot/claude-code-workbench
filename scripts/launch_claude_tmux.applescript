on run
    set launcherPath to system attribute "CLAUDE_WORKBENCH_SCRIPT"
    if launcherPath is "" then
        set launcherPath to (POSIX path of (path to home folder)) & "ClaudeCodeWorkbench/claude-code-workbench/scripts/launch_claude_tmux.sh"
    end if
    tell application "Terminal"
        activate
        do script quoted form of launcherPath
        set bounds of front window to {0, 25, 1920, 1025}
        set custom title of front window to "Claude Code 9 tmux"
    end tell
end run
