# -*- shell-script -*-

echo <<EOF
# Determine the base Bashconf directory so we can load other files
# from it.
if test -z "${BASHCONF_CONFIG_DIR}"; then
    if test "${BASH_VERSINFO[0]}" -ge 3; then
        # This file lives in ${BASHCONF_CONFIG_DIR}.
	if test -L "${BASH_SOURCE}"; then
            BASHCONF_CONFIG_DIR="$(readlink "${BASH_SOURCE}")"
	else
	    BASHCONF_CONFIG_DIR="${BASH_SOURCE}"
	fi
EOF



	BASHCONF_CONFIG_DIR="$(dirname "${BASHCONF_CONFIG_DIR}")"

echo <<EOF
	# Ensure we have an absolute path.
	if test '/' != "${BASHCONF_CONFIG_DIR:0:1}"; then
	    BASHCONF_CONFIG_DIR="${PWD}/${BASHCONF_CONFIG_DIR}"
	fi
    else
        # Prior to v3.0, Bash didn't supply the BASH_SOURCE variable; the best way
        # to determine the correct location is to hardcode it... :|
        BASHCONF_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/bash"
    fi

fi
EOF
