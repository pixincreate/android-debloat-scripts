# Android Debloat

A modular shell script to remove bloatware, reinstall removed apps, and revoke privacy-invasive permissions from system apps on Android devices.

## Currently Supported Devices

| Device | Status |
|--------|--------|
| Motorola G57 Power | Supported |

## Requirements

- ADB (Android Debug Bridge) installed
- USB debugging enabled on device
- Computer with a terminal

## Setup

1. Enable Developer Options on your phone
2. Enable USB Debugging: Settings → Developer Options → USB Debugging
3. Connect phone to computer via USB
4. Accept the USB debugging prompt on your phone

## Usage

```bash
./moto-debloat.sh <command>
```

### Commands

| Command | Description |
|---------|-------------|
| `uninstall` | Remove bloatware apps (default) |
| `install` | Reinstall previously removed apps |
| `remove-permissions` | Revoke privacy-invasive permissions from system apps |

### Examples

```bash
# Remove bloatware
./moto-debloat.sh uninstall

# Reinstall removed apps
./moto-debloat.sh install

# Remove permissions from privacy-invasive apps
./moto-debloat.sh remove-permissions
```

## Adding Support for New Devices

This repo is designed to be modular. To add support for a new device:

1. Create a new config file for the device (e.g., `config-samsung-s24.sh`)
2. Define the app lists in the config
3. Run with the config: `./android-debloat.sh --config config-samsung-s24.sh uninstall`

See the `configs/` directory for examples.

## What Gets Removed (Motorola G57 Power)

### Motorola Apps
- Smart Feed
- BrApps
- Moto Help
- Moto AI Services
- Moto Gamemode
- Moto Spaces
- Moto Care
- Moto Camera
- And more...

### Third-Party Apps
- Facebook apps
- Instagram
- Amazon apps
- Various carrier bloatware
- Taboola
- Glance

### Google Apps
- Chrome
- YouTube Music
- Google Maps (optional)
- Various Google utilities
- Play Store (not removed)
- Gmail (not removed)

## Permissions Removed

The script revokes these permissions from selected system apps:

- Location (COARSE, FINE, BACKGROUND)
- Camera
- Microphone/RECORD_AUDIO
- SMS (READ, RECEIVE, SEND)
- Phone/Call Log
- Contacts
- Accounts
- Activity Recognition
- Usage Stats
- Clipboard
- WiFi Control
- Settings Write

### Targeted Apps
- Google System Intelligence
- YouTube
- Google Play Services
- Google Play Store
- Gboard
- Google TTS
- Google Maps
- Moto Secure
- Moto Launcher

## Notes

- Some permissions may auto-regrant after system updates or setup wizard runs
- Reboot recommended after running any command
- Use `adb shell pm list packages -d` to verify removed packages

## Privacy Apps Recommendation

After cleanup, consider installing these privacy-focused alternatives:

| App | Purpose | Link |
|-----|---------|------|
| Signal | Encrypted messaging | [signal.org](https://signal.org) |
| Shizuku | ADB power user helper | [github.com/thedjchi/shizuku](https://github.com/thedjchi/shizuku) |
| RethinkDNS | DNS ad/tracker blocker | [github.com/celzero/rethink-app](https://github.com/celzero/rethink-app) |
| Obtanium | Ungoogled Chromium | [github.com/imranr98/obtanium](https://github.com/imranr98/obtanium) |
| Lawnchair | Customizable Pixel launcher | [github.com/lawnchairlauncher/lawnchair](https://github.com/lawnchairlauncher/lawnchair) |
| Heliboard | Privacy-focused keyboard | [github.com/helium314/heliboard](https://github.com/helium314/heliboard) |
| Droidify | F-Droid client | [github.com/droid-ify/client](https://github.com/droid-ify/client) |