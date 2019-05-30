load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "debian_repository_rules",
    branch = "master",
    remote = "https://github.com/fabrand/debian_repository_rules",
)

load(":python_runtimes.bzl", "setup_python_workspace")

setup_python_workspace()
