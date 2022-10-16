# qusbkill

A working USBKill script for Qubes

Installation is as follows:

- Copy `qusbkill`, `qusbkill.service`, and `uk` into dom0
- Copy/move `qusbkill` into `/usr/bin` and mark it as executable
- Copy/move `qusbkill.service` into `/etc/systemd/system`
- Copy/move `uk` into `/usr/bin` and mark it executable
  - `uk` is a helper script to disable/re-enable qusbkill without typing a long systemctl command
- Run `systemctl enable qusbkill` to make qusbkill start at boot
- After qusbkill is set to start at boot, run `systemctl start qusbkill` to start qusbkill immediately

This will enable the service at boot, and start the service
To insert or remove a USB device without causing dom0 to power off, temporarily stop the service with `systemctl stop qusbkill` or use the provided helper script `uk`, then restart it after the device is inserted/removed
It doesn't require any changes to be made to sys-usb in order to work

### Using the `uk` helper script

`uk` is effectively just an alias for `systemctl <start/stop/restart/status> qusbkill`. The major benefit is it's shorter

- To start qusbkill, run `uk start`
- To stop qusbkill, run `uk stop`
- To check if qusbkill is running, run `qucbkill status`
- You can also queue multiple commands. For example, `qusbkill start status` will start qusbkill, then show the status to make sure it's actually running

### How to copy files to dom0

The Qubes official documentation has information about copying files to dom0: https://www.qubes-os.org/doc/how-to-copy-from-dom0/#copying-to-dom0

For the best security, you should download this into a disposable VM, to prevent a compromised qube from tampering with the data locally
