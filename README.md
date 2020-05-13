# GSLinux
GSLinux Overlay (Gentoo and Source-based Linux Professional Audio Workstation)

To add this overlay in the our Gentoo based system make file gslinux.conf in /etc/portage/repos.conf folder

[gslinux]

location = /var/db/repos/gslinux

sync-type = git

sync-uri = https://github.com/gslinux-overlay/gslinux.git

priority = 50

auto-sync = Yes
