#!/user/bin/env bash
# ------------------------------
# yay configs
# ------------------------------

mkdir -p ~/.config/yay
echo '{
"aururl": "https://aur.archlinux.org",
"builddir": "/tmp",
"editor": "nano",
"sudobin": "/usr/bin/sudo",
"maxthreads": 1,
"timeout": 600
}' | tee ~/.config/yay/config.json

export YAY_TIMEOUT=600
yay -Syu
