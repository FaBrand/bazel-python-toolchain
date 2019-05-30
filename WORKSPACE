load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

workspace(name = "com_fabrand_python_runtimes")

git_repository(
    name = "debian_repository_rules",
    branch = "master",
    remote = "https://github.com/fabrand/debian_repository_rules",
)

load("@com_fabrand_python_runtimes//:python_runtimes.bzl", "setup_python_workspace")

setup_python_workspace()
