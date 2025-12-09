#!/bin/bash

# Function to detect the shell profile file
get_shell_profile() {
  if [ -n "$BASH_VERSION" ]; then
    echo "$HOME/.bashrc"
  elif [ -n "$ZSH_VERSION" ]; then
    echo "$HOME/.zshrc"
  else
    echo "$HOME/.profile"
  fi
}

# Check if adb is installed
if ! command -v adb &> /dev/null; then
    echo "adb could not be found. Please install Android Debug Bridge (adb)."
    exit 1
fi

echo "Android ADB Connection Wizard"
echo "-----------------------------"

# Check for ADB_HOST environment variable
if [ -z "$ADB_HOST" ]; then
    read -p "ADB_HOST environment variable not set. Enter the host IP of your Android device: " host_ip
    if [ -z "$host_ip" ]; then
        echo "No IP address entered. Exiting."
        exit 1
    fi

    export ADB_HOST=$host_ip
    
    SHELL_PROFILE=$(get_shell_profile)
    
    echo "Saving ADB_HOST to $SHELL_PROFILE..."
    echo "" >> "$SHELL_PROFILE"
    echo "# Added by ADB Connection Wizard" >> "$SHELL_PROFILE"
    echo "export ADB_HOST=$ADB_HOST" >> "$SHELL_PROFILE"
    echo "ADB_HOST set to $ADB_HOST. You may need to restart your shell for this to take effect everywhere."
else
    echo "Using existing ADB_HOST: $ADB_HOST"
fi

# Check current connection status
echo "Checking connection status..."
adb devices

# Ask to pair
read -p "Do you need to pair the device? (y/n): " should_pair
if [[ "$should_pair" == "y" || "$should_pair" == "Y" ]]; then
    read -p "Enter the pairing port: " pair_port
    read -p "Enter the pairing code: " pair_code
    adb pair "$ADB_HOST:$pair_port" "$pair_code"
fi

# Ask to connect
read -p "Do you want to connect to the device? (y/n): " should_connect
if [[ "$should_connect" == "y" || "$should_connect" == "Y" ]]; then
    read -p "Enter the connection port: " connect_port
    adb connect "$ADB_HOST:$connect_port"
fi

# Final status check
echo "Final connection status:"
adb devices

echo "Script finished."
