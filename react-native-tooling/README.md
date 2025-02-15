# React Native Doctor

A diagnostic tool for checking your React Native development environment setup on macOS.
Basically from `https://reactnative.dev/docs/set-up-your-environment` but sometimes you want to ensure other team have correct setup too.

## Overview

React Native Doctor is a bash script that performs comprehensive checks on your development environment to ensure all required dependencies and configurations are properly set up for React Native development.

## Features

The script checks for:

- Node.js installation (via Homebrew)
- Watchman installation (via Homebrew)
- Xcode installation and configuration
- Java Zulu 17 installation
- JAVA_HOME configuration
- Android environment setup including:
  - Android SDK installation
  - Android emulator configuration
  - Platform tools setup
  - Android Virtual Device existence

## Usage

1. Make the script executable:
```bash
chmod +x react-native-doctor.sh
```

2. Run the script:
```bash
./react-native-doctor.sh
```

## Output

The script provides clear visual feedback using color-coded symbols:
- ✓ (Green): Check passed
- ✗ (Red): Check failed
- Items requiring attention are highlighted in red
- Final summary indicates overall environment status

## Requirements

This script is designed for macOS and checks for the following requirements:

- Homebrew-installed Node.js
- Homebrew-installed Watchman
- Xcode
- Java Zulu 17
- Android SDK
- Properly configured environment variables
- Android Virtual Device setup

## Troubleshooting

If you see red ✗ marks, here are the common fixes:

1. **Node.js not installed via Homebrew:**
   ```bash
   brew install node
   ```

2. **Watchman not installed via Homebrew:**
   ```bash
   brew install watchman
   ```

3. **Xcode not installed:**
   - Install Xcode from the Mac App Store
   - Run `xcode-select --install` after installation

4. **Java Zulu 17 not installed:**
   ```bash
   brew install --cask zulu17
   ```

5. **JAVA_HOME not set:**
   Add to your `~/.zshrc` or `~/.bash_profile`:
   ```bash
   export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
   ```

6. **Android SDK issues:**
   - Install Android Studio
   - Use SDK Manager to install required platforms
   - Create an Android Virtual Device using AVD Manager

## License

MIT

## Contributing

Feel free to submit issues and enhancement requests!
