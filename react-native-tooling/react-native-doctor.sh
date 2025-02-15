#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print status
print_status() {
    if [ $2 -eq 0 ]; then
        echo -e "${GREEN}✓ $1${NC}"
    else
        echo -e "${RED}✗ $1${NC}"
        OVERALL_STATUS=1
    fi
}

echo "🔍 Checking React Native development environment..."
echo

# Initialize overall status
OVERALL_STATUS=0

# Check Node.js installation via Brew
if command_exists node; then
    if brew list node &>/dev/null; then
        print_status "Node.js is installed via Brew ($(node -v))" 0
    else
        print_status "Node.js is installed but not via Brew" 1
    fi
else
    print_status "Node.js is not installed" 1
fi

# Check Watchman installation via Brew
if command_exists watchman; then
    if brew list watchman &>/dev/null; then
        print_status "Watchman is installed via Brew ($(watchman --version))" 0
    else
        print_status "Watchman is installed but not via Brew" 1
    fi
else
    print_status "Watchman is not installed" 1
fi

# Check Xcode installation
if [ -d "/Applications/Xcode.app" ]; then
    # Check if xcodebuild works and it's not just Command Line Tools
    if xcodebuild -version 2>&1 | grep -q "Xcode"; then
        XCODE_VERSION=$(xcodebuild -version | head -n 1)
        print_status "Xcode is installed ($XCODE_VERSION)" 0
    else
        print_status "Xcode is not properly configured (only Command Line Tools found)" 1
    fi
else
    print_status "Xcode is not installed" 1
fi

# Check Java Zulu 17 installation
ZULU_PATH="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
if [ -d "$ZULU_PATH" ]; then
    print_status "Java Zulu 17 is installed" 0
else
    print_status "Java Zulu 17 is not installed" 1
fi

# Check JAVA_HOME
if [ -n "$JAVA_HOME" ]; then
    if [ "$JAVA_HOME" = "$ZULU_PATH" ]; then
        print_status "JAVA_HOME is correctly set to Zulu 17" 0
    else
        print_status "JAVA_HOME is set but not pointing to Zulu 17 ($JAVA_HOME)" 1
    fi
else
    print_status "JAVA_HOME is not set" 1
fi

# Check Android environment variables
echo -e "\n${YELLOW}Checking Android environment variables:${NC}"
if [[ "$PATH" == *"$ANDROID_HOME/emulator"* ]]; then
    print_status "Android emulator is in PATH" 0
else
    print_status "Android emulator is not in PATH" 1
fi

if [[ "$PATH" == *"$ANDROID_HOME/platform-tools"* ]]; then
    print_status "Android platform-tools is in PATH" 0
else
    print_status "Android platform-tools is not in PATH" 1
fi

# Check Android SDK components
echo -e "\n${YELLOW}Checking Android SDK components:${NC}"
if [ -d "$ANDROID_HOME" ]; then
    print_status "Android SDK is installed at $ANDROID_HOME" 0
    
    # Check for Android SDK Platform
    if [ -d "$ANDROID_HOME/platforms" ]; then
        print_status "Android SDK Platform is installed" 0
    else
        print_status "Android SDK Platform is not installed" 1
    fi
    
    # Check for Android Virtual Device
    if [ -d "$HOME/.android/avd" ] && [ "$(ls -A $HOME/.android/avd)" ]; then
        print_status "Android Virtual Device exists" 0
    else
        print_status "No Android Virtual Device found" 1
    fi
else
    print_status "Android SDK is not installed" 1
fi

echo
if [ $OVERALL_STATUS -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed successfully!${NC}"
else
    echo -e "${RED}❌ Some checks failed. Please review the issues above.${NC}"
fi

exit $OVERALL_STATUS
