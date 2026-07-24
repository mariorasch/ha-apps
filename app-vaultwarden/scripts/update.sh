#!/bin/zsh

# Extract current app version from Dockerfile
declare CURRENT_VAULTWARDEN_VERSION=$(
      grep -E 'FROM ["'\'']vaultwarden/server:.*["'\'']' Dockerfile \
    | sed -E 's/.*vaultwarden\/server:([0-9]+\.[0-9]+\.[0-9]+).*/\1/' \
    | tr -d '"')

# Get the latest version of vaultwarden/server in major.minor.revision format
declare NEW_VAULTWARDEN_VERSION=$(
      curl -s "https://hub.docker.com/v2/repositories/vaultwarden/server/tags/" \
    | jq -r '.results[] | .name' \
    | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' \
    | head -n 1)

# Extract current app version from config.yaml
declare CURRENT_APP_VERSION=$(
      grep -E 'version:' config.yaml \
    | awk '{print $2}' \
    | tr -d '"' \
    | tr -d "'")

# Split app version into components
IFS='.' read -r CURRENT_APP_MAJOR CURRENT_APP_MINOR CURRENT_APP_REVISION <<< "$CURRENT_APP_VERSION"

# Increment the app's revision number
declare NEW_APP_REVISION=$((CURRENT_APP_REVISION + 1))

# Build new app version
declare NEW_APP_VERSION="${CURRENT_APP_MAJOR}.${CURRENT_APP_MINOR}.${NEW_APP_REVISION}"

# Update Dockerfile
if [ -f "Dockerfile" ]; then
    sed -i '' "s/FROM \([\"']\)vaultwarden\/server:[^\"']*/FROM \1vaultwarden\/server:$NEW_VAULTWARDEN_VERSION/" Dockerfile
    sed -i '' "s/ARG BUILD_VERSION=.*/ARG BUILD_VERSION=$NEW_VAULTWARDEN_VERSION/" Dockerfile

    echo "Updated Dockerfile from version $CURRENT_VAULTWARDEN_VERSION to $NEW_VAULTWARDEN_VERSION"
else
    echo "Dockerfile not found"
fi

# Update config.yaml (if needed)
if [ -f "config.yaml" ]; then
    # Update config.yaml with the new version
    sed -i '' "s/version: \([\"']\).*/version: \1$NEW_APP_VERSION\1/" config.yaml

    echo "Updated config.yaml from version $CURRENT_APP_VERSION to $NEW_APP_VERSION"
else
    echo "config.yaml not found"
fi

# Update CHANGELOG.md
if [ -f "CHANGELOG.md" ]; then
    # Read the current content of CHANGELOG.md
    declare CHANGELOG_CONTENT=$(cat CHANGELOG.md)

    # Create the new entry
    declare NEW_ENTRY="# ${NEW_APP_VERSION}\n\n- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) $NEW_VAULTWARDEN_VERSION\n\n"

    # Write the new entry + current content back to CHANGELOG.md
    echo -e ""${NEW_ENTRY}${CHANGELOG_CONTENT}"" > CHANGELOG.md

    echo "Updated CHANGELOG.md"
else
    echo "CHANGELOG.md not found"
fi

echo "Update process completed"
