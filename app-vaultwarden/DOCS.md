# Vaultwarden - password management app for Home Assistant

This community app for Home Assistant allows you to use [Vaultwarden](https://github.com/dani-garcia/vaultwarden) with an included [SQLite](https://sqlite.org) database. Vaultwarden is a lightweight and open-source server implementation of the Bitwarden Client API that is optimized for self-hosting.

[Bitwarden](https://bitwarden.com) is an open-source password manager that can store sensitive information such as website credentials in an end-to-end encrypted vault.

The Bitwarden platform offers a variety of client applications including a web interface, desktop applications, browser extensions and mobile apps.

## Installation

**Please note** that Vaultwarden's web UI (except the admin panel) provided by this app **is not meant** to be accessed locally, i.e. without SSL / HTTPS.

Therefore, after this initial installation you need to follow the steps at [Make Vaultwarden available externally](#make-vaultwarden-available-externally).

1. Click the SHOW APP ON MY Home Assistant button below to open this app repository on your Home Assistant instance.

   [![Open this app repository in your Home Assistant instance.][app-badge]][app-url]

2. Click the "Install" button to install the app.
3. Start the "Vaultwarden" app.
4. Check the logs of the "Vaultwarden" app to see if everything went well and to get the admin token.
5. Click the "Open Web UI" button to open Vaultwarden.
6. Add `/admin` to the URL to access the admin panel, e.g., `http://homeassistant.local:7277/admin`. Log in using the admin token you got in step 4.
7. Be sure to store your admin token in a safe place.
8. The admin token in the logs **is only shown on app start until you saved Vaultwarden's configuration** in admin panel.

### Fix insecure admin token

**Please note** that type of the automatically generated admin token is considered to be insecure and thus there will an appropriate warning be shown in the admin panel.

To fix this warning do the following:

1. Add the "**Advanced SSH & Web Terminal**" app to Home Assistant, be sure to disable "**Protection mode**" and start this app.
2. Click the "Open Web UI" button to open a terminal.
3. Execute `docker ps | grep vaultwarden` to display details of the Docker container that runs Vaultwarden.
4. Execute `docker exec -it <container name> sh -c "/opt/vaultwarden hash"`. Replace `<container name>` with the name being displayed at end of line of output in step 3.
5. Enter a secure admin token (= password) of your choice twice.
6. Log in to Vaultwarden's admin panel, enter the generated admin token value (i.e. the string that begins with "$argon2", without the quotes) under General -> "Admin token/Argon2 PHC" and save your configuration.

## Configuration

**Note**: _Remember to restart the app when the configuration is changed._

Example app configuration:

```yaml
log_level: info
request_size_limit: 10485760
```

**Note**: _This is just an example, don't copy and paste it! Create your own!_

### Option: `log_level`

The `log_level` option controls the level of log output by the app and can be changed to be more or less verbose, which might be useful when you are dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`: Runtime errors that do not require immediate action.
- `off`: No logging at all.

Please note that each level automatically includes log messages from a more severe level, e.g., `debug` also shows `info` messages. By default, the `log_level` is set to `info`, which is the recommended setting unless you are troubleshooting.

### Option: `request_size_limit`

By default the API calls are limited to 10MB. This should be sufficient for most cases, however if you want to support large imports, this might be limiting you. On the other hand you might want to limit the request size to something smaller than that to prevent API abuse and possible DOS attack, especially if running with limited resources.

To set the limit, you can use this setting: 10MB would be `10485760`.

## Make Vaultwarden available externally

Vaultwarden's web UI (except the admin panel) provided by this app **is not meant** to be accessed locally, i.e. without SSL / HTTPS.

Instead you need to make this app externally accessible via SSL / HTTPS, e.g.

  - by the use of Home Assistant app [Nginx Proxy Manager](https://github.com/hassio-addons/addon-nginx-proxy-manager) and setting up DynDNS and port forwarding in your Internet router or
  - by the use of Home Assistant app [Cloudflared](https://github.com/homeassistant-apps/app-cloudflared).

See one of the following step-by-step guides to learn more about these two options:

- [Make Vaultwarden available externally with Nginx Proxy Manager](https://github.com/mariorasch/ha-apps/blob/main/app-vaultwarden/docs/make-available-externally-reverse-proxy.md)
- [Make Vaultwarden available externally with Cloudflared](https://github.com/mariorasch/ha-apps/blob/main/app-vaultwarden/docs/make-available-externally-cloudflare.md)

## Copying existing Vaultwarden data from your local Mac to Home Assistant app

In case you already have existing Vaultwarden data that you like to copy over to your Vaultwarden app running in Home Assistant, please have a look at the step-by-step guide:

- [Copying existing Vaultwarden data from your local Mac to Home Assistant app](https://github.com/mariorasch/ha-apps/blob/main/app-vaultwarden/docs/copying-existing-vaultwarden-data.md)

## License

MIT License

Copyright (c) 2026 Mario Rasch

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[app-badge]: https://my.home-assistant.io/badges/supervisor_addon.svg
[app-url]: https://my.home-assistant.io/redirect/supervisor_addon/?addon=e0afc296_vaultwarden&repository_url=https%3A%2F%2Fgithub.com%2Fmariorasch%2Fha-apps%2Frepository
