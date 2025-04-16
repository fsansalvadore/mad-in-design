#!/bin/bash
# Run this script with your app name as argument: ./bin/setup-heroku-buildpacks.sh your-app-name

if [ -z "$1" ]; then
  echo "Please provide your Heroku app name as an argument"
  echo "Example: ./bin/setup-heroku-buildpacks.sh your-app-name"
  exit 1
fi

APP_NAME=$1

echo "Setting up buildpacks for $APP_NAME..."

# Clear existing buildpacks
heroku buildpacks:clear -a $APP_NAME

# Add buildpacks in the correct order
heroku buildpacks:add heroku/nodejs -a $APP_NAME
heroku buildpacks:add heroku/ruby -a $APP_NAME

echo "Buildpacks have been set up correctly!"
echo "To confirm, run: heroku buildpacks -a $APP_NAME" 