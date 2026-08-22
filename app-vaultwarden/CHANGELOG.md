# 1.0.39

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.37.2

# 1.0.38

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.37.1

# 1.0.37

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.37.0

# 1.0.36

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.36.0.

# 1.0.35

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.35.8.

# 1.0.34

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.35.7.

# 1.0.33

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.35.6.

# 1.0.32

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.35.5.

# 1.0.31

- Update documentation.
- Update images.
- Update translations.

# 1.0.30

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.35.4.
- Update documentation.

# 1.0.29

Add German translation.

# 1.0.28

Use host instead of IP.

# 1.0.27

- Add IPv6 support.
- Change Web UI URL to /admin and use IP instead of host.

# 1.0.26

Update icon & logo.

# 1.0.25

Update AppArmor.

# 1.0.24

Update AppArmor.

# 1.0.23

- Update to [Vaultwarden](https://github.com/dani-garcia/vaultwarden) 1.35.3.
- Update AppArmor.

# 1.0.22

Allow udp traffic for Vaultwarden in AppArmor.

# 1.0.21

- Limit Vaultwarden & Nginx to tcp traffic in AppArmor.
- Update documentation.

# 1.0.20

Fix directory access for Nginx in AppArmor.

# 1.0.19

Fix System information & file access for Nginx in AppArmor.

# 1.0.18

Fix documentation links.

# 1.0.17

Update AppArmor.

# 1.0.16

Update AppArmor.

# 1.0.15

Update AppArmor.

# 1.0.14

Update AppArmor.

# 1.0.13

Update AppArmor.

# 1.0.12

Update AppArmor.

# 1.0.11

Update AppArmor.

# 1.0.10

Update AppArmor.

# 1.0.9

Update AppArmor.

# 1.0.8

Update AppArmor, config.yaml and documentation.

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
