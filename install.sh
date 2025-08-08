#!/bin/bash

# 🚀 Terminal Configurations Installation Script
# Automated setup for Zsh, Powerlevel10k, and Tmux

set -e

echo "🚀 Starting Terminal Configurations Installation..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_warning "This script is optimized for macOS. Some features may not work on other systems."
fi

# 1. Install Homebrew if not installed
print_status "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew installed!"
else
    print_success "Homebrew already installed!"
fi

# 2. Install required packages
print_status "Installing required packages..."
brew install zsh tmux ifstat 2>/dev/null || print_warning "Some packages may already be installed"

# Install Nerd Font
print_status "Installing Meslo Nerd Font..."
brew install --cask font-meslo-lg-nerd-font 2>/dev/null || print_warning "Font may already be installed"

# 3. Install Oh My Zsh if not installed
print_status "Checking for Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed!"
else
    print_success "Oh My Zsh already installed!"
fi

# 4. Install Oh My Zsh plugins
print_status "Installing Oh My Zsh plugins..."

# Install zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    print_success "zsh-autosuggestions installed!"
else
    print_success "zsh-autosuggestions already installed!"
fi

# Install zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    print_success "zsh-syntax-highlighting installed!"
else
    print_success "zsh-syntax-highlighting already installed!"
fi

# 5. Install Powerlevel10k theme
print_status "Installing Powerlevel10k theme..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    print_success "Powerlevel10k installed!"
else
    print_success "Powerlevel10k already installed!"
fi

# 6. Backup existing configurations
print_status "Backing up existing configurations..."
mkdir -p backup-configs
[ -f ~/.zshrc ] && cp ~/.zshrc backup-configs/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
[ -f ~/.p10k.zsh ] && cp ~/.p10k.zsh backup-configs/.p10k.zsh.backup.$(date +%Y%m%d_%H%M%S)
[ -f ~/.config/tmux/tmux.conf ] && cp ~/.config/tmux/tmux.conf backup-configs/tmux.conf.backup.$(date +%Y%m%d_%H%M%S)

# 7. Copy configuration files
print_status "Installing configuration files..."

# Copy Zsh configuration
cp zsh/.zshrc ~/.zshrc
print_success "Zsh configuration installed!"

# Copy Powerlevel10k configuration
cp p10k/.p10k.zsh ~/.p10k.zsh
print_success "Powerlevel10k configuration installed!"

# Copy Tmux configuration
mkdir -p ~/.config/tmux
cp tmux/tmux.conf ~/.config/tmux/tmux.conf
print_success "Tmux configuration installed!"

# 8. Setup custom scripts
print_status "Installing custom scripts..."
mkdir -p ~/.local/bin
cp scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*.sh
print_success "Custom scripts installed!"

# 9. Install Tmux Plugin Manager
print_status "Installing Tmux Plugin Manager..."
if [ ! -d ~/.local/share/tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
    print_success "Tmux Plugin Manager installed!"
else
    print_success "Tmux Plugin Manager already installed!"
fi

# 10. Set Zsh as default shell
print_status "Setting Zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
    print_success "Zsh set as default shell!"
else
    print_success "Zsh is already the default shell!"
fi

echo ""
echo "🎉 Installation Complete!"
echo ""
echo "📋 Next Steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Open tmux and press Ctrl-a + I to install tmux plugins"
echo "3. Make sure to use a Nerd Font in your terminal for proper icons"
echo ""
echo "🎨 Features:"
echo "• Beautiful Powerlevel10k prompt with custom colors"
echo "• Zsh autosuggestions and syntax highlighting"
echo "• Tmux status bar with system monitoring"
echo "• Auto-detected location and weather"
echo "• Network monitoring and system stats"
echo ""
echo "📖 Check README.md for detailed information and customization options"
echo ""
print_success "Enjoy your beautiful terminal setup!"
