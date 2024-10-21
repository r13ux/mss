#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# Setup Finder Commands
# Show Library Folder in Finder
chflags nohidden ~/Library

# Show Hidden Files in Finder
defaults write com.apple.finder AppleShowAllFiles YES

# Show Path Bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show Status Bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Check for Homebrew, and then install it
if test ! "$(which brew)"; then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed successfully"
else
    echo "Homebrew already installed!"
fi
 echo >> /Users/ddownen/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/ddownen/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

# Install XCode Command Line Tools
echo 'Checking to see if XCode Command Line Tools are installed...'
brew config

# Updating Homebrew.
echo "Updating Homebrew..."
brew update

# Upgrade any already-installed formulae.
echo "Upgrading Homebrew..."
brew upgrade

# Install iTerm2
echo "Installing iTerm2..."
brew cask install iterm2

# Update the Terminal
# Install oh-my-zsh
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "Need to logout now to start the new SHELL..."
logout

# Install Git
echo "Installing Git..."
brew install git

# Install Powerline fonts
echo "Installing Powerline fonts..."
git clone https://github.com/powerline/fonts.git
cd fonts || exit
sh -c ./install.sh

# Install ruby
if test ! "$(which ruby)"; then
    echo "Installing Ruby..."
    brew install ruby
    echo "Adding the brew ruby path to shell config..."
    echo 'export PATH='"/usr/local/opt/ruby/bin:$PATH" >>~/.bash_profile
else
    echo "Ruby already installed!"
fi

# Install some sec tools.
brew install nmap
brew install nikto
brew install caskroom/cask/brew-caskbrew cask install owasp-zap
brew install recon-ng
brew install theharvester


# Install other useful binaries.
brew install speedtest_cli
brew install mtr
brew install tcptraceroute

# Core casks
brew cask install --appdir="/Applications" alfred

# Development tool casks
brew cask install --appdir="/Applications" vscodium

# Misc casks
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" 1password
brew cask install --appdir="/Applications" wireshark
brew cask install --appdir="/Applications" discord


# Remove outdated versions from the cellar.
echo "Running brew cleanup..."
brew cleanup
echo "You're done!"
