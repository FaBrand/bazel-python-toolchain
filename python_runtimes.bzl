load("@bazel_tools//tools/python:toolchain.bzl", "py_runtime_pair")

_DEFAULT_BUILD_FILE_TEMPLATE = """package(default_visibility = ["//visibility:public"])

py_runtime(
    name = "{name}",
    files = ["python"],
    interpreter = "python",
    python_version = "{python_version}",
)
"""

def _get_number_of_cores(ctx):
    nproc = ctx.which("nproc")
    if not nproc:
        fail("nproc not found")
    output = ctx.execute([nproc])
    return output.stdout

def _python_source_impl(ctx):
    loaded = ctx.download_and_extract(
        url = [ctx.attr.url],
        output = "",
        sha256 = ctx.attr.sha256,
        stripPrefix = ctx.attr.strip_prefix,
    )

    quiet = False
    if not loaded:
        fail("Download of {} failed".format(ctx.attr.url))

    make = ctx.which("make")
    if not make:
        fail("make not found")

    ctx.report_progress("Configuring " + ctx.name)
    configure_python = ctx.execute(
        ["./configure"],
        quiet = quiet,
    )
    if not configure_python:
        fail("Configure step failed")

    ctx.report_progress("Building " + ctx.name)
    make_succeeded = ctx.execute(
        [make],
        quiet = quiet,
    )

    if not make_succeeded:
        fail("Make failed")

    build_file_content = _DEFAULT_BUILD_FILE_TEMPLATE.format(
        name = ctx.name,
        python_version = ctx.attr.python_version,
    )

    ctx.file("BUILD.bazel", build_file_content)
    ctx.file("WORKSPACE", "")

_python_source = repository_rule(
    attrs = {
        "sha256": attr.string(default = ""),
        "url": attr.string(default = ""),
        "strip_prefix": attr.string(default = ""),
        "runtime": attr.string(default = ""),
        "python_version": attr.string(default = ""),
    },
    local = False,
    implementation = _python_source_impl,
)

def setup_python_workspace():
    _python_source(
        name = "python3",
        python_version = "PY3",
        strip_prefix = "Python-3.7.3",
        url = "https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz",
        visibility = ["//visibility:public"],
    )

    _python_source(
        name = "python2",
        python_version = "PY2",
        strip_prefix = "Python-2.7.14",
        url = "https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz",
        visibility = ["//visibility:public"],
    )

    native.register_toolchains(":python_toolchain")

def setup_python_targets():
    py_runtime_pair(
        name = "py_runtime_pair",
        py2_runtime = "@python2",
        py3_runtime = "@python3",
        visibility = ["//visibility:public"],
    )

    native.toolchain(
        name = "python_toolchain",
        toolchain = ":py_runtime_pair",
        toolchain_type = "@bazel_tools//tools/python:toolchain_type",
        visibility = ["//visibility:public"],
    )
