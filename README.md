# bloop-incremental-compile

Test case for using bloop without the server via bloop.Cli main

### Use

```
$ ./script.sh
```

This will run bloop 1.3.0-RC1 3 times as a command-line utility via bloop.Cli.

1. Full compile
2. Apply minor patch and incrementally recompile
3. Undo the patch and incrementally recompile again

On compilation 3, Bloop (or Zinc) fails seemingly due to some issue with
incremental compilation.

You can modify the script.sh to run with bloop 1.2.5 (see comments) which will
pass because incremental compilation doesn't work at all.

