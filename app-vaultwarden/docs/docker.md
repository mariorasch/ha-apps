colima start --arch aarch64 --vm-type=vz --vz-rosetta

docker-buildx build --file Dockerfile --pull --no-cache --platform linux/arm64 --tag app-vaultwarden --build-arg BUILD_DATE="$(date -Iseconds)" .

docker tag app-vaultwarden ghcr.io/mariorasch/ha-apps/app-vaultwarden:1.0.36

docker push ghcr.io/mariorasch/ha-apps/app-vaultwarden:1.0.36
