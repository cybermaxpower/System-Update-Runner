# System Update Runner

A lightweight Linux GUI system update manager written in Bash using **Zenity** (with **YAD** as a fallback) to update packages across multiple package managers from a single interface.

## Supported Package Managers

- **APT** — Debian and Ubuntu-based distributions (`apt-get update` followed by `apt-get upgrade -y`)
- **Pacman** — Arch-based distributions (`pacman -Syu --noconfirm`)
- **Yay** — Arch packages and AUR (`yay -Syu --noconfirm`, with `SUDO_ASKPASS` support for non-interactive GUI runs)
- **Flatpak** — Flatpak applications (`flatpak update -y`)
- **Snap** — Snap packages (`snap refresh`)

## Features

- **Dynamic detection:** Automatically detects installed package managers and builds the selection checklist accordingly (avoiding duplicate Pacman + Yay entries when `yay` is installed).
- **Live status ticker:** Translates package-manager output into readable progress status messages inside a Zenity or YAD progress dialog.
- **Decoupled update worker:** Runs updates in a background worker and tails output to the GUI so closing the progress window does not interrupt active package operations.
- **Per-manager result reporting:** Tracks and reports individual manager statuses (`OK` or `Failed`) rather than hiding partial failures.
- **Optional logging:** Supports `-l`, `--log`, or `/l` to save logs under `~/.local/share/system-updater/logs/` and automatically removes logs older than 30 days.
- **Notifications & sound:** Optional desktop notifications (`notify-send`) and completion/error chimes (`paplay`, `pw-play`, or `aplay`) when available.
- **Reboot prompt:** Checks `/var/run/reboot-required` and prompts before rebooting if requested.

## Requirements

- `bash`
- `zenity` (preferred) or `yad` (fallback)
- `sudo` (required when updating APT, Pacman, Yay, or Snap)
- Optional: `notify-send` for desktop notifications; `paplay`, `pw-play`, or `aplay` for sound feedback

## Usage

Make the script executable and run it as a regular user (do not run directly as `root`):

```bash
chmod +x system-updater-runner
./system-updater-runner
```

### Enable Logging

```bash
./system-updater-runner -l
```

*(Also accepts `--log` or `/l`.)*

## Author & License

- **Author:** M. Wait ([github.com/cybermaxpower](https://github.com/cybermaxpower))
- **License:** MIT License
````[cite: 40]
