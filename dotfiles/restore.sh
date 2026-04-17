#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Restoring Claude Code config..."
mkdir -p ~/.claude
# Replace __HOME__ placeholder with actual home dir
sed "s|__HOME__|$HOME|g" "$DOTFILES_DIR/claude/settings.json" > ~/.claude/settings.json
echo "    ~/.claude/settings.json"
echo "    NOTE: Set ANTHROPIC_API_KEY and ANTHROPIC_BASE_URL in your environment or edit the file."

echo ""
echo "==> Restoring Kiro config..."
mkdir -p ~/.kiro/settings
mkdir -p ~/.kiro/powers

sed "s|__HOME__|$HOME|g" "$DOTFILES_DIR/kiro/settings/mcp.json" > ~/.kiro/settings/mcp.json
echo "    ~/.kiro/settings/mcp.json"

cp "$DOTFILES_DIR/kiro/settings/cli.json" ~/.kiro/settings/cli.json
echo "    ~/.kiro/settings/cli.json"

cp "$DOTFILES_DIR/kiro/powers/installed.json" ~/.kiro/powers/installed.json
echo "    ~/.kiro/powers/installed.json"

KIRO_USER_SETTINGS="$HOME/Library/Application Support/Kiro/User/settings.json"
mkdir -p "$(dirname "$KIRO_USER_SETTINGS")"
cp "$DOTFILES_DIR/kiro/user-settings.json" "$KIRO_USER_SETTINGS"
echo "    $KIRO_USER_SETTINGS"

echo ""
echo "==> Restoring git config..."
mkdir -p ~/.git-hooks
cp "$DOTFILES_DIR/git/hooks/commit-msg" ~/.git-hooks/commit-msg
chmod +x ~/.git-hooks/commit-msg
echo "    ~/.git-hooks/commit-msg"
sed "s|__HOME__|$HOME|g" "$DOTFILES_DIR/git/gitconfig" > ~/.gitconfig
echo "    ~/.gitconfig"

echo ""
echo "==> Done. Restart Kiro and Claude Code to apply changes."
echo ""
echo "Required environment variables:"
echo "  export ANTHROPIC_API_KEY=<your-key>"
echo "  export ANTHROPIC_BASE_URL=<your-gateway-url>"
echo "  export GITHUB_PERSONAL_ACCESS_TOKEN=<your-token>"
