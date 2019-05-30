# Python toolchain
Python toolchains for usage with bazel >= 0.25.0
Provides and registers python toolchains for python 2 and python 3
Packages are downloaded using https://github.com/FaBrand/debian_repository_rules


#### Python 2 toolchain
###### Version:
Python 2.7.15.rc1-1
###### Included debian packages:
From https://launchpad.net/ubuntu/cosmic/amd64/python2.7-minimal/2.7.15~rc1-1
- http://launchpadlibrarian.net/365645427/python2.7-minimal_2.7.15~rc1-1_amd64.deb

From https://launchpad.net/ubuntu/bionic/amd64/libpython2.7-minimal
- http://launchpadlibrarian.net/412143380/libpython2.7-minimal_2.7.15-4ubuntu4~18.04_amd64.deb

From https://launchpad.net/ubuntu/bionic/amd64/libpython2.7-stdlib
- http://launchpadlibrarian.net/412143382/libpython2.7-stdlib_2.7.15-4ubuntu4~18.04_amd64.deb

#### Python 3 toolchain
###### Version:
Python 3.7.1-1
###### Included debian packages:
From https://launchpad.net/ubuntu/bionic/amd64/python3.7-minimal/3.7.1-1~18.04
- http://launchpadlibrarian.net/394585029/python3.7-minimal_3.7.1-1~18.04_amd64.deb

From https://launchpad.net/ubuntu/bionic/amd64/libpython3.7-minimal/3.7.1-1~18.04
- http://launchpadlibrarian.net/394585020/libpython3.7-minimal_3.7.1-1~18.04_amd64.deb

From https://launchpad.net/ubuntu/bionic/amd64/libpython3.7-stdlib/3.7.0~a2-1
- http://launchpadlibrarian.net/341324234/libpython3.7-stdlib_3.7.0~a2-1_amd64.deb


#### Usage example:
```python
# WORKSPACE
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "debian_repository_rules",
    branch = "master",
    remote = "https://github.com/fabrand/debian_repository_rules",
)

load("@debian_repository_rules//:debian.bzl", "debian_archive")

git_repository(
    name = "com_fabrand_python_runtimes",
    branch = "master",
    remote = "https://github.com/FaBrand/bazel-python-toolchain.git",
)

load("@com_fabrand_python_runtimes//:python_runtimes.bzl", "setup_python_workspace")

setup_python_workspace()
```

-------------------------------------------------------------------------

Currently only works for linux


#### Known Problems:

libc6 is still loaded from the host system and may fail.
I encountered this with python3 tests failing on travis ci which uses ubuntu 16 which has version 2.23 installed by default.
Python3.7 requires atleast version 2.25 and fails with:
```bash
==================== Test output for //test:python3_test:
/home/travis/.cache/bazel/_bazel_travis/094c46a7897403427a68fa2c7ef9be9c/sandbox/linux-sandbox/2/execroot/com_fabrand_python_runtimes/bazel-out/k8-fastbuild/bin/test/python3_test.runfiles/python3/usr/bin/python3.7: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.25' not found (required by /home/travis/.cache/bazel/_bazel_travis/094c46a7897403427a68fa2c7ef9be9c/sandbox/linux-sandbox/2/execroot/com_fabrand_python_runtimes/bazel-out/k8-fastbuild/bin/test/python3_test.runfiles/python3/usr/bin/python3.7)
/home/travis/.cache/bazel/_bazel_travis/094c46a7897403427a68fa2c7ef9be9c/sandbox/linux-sandbox/2/execroot/com_fabrand_python_runtimes/bazel-out/k8-fastbuild/bin/test/python3_test.runfiles/python3/usr/bin/python3.7: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.26' not found (required by /home/travis/.cache/bazel/_bazel_travis/094c46a7897403427a68fa2c7ef9be9c/sandbox/linux-sandbox/2/execroot/com_fabrand_python_runtimes/bazel-out/k8-fastbuild/bin/test/python3_test.runfiles/python3/usr/bin/python3.7)
================================================================================
```
