#!/bin/bash
if [ -d "flutter" ]; then
    echo "Flutter directory exists."
else
    git clone https://github.com/flutter/flutter.git -b stable
fi
export PATH="$PATH:$(pwd)/flutter/bin"
flutter doctor
flutter clean
flutter config --enable-web

echo "Building Flutter web app..."

flutter build web --release \
  --dart-define=FIREBASE_API_KEY_WEB="$FIREBASE_API_KEY_WEB" \
  --dart-define=FIREBASE_APP_ID_WEB="$FIREBASE_APP_ID_WEB" \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID_WEB="$FIREBASE_MESSAGING_SENDER_ID_WEB" \
  --dart-define=FIREBASE_PROJECT_ID="$FIREBASE_PROJECT_ID" \
  --dart-define=FIREBASE_AUTH_DOMAIN_WEB="$FIREBASE_AUTH_DOMAIN_WEB" \
  --dart-define=FIREBASE_STORAGE_BUCKET_WEB="$FIREBASE_STORAGE_BUCKET_WEB" \
  --dart-define=FIREBASE_MEASUREMENT_ID_WEB="$FIREBASE_MEASUREMENT_ID_WEB"
