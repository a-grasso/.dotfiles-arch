IgnorePath '/var/lib/pacman/local/*'
IgnorePath '/var/lib/pacman/sync/*.db'
IgnorePath '/var/lib/pacman/sync/*.db.sig'
IgnorePath '/var/*'
IgnorePath '/boot/*'
IgnorePath '/usr/lib/*'

white_list_etc=(
    'lightdm/lightdm.conf'
)
IgnorePathsExcept /etc/ "${white_list_etc[@]}"
