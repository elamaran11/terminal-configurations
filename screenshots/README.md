# 📸 Screenshots

This directory contains screenshots of the terminal configuration in action.

## 🖼️ How to Take Screenshots

### Method 1: macOS Screenshot (Recommended)
1. Open your terminal with tmux running
2. Press `Cmd + Shift + 4` 
3. Select the terminal window area
4. Screenshot will be saved to Desktop
5. Move it to this directory and rename appropriately

### Method 2: Terminal Screenshot Tool
```bash
# Install screenshot tool
brew install imagemagick

# Take screenshot of current terminal
screencapture -x ~/terminal-configurations/screenshots/tmux-status-bar.png
```

### Method 3: Full Window Screenshot
1. Press `Cmd + Shift + 4`
2. Press `Space` to capture entire window
3. Click on terminal window
4. Move screenshot here

## 📁 Screenshot Naming Convention

- `tmux-status-bar.png` - Main tmux status bar view
- `p10k-prompt.png` - Powerlevel10k prompt example
- `aws-directory-colors.png` - Special directory colors in AWS project
- `full-terminal-setup.png` - Complete terminal view
- `system-monitoring.png` - Tmux system monitoring in action

## 🎯 What to Capture

### Essential Screenshots:
1. **Tmux Status Bar** - Show the complete footer with all gadgets
2. **P10k Prompt** - Show the gorgeous lavender directory colors
3. **Full Setup** - Complete terminal view with both tmux and p10k
4. **AWS Project** - Special colors when in AWS Observability directory

### Recommended Views:
- Terminal with tmux running
- Show the reordered footer: IP → WiFi → Temperature → Location → System Stats
- Demonstrate the auto-location and temperature features
- Show the beautiful pastel colors

## 📤 Adding Screenshots to Repo

After taking screenshots:

```bash
cd ~/terminal-configurations
# Copy your screenshots to this directory
cp ~/Desktop/screenshot.png screenshots/tmux-status-bar.png

# Add to git
git add screenshots/
git commit -m "Add terminal screenshots"
git push origin main
```

## 🎨 Tips for Great Screenshots

- Use a dark terminal background for better contrast
- Make sure all tmux gadgets are visible
- Capture during active network usage to show real data
- Include some directory navigation to show p10k colors
- Consider taking screenshots at different times to show weather changes
