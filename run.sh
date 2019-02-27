#!/usr/bin/env bash
set -x
./coursier launch --cache cache ch.epfl.scala:bloop-frontend_2.12:1.2.5 -V ch.epfl.scala:bsp4s_2.12:2.0.0-M3 -M bloop.Cli -- run foo
