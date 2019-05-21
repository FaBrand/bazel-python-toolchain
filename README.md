### Python toolchain

This is a (probably impractical) attempt to create a python toolchain.
It downloads the python sources and uses the hosts configuration to execute
the basic build commands to build python from source. (see [python docs](https://docs.python.org/3/using/unix.html#building-python))
```bash
./configure
./make
```

After that the built interpreter is set as the python toolchain and can be tested with 

```bash
bazel test //test/...
```

###### Currently only works for linux
