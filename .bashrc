# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

qc() {
    cat "$1" | xclip -selection clipboard
}


#nohup ~/bin/brave_snapshot.sh > ~/session_snapshots/snapshot_log.out 2>&1 &

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export MAKEOPTS="-j7 -l6"
export MAKEFLAGS="-j7 -l6"
export TRICK_CFLAGS="-g -Wall -O2 -pipe -fasynchronous-unwind-tables"
export TRICK_CXXFLAGS="-g -Wall -O2 -pipe -fasynchronous-unwind-tables"
export CFLAGS="-g -Wall -O2 -pipe -fasynchronous-unwind-tables"
export CXXFLAGS="-g -Wall -O2 -pipe -fasynchronous-unwind-tables"
export LD_LIBRARY_PATH=/usr/local/cuda-12.9/lib64:$LD_LIBRARY_PATH

export REPOS_HOME="$HOME/repos"
export TRICK_HOME="$REPOS_HOME/trick"
export JEOD_HOME="$REPOS_HOME/jeod"
export KOVIZ_HOME="$REPOS_HOME/koviz"
export KOVIZ_HOME="$REPOS_HOME/koviz"
export SIM_AGENT_HOME="$REPOS_HOME/nasa_simulation_agents"

PATH="$KOVIZ_HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application"
export PATH="/usr/local/cuda-12.9/bin:$PATH"
#export PATH

# Strip ALL /mnt/c and /mnt/d entries from PATH
export PATH=$(echo "$PATH" | tr ':' '\n' | grep -vE '^/mnt/(c|d)/' | paste -sd:)
# Remove duplicate entries in PATH
export PATH=$(echo "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | paste -sd:)

# Optionally export LS_OPTIONS and load dircolors (safe defaults)
export LS_OPTIONS='--color=auto'
eval "$(dircolors ~/.dircolors)"

source ~/.alias_sw
