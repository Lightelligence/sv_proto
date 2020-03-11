#!/usr/bin/bash
./test/cross_language cross_language_socket &
sleep 2
$@
