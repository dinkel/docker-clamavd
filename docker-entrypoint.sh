#!/bin/bash
set -m

freshclam -d &
clamd &

pids=`jobs -p`

exitcode=0

function terminate() {
    trap "" CHLD SIGTERM SIGQUIT SIGINT

    for pid in $pids; do
        if ! kill -0 $pid 2>/dev/null; then
            wait $pid
            exitcode=$?
        fi
    done

    kill $pids 2>/dev/null
}

trap terminate CHLD SIGTERM SIGQUIT SIGINT
wait

exit $exitcode
