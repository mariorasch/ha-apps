# 1.0.12

Update apparmor.txt.

# 1.0.11

Update apparmor.txt.

# 1.0.10

Update apparmor.txt.

# 1.0.9

Update apparmor.txt.

# 1.0.8

Update apparmor.txt, config.yaml and documentation.

# 1.0.7

Update Dockerfile to install necessary Vaultwarden dependencies.

# 1.0.6

- Fix option "request_size_limit" in config.yaml.
- Remove mapping for "ssl" folder.

# 1.0.5

- Update Dockerfile to only install dependencies necessary to run this app using SQLite.
- Clean up rootfs contents to only contain necessary files and directories to let Vaultwarden run locally without SSL / HTTPS. SSL / HTTPS should be setup by making Vaultwarden available externally.
- Update documentation.

# 1.0.4

Change base image to ghcr.io/home-assistant/aarch64-base-debian.

# 1.0.3

Initial version based on [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.35.2.
