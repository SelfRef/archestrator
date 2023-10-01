type=tweak
description="Use Unified Kernel Image for boot process"

required() {
	if [ -e /sys/firmware/efi/fw_platform_size ]; then
		echo "[OK] EFI detected, $(cat /sys/firmware/efi/fw_platform_size) bit"
	else
		echo "[FAIL] EFI not detected"
		return 1
	fi

	boot_current_id=$(efivar -l | grep BootCurrent)
	boot_current=$(efivar -n $boot_current_id -d | cut -d ' ' -f 1)
	boot_id=$(efivar -l | grep -- -Boot000$boot_current)
	boot_name=$(efivar -n $boot_id -d)
	boot=$(for i in $boot_name; do printf \\$(printf "%o" $i); done)

	if [ "${boot:2:18}" = "Linux Boot Manager" ]; then
		echo "[OK] Current boot method is systemd-boot"
	else
		echo "[FAIL] Current boot method is NOT systemd-boot"
		return 1
	fi
}

check() {

}

required