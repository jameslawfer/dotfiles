#!/usr/bin/env python3

# requires i3status_ext.sh

import sys
import subprocess
import dbus
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib


# Define what you want to execute on connect or disconnect
def handle_bluetooth_event(mac_address, alias, action):
    """
    action will be either "connect" or "disconnect"
    """
    print(f"Device Event: {alias} ({mac_address}) has performed: {action}")

    subprocess.run(["/home/james/.config/i3/scripts/00-refresh_i3status.sh"])
    # chuck any other commands up in here

    if action == "connect":
        # Example: Trigger a desktop notification or custom script
        # subprocess.run(["sudo", "systemctl", "restart", "some-service"])
        pass
    elif action == "disconnect":
        pass


def properties_changed(interface, changed_properties, invalidated_properties, path):
    # We only care about BlueZ device properties changes
    if interface != "org.bluez.Device1":
        return

    if "Connected" in changed_properties:
        is_connected = bool(changed_properties["Connected"])
        action = "connect" if is_connected else "disconnect"

        # Fetch device details (MAC address and friendly Name/Alias)
        try:
            device_obj = bus.get_object("org.bluez", path)
            device_props = dbus.Interface(device_obj, "org.freedesktop.DBus.Properties")
            mac_address = device_props.Get("org.bluez.Device1", "Address")
            alias = device_props.Get("org.bluez.Device1", "Alias")
        except Exception:
            mac_address = "Unknown"
            alias = "Unknown"

        handle_bluetooth_event(mac_address, alias, action)


if __name__ == "__main__":
    # Initialize the D-Bus loop
    DBusGMainLoop(set_as_default=True)
    bus = dbus.SystemBus()

    # Listen to property alterations across the whole BlueZ topology
    bus.add_signal_receiver(
        properties_changed,
        bus_name="org.bluez",
        dbus_interface="org.freedesktop.DBus.Properties",
        signal_name="PropertiesChanged",
        path_keyword="path",
    )

    print("Bluetooth dispatcher daemon started. Listening for connections...")
    loop = GLib.MainLoop()
    try:
        loop.run()
    except KeyboardInterrupt:
        sys.exit(0)
