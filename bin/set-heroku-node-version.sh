#!/bin/bash
# Run this script with your app name as argument: ./bin/set-heroku-node-version.sh your-app-name

if [ -z "$1" ]; then
  echo "Please provide your Heroku app name as an argument"
  echo "Example: ./bin/set-heroku-node-version.sh your-app-name"
  exit 1
fi

APP_NAME=$1

echo "Setting Node.js version for $APP_NAME..."

# Set the Node.js version explicitly
heroku config:set NODE_VERSION=16.20.0 -a $APP_NAME

echo "Node.js version has been set to 16.20.0"
echo "To confirm, run: heroku config -a $APP_NAME | grep NODE_VERSION" 