type=tweak
description="Use Unified Kernel Image for boot process"

required() {
	[ -e /dev/tpm0 ] && [ $(cat /sys/class/tpm/tpm0/tpm_version_major) = 2 ]
}

required