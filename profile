# -*- shell-script -*-
# Runtime session-configuration script for BASh.

# Source the configuration-bootstrap script if necessary.  We expect it to be
# in the same directory as the current file.
if test -z "${BASHCONF_CONFIG_DIR}"; then
    if test "${BASH_VERSINFO[0]}" -ge 3; then
        BASHCONF_CONFIG_DIR="$(readlink -f ${BASH_SOURCE})"
        BASHCONF_CONFIG_DIR="${BASHCONF_CONFIG_DIR%/*}"
    else
        # Prior to v3.0, Bash didn't supply the BASH_SOURCE variable; the best way
        # to determine the correct location is to hardcode it... :|
        BASHCONF_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/bash"
    fi

    if test -z "${BASHCONF_HAVE_CONFIG}"; then
        source "${BASHCONF_CONFIG_DIR}/lib/bootstrap"
    fi
fi

if test -z "${BASHCONF_HAVE_CONFIG}"; then
    echo '*** ERROR: Failed to load BASh configuration variables.' \
	> /dev/stderr
else
    BASHCONF_IN_PROFILE=1       # Make sure the `rc` file doesn't run
                                # `bashconf-cleanup` for us.

    if test -f "${BASHCONF_CONFIG_DIR}/rc"; then
	source "${BASHCONF_CONFIG_DIR}/rc"
    fi

    bashconf-source-parts "${BASHCONF_CONFIG_DIR}/profile.d"
    bashconf-cleanup
fi

