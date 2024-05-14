#!/bin/bash

# Initialize variables
name=""
team=""

# Parse arguments
for arg in "$@"
do
    key=$(echo "$arg" | cut -f1 -d=)
    value=$(echo "$arg" | cut -f2 -d=)
    case $key in
        name)
            name=$value
            ;;
        team)
            team=$value
            ;;
        *)
            echo "🚨 Unknown argument: $key"
            exit 1
            ;;
    esac
done

# Check if both arguments are provided
if [ -z "$name" ] || [ -z "$team" ]; then
    echo "🚨 Usage: $0 name=AppName team=org.team"
    exit 1
fi

# Check if xcodegen is installed
if ! command -v xcodegen &> /dev/null; then
    echo "🚨 Please install xcodegen to use this script https://github.com/yonaskolb/XcodeGen"
    exit 1
fi

# Clean previous install
# Remove sources
if [ -d "${name}" ]; then
    echo "☑️ Remove ${name}/"
    rm -r "${name}"
fi
# Remove tests
if [ -d "${name}Tests" ]; then
    echo "☑️ Remove ${name}Tests/"
    rm -r "${name}Tests"
fi
# Remove xcodeproj
if [ -d "${name}.xcodeproj" ]; then
    echo "☑️ Remove ${name}.xcodeproj/"
    rm -r "${name}.xcodeproj"
fi

# Rename existed project files and project settings
set -e

temp_name="TemplateApp"
temp_team="TemplateAuthor"

echo "🔄 Rename project name to ${name}"
sed -i '' "s/${temp_name}/${name}/g" project.yml
sed -i '' "s/${temp_name}/${name}/g" ${temp_name}/Sources/AppDelegate/AppDelegate.swift
sed -i '' "s/${temp_name}/${name}/g" ${temp_name}/Sources/AppDelegate/SceneDelegate.swift
sed -i '' "s/${temp_name}/${name}/g" ${temp_name}/Sources/Views/RootView.swift
sed -i '' "s/${temp_name}/${name}/g" ${temp_name}Tests/${temp_name}Tests.swift

echo "🔄 Rename project team to ${team}"
sed -i '' "s/${temp_team}/${team}/g" ${temp_name}/Sources/AppDelegate/AppDelegate.swift
sed -i '' "s/${temp_team}/${team}/g" ${temp_name}/Sources/AppDelegate/SceneDelegate.swift
sed -i '' "s/${temp_team}/${team}/g" ${temp_name}/Sources/Views/RootView.swift
sed -i '' "s/${temp_team}/${team}/g" ${temp_name}Tests/${temp_name}Tests.swift

echo "🔄 Move sources to ${name}"
mv "${temp_name}" "${name}"
echo "🔄 Rename tests to ${name}Tests"
mv "${temp_name}Tests/${temp_name}Tests.swift" "${temp_name}Tests/${name}Tests.swift"
echo "🔄 Move tests to ${name}Tests"
mv "${temp_name}Tests" "${name}Tests"

# Run xcodegen
echo "🛠️  Generate xcodeproj"
xcodegen

# Open project
echo "🛠️  Open ${name}"
open "${name}.xcodeproj"

#Finish
echo "✅ Done!"
