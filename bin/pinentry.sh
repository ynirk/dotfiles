#!/bin/sh
# Choose pinentry program based on OS
# based on $PINENTRY_USER_DATA value

set -Ceu

case "${PINENTRY_USER_DATA-}" in
*Linux*)
	exec pinentry "$@"
	;;
esac

exec pinentry-mac "$@"
