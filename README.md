# System Update Runner

A lightweight Linux GUI system update manager written in Bash, using **Zenity** (preferred) or **YAD** as a fallback. System Update Runner provides a simple graphical interface for updating packages across multiple package managers from one place.

## Features

- **Dynamic package-manager detection:** Automatically detects installed package managers and builds the selection list accordingly.
- **Multiple package managers:** Supports APT, Pacman, Yay, Flatpak and Snap.
- **Live status ticker:** Converts package-manager output into readable status messages displayed in a graphical progress dialog.
- **Background update worker:** Runs updates independently of the GUI progress window, so closing the progress window does not intentionally interrupt active package operations.
- **Per-manager result reporting:** Reports individual package-manager results, making partial failures easier to identify.
- **Optional logging:** Use `-l`, `--log`, or `/l` to save update logs under `~/.local/share/system-updater/logs/`. Logs older than 30 days are automatically removed.
- **Desktop notifications:** Sends completion or error notifications when `notify-send` is available.
- **Sound feedback:** Supports optional completion/error sounds using `paplay`, `pw-play`, or `aplay`, when available.
- **Reboot detection:** Checks for `/var/run/reboot-required` and offers a reboot prompt when necessary.

## Supported Package Managers

| Package Manager | Supported Systems | Update Command |
|---|---|---|
| APT | Debian, Ubuntu and derivatives | `apt-get update` followed by `apt-get upgrade -y` |
| Pacman | Arch Linux and derivatives | `pacman -Syu --noconfirm` |
| Yay | Arch-based systems with Yay installed | `yay -Syu --noconfirm` |
| Flatpak | Linux distributions with Flatpak | `flatpak update -y` |
| Snap | Linux distributions with Snap | `snap refresh` |

When Yay is installed, the script avoids presenting duplicate Pacman and Yay update options where appropriate.

## Requirements

### Required

- Bash
- Zenity or YAD
- `sudo` for privileged package-manager operations

### Optional

- `notify-send` — desktop notifications
- `paplay`, `pw-play` or `aplay` — sound feedback
- `flock` — prevents multiple instances from running simultaneously

The package managers themselves are only required if you intend to update software managed by them.

## Testing

System Update Runner has been tested on the following Linux distributions:

- **MX Linux** — using Zenity.
- **EndeavourOS** — using YAD.

Other distributions may work, provided the required package managers and graphical dependencies are available.

## Installation

System Update Runner can be installed system-wide so it can be launched from any terminal location.

### 1. Download the script

Download `system-updater-runner` from this repository.

### 2. Install it system-wide

## Installation

System Update Runner includes an installation script that downloads the application and installs it system-wide.

### Quick Install

Open a terminal and run:

```bash
wget -O install-system-update-runner.sh https://raw.githubusercontent.com/cybermaxpower/System-Update-Runner/main/install-system-update-runner.sh
bash install-system-update-runner.sh

```

The installer downloads the application, installs the icon and creates an application menu entry.

You do not need to run the installer as root. It requests administrative permission when required.

### Launching the Application

Once installed, launch System Update Runner from your application menu or run:

```bash
system-updater-runner
```

## Usage

Launch the application:

```bash
system-updater-runner
```

Select the package managers you want to update from the graphical checklist and follow the prompts.

### Enable Logging

To enable logging for an update session:

```bash
system-updater-runner --log
```

The following options are also supported:

```bash
system-updater-runner -l
system-updater-runner /l
```

Logs are saved under:

```text
~/.local/share/system-updater/logs/
```

Log files older than 30 days are automatically removed.

## Uninstallation

To remove the system-wide installation:

```bash
sudo rm /usr/local/bin/system-updater-runner
```

This removes the application script but does not remove your log files.

If you also want to remove the saved logs:

```bash
rm -r ~/.local/share/system-updater
```

## Troubleshooting

### Neither Zenity nor YAD is installed

Install one of the supported graphical dialog tools using your distribution's package manager.

For example, on Debian/Ubuntu/MX Linux etc:

```bash
sudo apt install zenity
```

On Arch Linux:

```bash
sudo pacman -S yad
```

### Permission denied

Ensure the script was installed with executable permissions:

```bash
ls -l /usr/local/bin/system-updater-runner
```

### Command not found

Check that `/usr/local/bin` is included in your `PATH`:

```bash
echo "$PATH"
```

## Safety

- Run System Update Runner as a regular user, **not as root**.
- Review the package-manager operations your distribution performs.
- Ensure important data is backed up before performing system updates.
- Package updates may install, upgrade or remove packages according to your distribution's package-manager behaviour.
- Closing the graphical progress window does not intentionally terminate an active package update worker.

## Author

**M. Wait**  
GitHub: [@cybermaxpower](https://github.com/cybermaxpower)

## License

Released under the **MIT License**. See the [LICENSE](https://github.com/cybermaxpower/System-Update-Runner/blob/main/LICENSE) file for details."

This preserves the Markdown symbols literally, so it shouldn't render the headings, bold text, tables, or code blocks.
