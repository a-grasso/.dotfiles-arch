function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

setxkbmap &
keybLayout=$(setxkbmap -v | awk -F "+" '/symbols/ {print $2}')

run sxhkd -c ~/.config/sxhkd/sxhkdrc &

nitrogen --restore &
picom &

$HOME/.config/polybar/launch.sh &

