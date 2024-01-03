#!/bin/bash

set -e

APP_TEMP_NAME="TemplateApp"
APP_NEW_NAME="Example"
AUTHOR_TEMP_NAME="TemplateAuthor"
AUTHOR_NEW_NAME="Megogo"

sed -i '' "s/${APP_TEMP_NAME}/${APP_NEW_NAME}/g" project.yml
sed -i '' "s/${APP_TEMP_NAME}/${APP_NEW_NAME}/g" ${APP_TEMP_NAME}/Sources/AppDelegate/AppDelegate.swift
sed -i '' "s/${APP_TEMP_NAME}/${APP_NEW_NAME}/g" ${APP_TEMP_NAME}/Sources/AppDelegate/SceneDelegate.swift
sed -i '' "s/${APP_TEMP_NAME}/${APP_NEW_NAME}/g" ${APP_TEMP_NAME}/Sources/Views/RootView.swift
sed -i '' "s/${APP_TEMP_NAME}/${APP_NEW_NAME}/g" ${APP_TEMP_NAME}Tests/${APP_TEMP_NAME}Tests.swift

sed -i '' "s/${AUTHOR_TEMP_NAME}/${AUTHOR_NEW_NAME}/g" ${APP_TEMP_NAME}/Sources/AppDelegate/AppDelegate.swift
sed -i '' "s/${AUTHOR_TEMP_NAME}/${AUTHOR_NEW_NAME}/g" ${APP_TEMP_NAME}/Sources/AppDelegate/SceneDelegate.swift
sed -i '' "s/${AUTHOR_TEMP_NAME}/${AUTHOR_NEW_NAME}/g" ${APP_TEMP_NAME}/Sources/Views/RootView.swift
sed -i '' "s/${AUTHOR_TEMP_NAME}/${AUTHOR_NEW_NAME}/g" ${APP_TEMP_NAME}Tests/${APP_TEMP_NAME}Tests.swift


mv "${APP_TEMP_NAME}Tests/${APP_TEMP_NAME}Tests.swift" "${APP_TEMP_NAME}Tests/${APP_NEW_NAME}Tests.swift"
mv "${APP_TEMP_NAME}" "${APP_NEW_NAME}"
mv "${APP_TEMP_NAME}Tests" "${APP_NEW_NAME}Tests"
