#!/bin/bash

# Check if wget is installed
if ! command -v curl &> /dev/null; then
    echo "🚨 Please install curl and try again"
    exit 1
fi

# URL of the zip file
zip_url="https://github.com/belkevich/TemplateApp/archive/refs/heads/main.zip"

# Download the zip file
echo "📥 Downloading zip file from $zip_url..."
curl -sSLO "$zip_url"

# Check if curl encountered an error
if [ $? -ne 0 ]; then
    echo "🚨 Failed to download template archive"
    exit 1
fi

# Unpack the zip file to the current directory
echo "📤 Unpacking zip file..."
unzip -q main.zip
# Remove the downloaded zip file
rm main.zip
# Rename directory
mv TemplateApp-main TemplateApp
echo "✅ Template successfully downloaded"

echo "➡️  Please, run ./setup name=MyAppName team=org.team.my to proceed"
