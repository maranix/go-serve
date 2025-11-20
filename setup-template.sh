#!/bin/bash

# This script automates setting up the go-serve template in your current directory.
# It's designed to be run in an empty Git repository.

REPO_URL="https://github.com/maranix/go-serve.git"
TAG="v1.0.0" # Use a specific tag for stability. Can be updated to fetch latest.
TEMP_DIR="go-serve-template-temp"

echo "==================================================="
echo "Initializing go-serve template in the current directory."
echo "==================================================="

# Check if current directory is empty (excluding .git and script itself)
if find . -maxdepth 1 -not -name '.*' -not -name "$TEMP_DIR" -not -name "$(basename "$0")" -print -quit | grep -q .; then
    echo "Warning: Current directory is not empty. Existing files might be overwritten or conflict."
    read -p "Do you want to continue? (y/N): " response
    if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Aborting."
        exit 1
    fi
fi

# Create a temporary directory
echo "Creating temporary directory: $TEMP_DIR"
mkdir -p "$TEMP_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create temporary directory. Exiting."
    exit 1
fi

# Clone the specific tag into the temporary directory
echo "Cloning go-serve template tag $TAG from $REPO_URL into $TEMP_DIR..."
git clone --depth 1 --branch "$TAG" "$REPO_URL" "$TEMP_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone the repository. Please check your internet connection or repository URL. Exiting."
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Copy all files from the cloned repository to the current directory, excluding .git
echo "Copying template files to current directory..."
# Use dot to copy contents of TEMP_DIR, not TEMP_DIR itself
rsync -a "$TEMP_DIR"/ . --exclude ".git" --exclude "$(basename "$0")" --exclude ".github"
if [ $? -ne 0 ]; then
    echo "Error: Failed to copy files. Exiting."
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Clean up the temporary directory
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

# Initialize Git repository if not already initialized and make an initial commit
if [ ! -d ".git" ]; then
    echo "Initializing a new Git repository..."
    git init
    git add .
    git commit -m "feat: initial commit from go-serve template"
else
    echo "Existing Git repository detected. Staging and committing new files..."
    git add .
    git commit -m "feat: apply go-serve template"
fi

echo "==================================================="
echo "go-serve template setup complete!"
echo "Your new project is ready. You can now run 'make run' to start the server."
echo "==================================================="
echo ""
echo "Next steps:"
echo "1. Review the generated files, especially README.md."
echo "2. Customize go.mod module path if needed (e.g., 'go mod edit -module your/new/module')."
echo "3. Start building your Go HTTP service!"
echo ""
