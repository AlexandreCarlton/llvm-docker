# llvm-docker

[![Build Status](https://travis-ci.org/AlexandreCarlton/llvm-docker.svg?branch=master)](https://travis-ci.org/AlexandreCarlton/llvm-docker)

Packages the `LLVM` toolchain in a CentOS 7 Docker image. It contains:

 - [`clang`](https://clang.llvm.org)
 - [`clang-tools-extra`](https://clang.llvm.org/extra)
 - [`compiler-rt`](https://compiler-rt.llvm.org)
 - [`libcxx`](https://libcxx.llvm.org)
 - [`libcxx-abi`](https://libcxx-abi.llvm.org)
 - [`libunwind`](https://libunwind.llvm.org)
 - [`lld`](https://lld.llvm.org)
 - [`lldb`](https://lldb.llvm.org)
 - [`polly`](https://polly.llvm.org)

Can be used to form the parent image of [`ycmd-docker`](https://github.com/AlexandreCarlton/ycmd-docker).
