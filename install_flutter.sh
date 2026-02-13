#!/bin/bash
if [ -d "flutter" ]; then
    cd flutter
    git pull
    cd ..
else
    git clone https://github.com/flutter/flutter.git -b stable
fi
export PATH="$PATH:$(pwd)/flutter/bin"
flutter doctor
flutter clean
flutter config --enable-web
flutter build web --release
