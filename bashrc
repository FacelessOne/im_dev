# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /usr/local/etc/bash_log_fns ]; then
    . /usr/local/etc/bash_log_fns
fi

virtualenv_desc() {
    if [[ -n "$K_VIRTUAL_ENV_DESCRIPTOR" ]]; then
	echo "⭠ $K_VIRTUAL_ENV_DESCRIPTOR"
    fi
}

# User specific aliases and functions
# Source file to update Promptline displays
source ~/depot/ian.muir/promptline.conf

# Alias use
alias use="source $HOME/depot/ian.muir/bin/use"

# Alias for ack
alias pack="ack --php"
alias jack="ack --js"
alias tools='$K_HTTPD_HEADEND_SOURCE_ROOT/store/tools/store_util.sh'

# Alias for Store Database versions
alias storedb-prod="/usr/bin/psql -h storedb.kaleidescape.com -U ian.muir_ro rdbms-store"
alias storedb-qa="/usr/bin/psql -h qastoredb -U storedb_owner rdbms-store-main"
alias storedb-qa-patch="/usr/bin/psql -h qastoredb -U storedb_owner rdbms-store-patch"

# Test Alias
alias test="phpunit"

# CodeReviewer Aliases
alias newreview="ccollab addchangelist new"
alias addtoreview="ccollab addchangelist ask"

# TMUX Base Sessions
alias tmux-code="tmux attach -t code"
alias tmux-bash="tmux attach -t bash"

alias ll='ls -all'

# #########################
# Growl Notification Alias
growlnotify() { echo -e $'\e]9;'${1}'\007' ; return ; }

# ########################
# Make Override to use Notifications
mk() { 
make $@ ; 

RETVAL=$?
if [ $RETVAL -eq 0 ]; then
    growlnotify "make ${1} complete" ; 
else
    growlnotify "make ${1} failed" ;
fi

return ; }

# ############################################ #
# Starting scripts after everything is set-up  #
# ############################################ #

# Store SSH Connection of log in to temp file
echo $SSH_CONNECTION > ~/tmp/SSH_CONNECTION

# Source store dev_env.sh file from store/main
# echo "----- Starting in store/main -----"
# use main

P4CLIENT='ian.muir_headend';
export P4CLIENT
