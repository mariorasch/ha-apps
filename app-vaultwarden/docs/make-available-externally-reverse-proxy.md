# Making Vaultwarden available externally using a FRITZ!Box Internet router and a Reverse Proxy

## Prerequisites

This documentation is based on the following assumptions:

- You have a FRITZ!Box router and a Raspberry Pi with Home Assistant and the Vaultwarden app installed.
- The Raspberry Pi is reachable at the fixed IPv4 address **192.168.178.100**.
- The name of your Raspberry Pi in your FRITZ!Box is **RaspberryPi**.
- The **[Vaultwarden](https://github.com/mariorasch/ha-apps/tree/main/app-vaultwarden)** app is installed in Home Assistant and running on port is **7277**.
- After this setup, Vaultwarden will be available at **https://raspberrypi.your-subdomain.myfritz.link**.

**Please note** that company proxies / firewalls may block access to the myfritz.link domain. If this is the case and you like to access your Vaultwarden instance from your company network, consider setting up external availability by the use of a Cloudflare Tunnel.

## Setup

### 1. Enable MyFRITZ! Internet access

In your FRITZ!Box, go to Internet -> MyFRITZ! Account and check "**MyFRITZ! enabled for this FRIGTZ!Box**".

### 2. Manage MyFRITZ! addresses

At https://www.myfritz.net -> MyFRITZ!Net Settings -> Manage MyFRITZ! addresses, create the custom MyFRITZ! address **your-subdomain.myfritz.link**.

After that in your FRITZ!Box go to Internet -> MyFRITZ! Account and under MyFRITZ! Internet Access check that your MyFRITZ! address is **your-subdomain.myfritz.link**.

### 3. Configure Port Sharing in your FRITZ!Box

In your FRITZ!Box under Internet -> Permit Access -> Port Sharing, click on "Add Device for Sharing", select your "RaspberryPi" device and click on "New Sharing" in order to add MyFRITZ! sharings for applications "HTTP server" and "HTTPS server". The following settings can be left deactivated:

- "Permit independent port sharing for this device"
- "Open this device completely for internet sharing via IPv4 (exposed host)"
- "Enable PING6"
- "Open firewall for delegated IPv6 prefixes of this device"
- "Open this device completely for internet sharing via IPv6 (exposed host)"

The required **IPv6 Interface-ID** can be found, for example, at http://homeassistant.local:8123/config/network -> IPv6 -> Subnet Prefix 128: it consists of the last 4 parts of the displayed IPv6 address.

### 4. Install Nginx Proxy Manager

Install the **[Nginx Proxy Manager](https://github.com/hassio-addons/addon-nginx-proxy-manager)** app in Home Assistant. This app additionally requires the **MariaDB** app, which needs to be installed first.

### 5. Configure Proxy Host

Using the "Nginx Proxy Manager" user interface -> Hosts -> "Proxy Hosts", add a new proxy host with the following configuration:

- **Domain Names:** raspberrypi.houseofmouse.myfritz.link
- **Scheme:** http
- **Forward Hostname / IP:** 192.168.178.100
- **Forward Port:** 7277
 - Enable options **Cache Assets**, **Block Common Exploits**, **Websockets Support**, **Force SSL** and **HTTP/2 Support**.
