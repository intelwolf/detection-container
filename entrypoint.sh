#!/bin/sh

set -e

/usr/sbin/httpd -k start

if [ -t 0 ] ; then
    echo "(starting interactive shell)"
    # Correct working directory
    cd /home/eval/

    # Start menu
    ../menu/run
else
    echo "(starting non-interactive shell)"
    cd /home/eval

    # Start automatic run
    ../menu/auto
fi
