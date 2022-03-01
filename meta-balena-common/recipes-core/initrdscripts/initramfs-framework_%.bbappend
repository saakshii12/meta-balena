FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://prepare \
    file://fsck \
    file://fsuuidsinit \
    file://machineid \
    file://resindataexpander \
    file://rorootfs \
    file://rootfs \
    file://finish \
    file://cryptsetup \
    file://kexec \
    file://udevcleanup \
    "

do_install:append() {
    install -m 0755 ${WORKDIR}/prepare ${D}/init.d/70-prepare
    install -m 0755 ${WORKDIR}/fsuuidsinit ${D}/init.d/75-fsuuidsinit
    install -m 0755 ${WORKDIR}/fsck ${D}/init.d/87-fsck
    install -m 0755 ${WORKDIR}/rootfs ${D}/init.d/90-rootfs
    install -m 0755 ${WORKDIR}/finish ${D}/init.d/99-finish

    install -m 0755 ${WORKDIR}/machineid ${D}/init.d/91-machineid
    install -m 0755 ${WORKDIR}/resindataexpander ${D}/init.d/88-resindataexpander
    install -m 0755 ${WORKDIR}/rorootfs ${D}/init.d/89-rorootfs
    install -m 0755 ${WORKDIR}/udevcleanup ${D}/init.d/98-udevcleanup
    install -m 0755 ${WORKDIR}/cryptsetup ${D}/init.d/72-cryptsetup
    install -m 0755 ${WORKDIR}/kexec ${D}/init.d/92-kexec
}

PACKAGES:append = " \
    initramfs-module-fsck \
    initramfs-module-machineid \
    initramfs-module-resindataexpander \
    initramfs-module-rorootfs \
    initramfs-module-prepare \
    initramfs-module-fsuuidsinit \
    initramfs-module-cryptsetup \
    initramfs-module-kexec \
    initramfs-module-udevcleanup \
    "

RRECOMMENDS:${PN}-base += "initramfs-module-rootfs"

SUMMARY:initramfs-module-fsck = "Filesystem check for partitions"
RDEPENDS:initramfs-module-fsck = "${PN}-base e2fsprogs-e2fsck dosfstools-fsck"
FILES:initramfs-module-fsck = "/init.d/87-fsck"

SUMMARY:initramfs-module-machineid = "Bind mount machine-id to rootfs"
RDEPENDS:initramfs-module-machineid = "${PN}-base initramfs-module-udev"
FILES:initramfs-module-machineid = "/init.d/91-machineid"

SUMMARY:initramfs-module-resindataexpander = "Expand the data partition to the end of device"
RDEPENDS:initramfs-module-resindataexpander = "${PN}-base initramfs-module-udev busybox parted util-linux-lsblk e2fsprogs-resize2fs"
FILES:initramfs-module-resindataexpander = "/init.d/88-resindataexpander"

SUMMARY:initramfs-module-rorootfs = "Mount our rootfs"
RDEPENDS:initramfs-module-rorootfs = "${PN}-base"
FILES:initramfs-module-rorootfs = "/init.d/89-rorootfs"

SUMMARY:initramfs-module-rootfs = "initramfs support for locating and mounting the root partition"
RDEPENDS:initramfs-module-rootfs = "${PN}-base"
FILES:initramfs-module-rootfs = "/init.d/90-rootfs"

SUMMARY:initramfs-module-prepare = "Prepare initramfs console"
RDEPENDS:initramfs-module-prepare = "${PN}-base os-helpers-logging os-helpers-fs"
FILES:initramfs-module-prepare = "/init.d/70-prepare"

SUMMARY:initramfs-module-fsuuidsinit = "Regenerate default filesystem UUIDs"
RDEPENDS:initramfs-module-fsuuidsinit = "${PN}-base"
FILES:initramfs-module-fsuuidsinit = "/init.d/75-fsuuidsinit"

SUMMARY:initramfs-module-cryptsetup = "Unlock encrypted partitions"
RDEPENDS:initramfs-module-cryptsetup = "${PN}-base cryptsetup lvm2-udevrules os-helpers-logging os-helpers-fs os-helpers-tpm2"
FILES:initramfs-module-cryptsetup = "/init.d/72-cryptsetup"

SUMMARY:initramfs-module-kexec = "Find and start a new kernel if in stage2"
RDEPENDS:initramfs-module-kexec = " \
    kexec-tools \
    util-linux-findmnt \
    "
FILES:initramfs-module-kexec = "/init.d/92-kexec"

SUMMARY:initramfs-module-udevcleanaup = "Cleanup the udev database before transitioning to the rootfs"
RDEPENDS:initramfs-module-udevcleanaup = "${PN}-base"
FILES:initramfs-module-udevcleanup = "/init.d/98-udevcleanup"
