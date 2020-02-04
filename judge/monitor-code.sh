#!/bin/sh

inotifywait -mr -e modify --format '%T %w%f' --timefmt '%s' --exclude \.# /codes-d /codes-nim /codes-crystal | ./runoj.py
