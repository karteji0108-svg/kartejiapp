#!/bin/bash

# Exit on error
set -e

# Clone Flutter SDK if not present
if [ ! -d "flutter" ]; then
    echo "Downloading Flutter SDK..."
    git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# Add Flutter to path
export PATH="$PATH:$(pwd)/flutter/bin"

# Upgrade Flutter to ensure latest stable version
flutter upgrade

# Enable web support
flutter config --enable-web

# Get dependencies
flutter pub get

# Build web app
flutter build web --release

echo "Flutter build completed successfully."
