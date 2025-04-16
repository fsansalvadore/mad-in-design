#!/bin/bash

echo "Checking node_modules symlinks..."

# Check if the bootstrap exists within node_modules
if [ -d "node_modules/bootstrap" ]; then
  echo "✅ Bootstrap exists in node_modules"
else
  echo "❌ Bootstrap not found in node_modules"
fi

# Check if the symlink in vendor assets exists
if [ -L "vendor/assets/stylesheets/node_modules" ]; then
  echo "✅ Symlink exists in vendor/assets/stylesheets"
else
  echo "❌ Symlink not found in vendor/assets/stylesheets"
fi

if [ -L "vendor/assets/javascripts/node_modules" ]; then
  echo "✅ Symlink exists in vendor/assets/javascripts"
else
  echo "❌ Symlink not found in vendor/assets/javascripts"
fi

# Check if bootstrap is accessible through the symlink
if [ -d "vendor/assets/stylesheets/node_modules/bootstrap" ]; then
  echo "✅ Bootstrap is accessible through the stylesheets symlink"
else
  echo "❌ Bootstrap not accessible through the stylesheets symlink"
fi

if [ -d "vendor/assets/javascripts/node_modules/bootstrap" ]; then
  echo "✅ Bootstrap is accessible through the javascripts symlink"
else
  echo "❌ Bootstrap not accessible through the javascripts symlink"
fi

echo "Check complete" 