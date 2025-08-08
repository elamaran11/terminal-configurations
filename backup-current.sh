#!/bin/bash

# 🔄 Backup Current Terminal Configurations
# Use this script to update the repository with your current configs

echo "🔄 Backing up current terminal configurations..."

# Copy current configurations
echo "📋 Copying Zsh configuration..."
cp ~/.zshrc zsh/.zshrc

echo "🎨 Copying Powerlevel10k configuration..."
cp ~/.p10k.zsh p10k/.p10k.zsh

echo "📺 Copying Tmux configuration..."
cp ~/.config/tmux/tmux.conf tmux/tmux.conf

echo "📜 Copying custom scripts..."
cp ~/.local/bin/get_temp.sh scripts/ 2>/dev/null || echo "get_temp.sh not found"
cp ~/.local/bin/get_location.sh scripts/ 2>/dev/null || echo "get_location.sh not found"

echo "✅ Backup complete!"
echo ""
echo "📤 To push changes to GitHub:"
echo "git add ."
echo "git commit -m 'Update terminal configurations'"
echo "git push origin main"
