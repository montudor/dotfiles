# Create important directories
mkdir -p ~/Developer
mkdir -p ~/.config

# Keyboard and Mouse Config
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 8
defaults write -g KeyRepeat -int 1
defaults write -g com.apple.mouse.scaling -1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

killall Finder

# Dock
defaults write com.apple.dock show-recents -bool false;
# Hidden way to change amount of recent items in dock (cool)
# defaults write com.apple.dock show-recent-count -int 3;
killall Dock


# Install Homebrew
if which brew > /dev/null; then
    echo "Homebrew is already installed."
else
    echo "Homebrew is not installed. Installing now..."
    # This is the official installation command from the Homebrew website:
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ $? -eq 0 ]; then
        echo "Homebrew installation successful."
    else
        echo "Homebrew installation failed."
    fi
fi

# Install Homebrew packages from Brewfile
brew bundle --file="$(dirname "$0")/../brew/Brewfile-core"


# Tmux TPM Install
if "test ! -d ~/.tmux/plugins/tpm" \
   "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"


# Rectangle
defaults write com.knollsoft.Rectangle screenEdgeGapTop -int 4
defaults write com.knollsoft.Rectangle screenEdgeGapBottom -int 4
defaults write com.knollsoft.Rectangle screenEdgeGapLeft -int 4
defaults write com.knollsoft.Rectangle screenEdgeGapRight -int 4
defaults write com.knollsoft.Rectangle gapSize -int 4

# Rectangle Pro
# defaults write com.knollsoft.Hookshot screenEdgeGapTop -int 4
# defaults write com.knollsoft.Hookshot screenEdgeGapBottom -int 4
# defaults write com.knollsoft.Hookshot screenEdgeGapLeft -int 4
# defaults write com.knollsoft.Hookshot screenEdgeGapRight -int 4
# defaults write com.knollsoft.Hookshot gapSize -int 4
