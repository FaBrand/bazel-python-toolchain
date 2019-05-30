load("@bazel_tools//tools/python:toolchain.bzl", "py_runtime_pair")
load("@debian_repository_rules//:debian.bzl", "debian_archive")

def setup_python_workspace():
    debian_archive(
        name = "python3",
        build_file_content = """py_runtime(
        name = "runtime",
        files = glob(["usr/lib/**/*"]),
        interpreter = "usr/bin/python3.7",
        python_version = "PY3",
        visibility = ["//visibility:public"],
    )""",
        urls = {
            "http://launchpadlibrarian.net/394585029/python3.7-minimal_3.7.1-1~18.04_amd64.deb": "4ddc47a919f35d938e526f6e29722e6f50eaf56d8fc8b80d6be4cdd9b8f26e54",
            "http://launchpadlibrarian.net/394585020/libpython3.7-minimal_3.7.1-1~18.04_amd64.deb": "38a61fb89e87c9fc904a1693809921bed0735e2e467a8daaa9bd5381e3e3b848",
            "http://launchpadlibrarian.net/341324234/libpython3.7-stdlib_3.7.0~a2-1_amd64.deb": "c1bb1baeb1827354c18eb4619fbc08cfe32b5ac2ea2449ae7dccb041d9733c16",
            "http://launchpadlibrarian.net/365856922/libc6_2.27-3ubuntu1_amd64.deb": "1e1eb86fd646aa68f7144ec692b837b6b352d215880c6a2d0c92c19d36938427",
            "http://launchpadlibrarian.net/400343104/libssl1.1_1.1.0g-2ubuntu4.3_amd64.deb": "336c4c6875f647a1e96fdda6bbb47c6bb56dbed0d30c73838fb0fb1890ef6ab6",
        },
    )

    debian_archive(
        name = "python2",
        build_file_content = """py_runtime(
        name = "runtime",
        files = glob(["usr/lib/**/*"]),
        interpreter = "usr/bin/python2.7",
        python_version = "PY2",
        visibility = ["//visibility:public"],
    )""",
        urls = {
            "http://launchpadlibrarian.net/365645427/python2.7-minimal_2.7.15~rc1-1_amd64.deb": "018cf986dbd030a175bfc27cda1a98416a713d247abf5696e528314e8cfb948d",
            "http://launchpadlibrarian.net/412143380/libpython2.7-minimal_2.7.15-4ubuntu4~18.04_amd64.deb": "32861db45d9af6b5db8378ddbbc767dd9a7ff1274915def9ba44dab360bba352",
            "http://launchpadlibrarian.net/412143382/libpython2.7-stdlib_2.7.15-4ubuntu4~18.04_amd64.deb": "9eec69d84e3b04e4bc965346c43aaba2bcd36cfdd3133f8540ee535c59421af8",
        },
    )

    native.register_toolchains("@com_fabrand_python_runtimes//:python_toolchain")

def setup_python_targets():
    py_runtime_pair(
        name = "py_runtime_pair",
        py2_runtime = "@python2//:runtime",
        py3_runtime = "@python3//:runtime",
        visibility = ["//visibility:public"],
    )

    native.toolchain(
        name = "python_toolchain",
        toolchain = "@com_fabrand_python_runtimes//:py_runtime_pair",
        toolchain_type = "@bazel_tools//tools/python:toolchain_type",
        visibility = ["//visibility:public"],
    )
