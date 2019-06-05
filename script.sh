#!/usr/bin/env bash

if [ ! -f coursier ]; then
  wget http://central.maven.org/maven2/io/get-coursier/coursier-cli_2.12/1.1.0-M14-6/coursier-cli_2.12-1.1.0-M14-6-standalone.jar
  mv coursier-cli_2.12-1.1.0-M14-6-standalone.jar coursier
  chmod +x coursier
fi

if [ ! -d firrtl ]; then
  git clone git@github.com:freechipsproject/firrtl.git
  git -C firrtl apply ../add-plugin.diff
  cd firrtl && sbt bloopInstall && cd ..
fi

# The following works but has no incremental compilation
# ch.epfl.scala::bloop-frontend:1.2.5 ch.epfl.scala::bsp4s:2.0.0-M3
CP=$(./coursier fetch --classpath --cache ivycache ch.epfl.scala::bloop-frontend:1.3.0-RC1)

rm -rf firrtl/.bloop/firrtl
java -cp $CP bloop.Cli compile -c firrtl/.bloop firrtl
git -C firrtl apply ../patch.diff
java -cp $CP bloop.Cli compile -c firrtl/.bloop firrtl
git -C firrtl checkout src/main/scala/firrtl/Driver.scala
java -cp $CP bloop.Cli compile -c firrtl/.bloop firrtl
