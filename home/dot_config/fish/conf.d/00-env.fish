set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share

set -gx KUBE_EDITOR vim
set -gx VISUAL vim
set -gx EDITOR vim

fish_add_path --global --prepend $HOME/.local/bin