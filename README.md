# Bashconf: Modular and Manageable Bash Configuration

Fed up with the long and unmaintainable mess that was my `.bashrc`, I set out
to make something better.  This is the result.


## Model

Each of the standard Bash configuration files (`.profile`, `.bashrc`, and
`.logout`) in the user's home directory is symlinked to a corresponding script
(`profile`, `rc`, or `logout`) in the Bashconf directory (which is assumed to
be `${XDG_CONFIG_HOME}/bash`).

These scripts load the Bashconf utility functions, then use those to source the
scripts in their respective `.d` directories (`profile.d`, `rc.d`, and
`logout.d`) in the Bashconf directory.


## Other interesting tidbits

The files in [lib/helpers](lib/helpers) contain some interesting shell
functions.

  * If you've ever wanted to reload (or just unload) a certain kernel module
    that sits at the root of a dependency tree, you know how *fun* it is to
    first manually remove each and every one of the modules that depend on it.

    [lib/helpers/kernel](lib/helpers/kernel)'s main attraction is
    `mod-recursive-rdepends`, which recursively lists a kernel module's reverse
    dependencies (and the module itself) in the order needed to remove that
    module:

        sudo rmmod `mod-recursive-rdepends soundcore` 

  * [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html) supports
    various operations like window-(de)iconification, title-setting, and
    font-setting via escape codes.

    [lib/helpers/rxvt](lib/helpers/rxvt) defines some shell functions that make
    these operations easily accessible.  It also changes the font, and will
    sometimes change your terminal type (`TERM`) to `rxvt-unicode`.


## Caveats

*Don't* blindly use my configuration without inspecting what it does!
It's public primarily for my own convenience; the fact that others might find
it interesting or useful is very much coincidental, and there are likely
several gremlins just waiting to ruin your day.

Of note is [aliases.d/make](aliases.d/make), which will rudely expose those
Make-based build systems that depend on rules and definitions in Make's
built-in database.


## Known Issues

  *  These scripts may not be portable to non-GNU systems or those with ancient
    (< 2.9) versions of Bash.  I really don't know.

  * Daemon scripts implementations (all two of them) are lacking: the ssh-agent
    script will happily kill the user's sole ssh-agent instance on logout ---
    even if the same user is logged in on another TTY --- while the dbus script
    implements only start functionality.


## Author

Bashconf was written by Collin J. Sutton.


## License

All files may be distributed under the terms of the Apache License version 2.0.
See file [LICENSE](LICENSE) for details.
