#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_BUNDLE="${CLAUDE_WORKBENCH_APP_BUNDLE:-$HOME/Applications/Claude Code Workbench.app}"
SEND_RETURN_APP_BUNDLE="${CLAUDE_WORKBENCH_SEND_RETURN_APP_BUNDLE:-$HOME/Applications/Claude Code Send Return.app}"
SCRIPT_PATH="$ROOT_DIR/scripts/launch_claude_tmux.applescript"
SEND_RETURN_SCRIPT_PATH="$ROOT_DIR/scripts/send_enter_to_claude_tmux.applescript"
ICON_NAME="ClaudeCode9Panes"
ICON_FILE="$ROOT_DIR/Assets/$ICON_NAME.icns"

clear_app_xattrs() {
    local bundle_path="$1"
    if command -v xattr >/dev/null 2>&1; then
        /usr/bin/xattr -cr "$bundle_path"
        while IFS= read -r -d '' path; do
            /usr/bin/xattr -d com.apple.FinderInfo "$path" 2>/dev/null || true
            /usr/bin/xattr -d 'com.apple.fileprovider.fpfs#P' "$path" 2>/dev/null || true
            /usr/bin/xattr -d com.apple.macl "$path" 2>/dev/null || true
        done < <(find "$bundle_path" -print0)
    fi
}

sign_app() {
    local bundle_path="$1"
    if command -v codesign >/dev/null 2>&1; then
        rm -rf "$bundle_path/Contents/_CodeSignature"
        clear_app_xattrs "$bundle_path"
        codesign --force --deep --sign - "$bundle_path" >/dev/null
    fi
}

rm -rf "$APP_BUNDLE"
rm -rf "$SEND_RETURN_APP_BUNDLE"
mkdir -p "$(dirname "$APP_BUNDLE")" "$(dirname "$SEND_RETURN_APP_BUNDLE")"
python3 "$ROOT_DIR/scripts/create_app_icon.py" >/dev/null
iconutil -c icns "$ROOT_DIR/Assets/$ICON_NAME.iconset" -o "$ICON_FILE"
osacompile -o "$APP_BUNDLE" "$SCRIPT_PATH"
osacompile -o "$SEND_RETURN_APP_BUNDLE" "$SEND_RETURN_SCRIPT_PATH"
cp "$ICON_FILE" "$APP_BUNDLE/Contents/Resources/$ICON_NAME.icns"
cp "$ICON_FILE" "$SEND_RETURN_APP_BUNDLE/Contents/Resources/$ICON_NAME.icns"
/usr/libexec/PlistBuddy -c "Set :CFBundleName Claude Code Workbench" "$APP_BUNDLE/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName Claude Code Workbench" "$APP_BUNDLE/Contents/Info.plist" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :CFBundleIconFile $ICON_NAME" "$APP_BUNDLE/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleIconName $ICON_NAME" "$APP_BUNDLE/Contents/Info.plist" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :CFBundleName Claude Code Send Return" "$SEND_RETURN_APP_BUNDLE/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleIconFile $ICON_NAME" "$SEND_RETURN_APP_BUNDLE/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleIconName $ICON_NAME" "$SEND_RETURN_APP_BUNDLE/Contents/Info.plist" 2>/dev/null || true

clear_app_xattrs "$APP_BUNDLE"
clear_app_xattrs "$SEND_RETURN_APP_BUNDLE"

touch "$APP_BUNDLE"
touch "$SEND_RETURN_APP_BUNDLE"
clear_app_xattrs "$APP_BUNDLE"
clear_app_xattrs "$SEND_RETURN_APP_BUNDLE"
sign_app "$APP_BUNDLE"
sign_app "$SEND_RETURN_APP_BUNDLE"

echo "$APP_BUNDLE"
echo "$SEND_RETURN_APP_BUNDLE"
