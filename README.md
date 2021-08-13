# How to get LAKKA (Pi4) to run on PiBoy DMG

As someone who's been using LAKKA for several years now, the first thing I wanted when I got my PiBoy was to run LAKKA.
Unfortunately, the way PiBoy is built and the fact that LAKKA is based on LibreELEC, meant that it was not supported out-of-the-box.

So, with the help of Nathan Scherdin (@acidtech), i've got most of the important stuff working.

## Here's a short guide:

1. Download the latest official stable LAKKA release for Pi4 (https://le-builds.lakka.tv/RPi4.aarch64/Lakka-RPi4.aarch64-3.3.img.gz)
2. Burn the image to your mSD using any tool you like (I use balena Etcher)
3. Once completed, and before booting the mSD, replace the `distroconfig.txt` file in the LAKKA boot partition with this file: (https://raw.githubusercontent.com/duduke/piboy-dmg-lakka-test/main/distroconfig.txt)
NOTE: This step is important to get the LCD display to work.
4. Place the mSD inside the PiBoy and turn it on. It should boot a couple of times to resize the partition.
5. Once booted, you'll need to configure your WIFI network. Since, at this point the PiBoy module is not yet loaded, you'll need to plugin a keyboard to do that.
To configure LAKKA WIFI, goto **Settings -> Wi-Fi**. Or watch this: (https://www.youtube.com/watch?v=4Wr0jXKM3EY&t=4s)
6. Also enable SSH via **Settings -> Services -> SSH**
7. Once WIFI is connected and SSH is enabled. Note your IP address under **Information -> Network Information**
8. Login via SSH (root/root)
9. Create and navigate to the PiBoy DMG folder:
  * `mkdir /storage/roms/piboy-dmg`
  * `cd /storage/roms/piboy-dmg`
10. Download the PiBoy DMG kernel module: 
  * `wget https://github.com/duduke/piboy-dmg-lakka-test/raw/main/xpi_gamecon.ko`
11. Download the PiBoy DMG control script:
  * `curl "https://raw.githubusercontent.com/duduke/piboy-dmg-lakka-test/main/piboy-dmg-control.sh"`
  * `chmod +x /storage/roms/piboy-dmg/piboy-dmg-control.sh`
12. Download and install the PiBoy DMG control systemd service: 
  * `cd /storage/.config/system.d` 
  * `wget https://raw.githubusercontent.com/duduke/piboy-dmg-lakka-test/main/piboy-dmg-control.service`
  * `systemctl enable /storage/.config/system.d/piboy-dmg-control.service`
13. Get PiBoy DMG Controller profile:
  * `mkdir /storage/joypads/udev`
  * `cd /storage/joypads/udev`
  * `curl "https://raw.githubusercontent.com/duduke/piboy-dmg-lakka-test/main/PiBoy%20DMG%20Controller.cfg" --output "PiBoy DMG Controller.cfg"`
14. At this point, reboot or shutdown. The next time LAKKA will boot, everything should be working.

## Current Status

As I don't have any real programming experience, there's quite some stuff that can be imporved. but at this point those are the things that work:
1. Shutdown: `works` either within LAKKA or using the physical switch.
2. Volume control: `works`
3. Fan control: `somewhat works`, there's no actual fan curve. it ramps up to 100% when the temp is at 70c.
4. Battery status: `doesn't work`. I can't get it to show up in LAKKA, as the battery reports to a non-standard location (/sys/kernel/xpi_gamecon/percent) instead of something like /sys/class/power_supply/BAT0/.
  * The `piboy-dmg-control.sh` script will do a clean shutdown when the battery is below 5%.


I'll try to get the LAKKA maintainers to officially support PiBoy.
