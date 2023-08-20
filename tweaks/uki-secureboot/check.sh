#!/bin/sh

basedir=$(dirname $0)

function checkDep() {
    pacman -Q $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo '[OK]'
    else
        echo '[FAIL]'
    fi
}

echo '== Checking for Secure Boot Unified kernel image config =='
echo

echo '- Dependencies:'
while IFS= read -r dep || [ -n "$dep" ]; do
    case "$dep" in
        \#*) continue ;;
        *)
            echo -n "    - $dep"
            checkDep "$dep"
    esac
done < "$basedir/deps.list"

echo -n '- Kernel cmdline defined: '
if [ -s /etc/kernel/cmdline ]; then
    echo '[OK]'
else
    echo '[FAIL]'
fi

