# Making Vaultwarden available externally using a Cloudflare Tunnel

## Prerequisites

This documentation is based on the following assumptions:

- You have a Raspberry Pi with Home Assistant and the Vaultwarden app installed.
- You already own a domain **your-domain.com** that is or is not already registered with Cloudflare.
- The **[Vaultwarden](https://github.com/mariorasch/ha-apps/tree/main/app-vaultwarden)** app is installed in Home Assistant and running on port is **7277**.
- After this setup, Vaultwarden will be available at **https://vault.your-domain.com**.

## Setup

### 1 Sign in to Cloudflare

**Sign in to Cloudflare** (a free account is sufficient).

### 2. Add your domain to Cloudflare

**Please note** that you only need to do this if your domain is not already registered with Cloudflare. If your domain is already registered with Cloudflare, you can skip this step.

**Add the domain your-domain.com to Cloudflare**. This is necessary to set up Cloudflare tunnels via your domain. For instructions on adding, see https://developers.cloudflare.com/dns/zone-setups/full-setup/setup/.

#### Note 1 - DNS Records

Regarding the "**Review DNS records**" section: the DNS records for the nameservers (type "DS") do not need to be transferred to Cloudflare, as per the instructions above, the original nameservers get changed to nameservers provided by Cloudflare.

#### Note 2 - DNS Propagation

Regarding DNS propagation: changing the nameservers and distributing these changes worldwide can take up to 72 hours (in exceptional cases, longer).

### 3 Add Cloudflare Tunnel

Add a Cloudflare Tunnel at Cloudflare Dashboard -> Zero Trust -> Networks -> Connectors -> "+ Create Tunnel" -> Tunnel type "Cloudflared" with the following configuration:

- In the "Name Tunnel" step, choose e.g. **tunnel name** "Home Assistant". Please note tnat you can use one tunnel in order to make multiple services running in Home Assistant (or your Home Assistent UI itself) externally available.
- In the "Install and Run Connector" step, **copy the generated token**.
- In the "Route Tunnel" step, **enter the following configuration**:
  - **Public Hostname:** choose subdomain "vault" and select your domain.
  - **Service:** http
  - **URL:** localhost:7277

### 4 Install Cloudflared app

Install the **[Cloudflared](https://github.com/hassio-addons/addon-cloudflared)** app in Home Assistant. In the configuration, enter the **tunnel name and the copied tunnel token**, everything else can remain empty:

- **tunnel_name:** Home Assistant
- **tunnel_token:** (the token copied in step 3)
