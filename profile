# -*- shell-script -*-
# Runtime session-configuration script for Bash.

{{set-bashconf-config-dir:.}}
{{load-bashconf-bootstrap}}
{{error-if-not-bootstrapped:no-fi}}
else
    BASHCONF_IN_PROFILE=1       # Make sure the `rc` file doesn't run
                                # `bashconf-cleanup` for us.

    if test -f "${BASHCONF_CONFIG_DIR}/rc"; then
	source "${BASHCONF_CONFIG_DIR}/rc"
    fi

    bashconf-source-parts "${BASHCONF_CONFIG_DIR}/profile.d"
    bashconf-cleanup
fi

