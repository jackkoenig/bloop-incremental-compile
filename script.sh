#!/usr/bin/env bash

if [ -z "$BLOOP_VERSION" ]; then
  BLOOP_VERSION=1.3.2
fi

echo "Running with Bloop version $BLOOP_VERSION"

BLOOP_DIR=bloop-$BLOOP_VERSION

mkdir -p $BLOOP_DIR

if [ ! -f coursier ]; then
  wget http://central.maven.org/maven2/io/get-coursier/coursier-cli_2.12/1.1.0-M14-6/coursier-cli_2.12-1.1.0-M14-6-standalone.jar
  mv coursier-cli_2.12-1.1.0-M14-6-standalone.jar coursier
  chmod +x coursier
fi

if [ ! -d firrtl ]; then
  git clone git@github.com:freechipsproject/firrtl.git
  git -C firrtl checkout 7106baffb4fd2bd5a7d3f3c18afe8adf38f53eb2
  git -C firrtl apply ../add-plugin.diff
  cd firrtl && sbt bloopInstall && cd ..
fi

# Fixup so we can have multiple versions building
jq ".project.out |= \"$BLOOP_DIR/firrtl\" | .project.classesDir |= \"$BLOOP_DIR/firrtl/scala-2.12/classes\"" < firrtl/.bloop/firrtl.json > $BLOOP_DIR/firrtl.json

# The following works but has no incremental compilation
# ch.epfl.scala::bloop-frontend:1.2.5 ch.epfl.scala::bsp4s:2.0.0-M3
CP=$(./coursier fetch --classpath --cache ivycache ch.epfl.scala::bloop-frontend:$BLOOP_VERSION)

rm -rf $BLOOP_DIR/firrtl
java -cp $CP bloop.Cli compile -c $BLOOP_DIR firrtl
git -C firrtl apply ../patch.diff
java -cp $CP bloop.Cli compile -c $BLOOP_DIR firrtl
git -C firrtl checkout src/main/scala/firrtl/Driver.scala
java -cp $CP bloop.Cli compile -c $BLOOP_DIR firrtl
