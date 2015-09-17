#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.eject2controlshifteject 1
/bin/echo -n .
$cli set repeat.wait 23
/bin/echo -n .
$cli set repeat.initial_wait 200
/bin/echo -n .
$cli set option_r_to_tilde 1
/bin/echo -n .
$cli set repeat.consumer_initial_wait 100
/bin/echo -n .
$cli set command_r_to_underscore 1
/bin/echo -n .
$cli set repeat.consumer_wait 43
/bin/echo -n .
$cli set remap.shiftparens 1
/bin/echo -n .
$cli set remap.programmer.shifts_parens 1
/bin/echo -n .
/bin/echo
