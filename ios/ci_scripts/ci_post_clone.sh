#!/bin/sh

# Xcode Cloud runs this script from ios/ci_scripts after cloning the repository.
set -e

cd "$CI_PRIMARY_REPOSITORY_PATH"

# Install Flutter for the ephemeral Xcode Cloud environment.
git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
export PATH="$HOME/flutter/bin:$PATH"
flutter precache --ios

# Generate Flutter's iOS build settings and install Dart dependencies.
flutter pub get

# Resolve the Flutter iOS plugin dependencies.
cd ios
HOMEBREW_NO_AUTO_UPDATE=1 brew install cocoapods
pod install
