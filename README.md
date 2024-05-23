# qusbkill

A working USBKill script for Qubes

Installation is as follows:

- Copy `qusbkill`, `qusbkill.service`, and `uk` into dom0
- Copy/move `qusbkill` into `/usr/bin` and mark it as executable
- Copy/move `qusbkill.service` into `/etc/systemd/system`
- Copy/move `uk` into `/usr/bin` and mark it executable
  - `uk` is a helper script to disable/re-enable qusbkill without typing a long systemctl command
- (Optional, but recommended) Confirm 1usbkill is working correctly by running `systemctl start qusbkill`
  - If your system powers off shortly after running this command, debug the issue before enabling `qusbkill` at boot
- Run `systemctl enable qusbkill` to make qusbkill start at boot
- After qusbkill is set to start at boot, run `systemctl start qusbkill` to start qusbkill immediately

This will enable the service at boot, and start the service
To insert or remove a USB device without causing dom0 to power off, temporarily stop the service with `systemctl stop qusbkill` or use the provided helper script `uk`, then restart it after the device is inserted/removed
It doesn't require any changes to be made to sys-usb in order to work

### Using the `uk` helper script

`uk` is effectively just an alias for `systemctl <start/stop/restart/status> qusbkill`. The major benefit is it's shorter

- To start qusbkill, run `uk start`
- To stop qusbkill, run `uk stop`
- To check if qusbkill is running, run `uk status`
- To view qusbkill's logs, run `uk log`
- To delete qusbkill's logs, run `uk rm-log`
- You can also queue multiple commands. For example, `uk start status` will start qusbkill, then show the status to make sure it's actually running

### Debugging

If `qusbkill` shuts down the system, the event will be logged to `/var/log/qusbkill.log` in dom0

The following tips may be useful for debugging:

- `qusbkill` queries the list of expected USB devices when it starts. Restarting the service or rebooting the system will cause it to retrieve a new list of expected devices. Expected devices are not saved or remembered across reboots

### Preventing unexpected shutdowns

To reduce the likelihood of usbkill unexpectedly powering off the system, stop the `qusbkill` service before inserting or removing USB devices, and before stopping or restarting the UsbVM. If restarting the UsbVM, wait until the UsbVM is fully started before starting the `qusbkill` service

### How to copy files to dom0

The Qubes official documentation has information about copying files to dom0: https://www.qubes-os.org/doc/how-to-copy-from-dom0/#copying-to-dom0

For better security, you should download this into a disposable VM, to prevent a compromised qube from tampering with the data locally

For the best security, you should use [qubes-clean](https://github.com/NobodySpecial256/qubes-clean) to copy this script into dom0
