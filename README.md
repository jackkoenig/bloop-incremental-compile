# bloop-incremental-compile

Test case for using bloop for compilation via `coursier launch`, but incremental compilation does not appear to be working.

### Use

```
$ ./fetch.sh
...

$ ./run.sh
+ ./coursier launch --cache cache ch.epfl.scala:bloop-frontend_2.12:1.2.5 -V ch.epfl.scala:bsp4s_2.12:2.0.0-M3 -M bloop.Cli -- run foo
Compiling foo (1 Scala source)
Compiled foo (3322ms)
Running FooMain!
The task for 'run foo' finished.
Writing .../.bloop/foo/foo-analysis.bin.

$ ./run.sh 
+ ./coursier launch --cache cache ch.epfl.scala:bloop-frontend_2.12:1.2.5 -V ch.epfl.scala:bsp4s_2.12:2.0.0-M3 -M bloop.Cli -- run foo
Compiling foo (1 Scala source)
Compiled foo (3109ms)
Running FooMain!
The task for 'run foo' finished.
Writing .../.bloop/foo/foo-analysis.bin.
```

Notes:
1. You need to override the `bsp4s` version because otherwise `coursier` reports that it can't find `bsp4s` version `2.0.0-M1` which appears to not exist/have been pulled?
2. Interestingly, if you run a normal installataion of bloop and compile `foo` with that, then run `run.sh`, it does **not** recompile.
