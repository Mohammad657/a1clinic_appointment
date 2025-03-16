#!/bin/bash

# Path to the problematic header file
HEADER_FILE="/Users/mohammad/.pub-cache/hosted/pub.dev/firebase_messaging-14.8.1/ios/Classes/FLTFirebaseMessagingPlugin.h"

# Check if file exists
if [ -f "$HEADER_FILE" ]; then
  # Create backup
  cp "$HEADER_FILE" "${HEADER_FILE}.backup"
  
  # Replace the problematic import
  sed -i '' 's/#import <Firebase\/Firebase.h>/#import "Firebase.h"/g' "$HEADER_FILE"
  
  echo "Fixed Firebase Messaging header imports"
else
  echo "Firebase Messaging header file not found at $HEADER_FILE"
fi
