#!/bin/zsh

declare GHCR_PATH="ghcr.io/mariorasch/ha-apps/app-vaultwarden"

# Extract current Vaultwarden server version
declare CURRENT_VAULTWARDEN_VERSION=$(
      grep -E 'FROM ["'\'']vaultwarden/server:.*["'\'']' Dockerfile \
    | sed -E 's/.*vaultwarden\/server:([0-9]+\.[0-9]+\.[0-9]+).*/\1/' \
    | tr -d '"')

# Get the latest Vaultwarden server version
declare NEW_VAULTWARDEN_VERSION=$(
      curl -s "https://hub.docker.com/v2/repositories/vaultwarden/server/tags/" \
    | jq -r '.results[] | .name' \
    | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' \
    | head -n 1)

if [ "$CURRENT_VAULTWARDEN_VERSION" = "$NEW_VAULTWARDEN_VERSION" ]; then
    echo "Vaultwarden server is already up to date (version ${CURRENT_VAULTWARDEN_VERSION})"

    exit 1
fi

# Extract current app version
declare CURRENT_APP_VERSION=$(
      grep -E 'version:' config.yaml \
    | awk '{print $2}' \
    | tr -d '"' \
    | tr -d "'")

# Build new app version
IFS='.' read -r CURRENT_APP_MAJOR CURRENT_APP_MINOR CURRENT_APP_REVISION <<< "$CURRENT_APP_VERSION"

declare NEW_APP_REVISION=$((CURRENT_APP_REVISION + 1))
declare NEW_APP_VERSION="${CURRENT_APP_MAJOR}.${CURRENT_APP_MINOR}.${NEW_APP_REVISION}"

# Update Vaultwarden server version
if [ -f "Dockerfile" ]; then
    sed -i '' "s/FROM \([\"']\)vaultwarden\/server:[^\"']*/FROM \1vaultwarden\/server:$NEW_VAULTWARDEN_VERSION/" Dockerfile
    sed -i '' "s/ARG BUILD_VERSION=.*/ARG BUILD_VERSION=$NEW_VAULTWARDEN_VERSION/" Dockerfile

    echo "Updated Vaultwarden server version from ${CURRENT_VAULTWARDEN_VERSION} to ${NEW_VAULTWARDEN_VERSION}"
else
    echo "Dockerfile not found"
fi

# Update app version
if [ -f "config.yaml" ]; then
    sed -i '' "s/version: \([\"']\).*/version: \1$NEW_APP_VERSION\1/" config.yaml

    echo "Updated app version from ${CURRENT_APP_VERSION} to ${NEW_APP_VERSION}"
else
    echo "config.yaml not found"
fi

# Update CHANGELOG.md
if [ -f "CHANGELOG.md" ]; then
    declare CHANGELOG_CONTENT=$(cat CHANGELOG.md)
    declare NEW_ENTRY="# ${NEW_APP_VERSION}\n\n- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) $NEW_VAULTWARDEN_VERSION\n\n"

    echo -e ""${NEW_ENTRY}${CHANGELOG_CONTENT}"" > CHANGELOG.md

    echo "Updated CHANGELOG.md"
else
    echo "CHANGELOG.md not found"
fi

# Optionally build and push a new Docker image
read "BUILD_IMAGE?Do you want to build and push a new Docker image? (y/N): "

if [ "$BUILD_IMAGE" = "y" ]; then
    if ! colima status &> /dev/null; then
        echo "Starting Colima..."

        colima start --arch aarch64 --vm-type=vz --vz-rosetta
    else
        echo "Colima is already running"
    fi

    echo "Building Docker image..."

    docker buildx build \
        --file Dockerfile \
        --pull \
        --no-cache \
        --platform linux/arm64 \
        --tag app-vaultwarden \
        --build-arg BUILD_DATE="$(date -Iseconds)" .

    echo "Tagging Docker image \"app-vaultwarden\" with version ${CURRENT_APP_VERSION}..."

    docker tag app-vaultwarden $GHCR_PATH:$NEW_APP_VERSION

    echo "Pushing Docker image..."

    docker push $GHCR_PATH:$NEW_APP_VERSION

    echo "Docker image built and pushed successfully"
fi

echo "Update process completed"
