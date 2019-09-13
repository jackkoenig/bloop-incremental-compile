# bloop-incremental-compile

Test case for using bloop without the server via bloop.Cli main

### Requirements

This repo requires [jq](https://stedolan.github.io/jq/), git, java8, wget, and bash.

### Use

```
$ ./script.sh
```

This will run bloop 1.3.2 three times as a command-line utility via bloop.Cli.

1. Full compile
2. Apply minor patch and incrementally recompile
3. Undo the patch and incrementally recompile again

On compilation 3, Bloop (or Zinc) fails seemingly due to some issue with
incremental compilation.

### Set Bloop Version

You can set the version of bloop via the `BLOOP_VERSION` environment variable.
The default value is `1.3.2`

```
$ BLOOP_VERSION=1.3.0 ./script.sh
```

This works with locally published versions.
For example, if you clone the Bloop repo and check out commit `dd7c8f2cf4f45700b3e324190cf622d7834d1167`, you can publish locally with `sbt publishLocal`

Then you can run this script with that version:

```
$ BLOOP_VERSION=1.3.2+145-dd7c8f2c ./script.sh
```
