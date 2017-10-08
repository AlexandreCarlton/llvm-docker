FROM centos:7

RUN yum install -y \
      cmake \
      curl \
      libedit2-devel \
      libxml2-devel \
      ncurses-devel \
      python-devel \
      swig \
      @"Development Tools" \
    && yum clean all

ARG CMAKE_VERSION
WORKDIR /cmake
RUN curl "https://cmake.org/files/v$(echo "$CMAKE_VERSION" | cut -d. -f1-2 )/cmake-$CMAKE_VERSION.tar.gz" \
    | tar --extract --gzip --strip-components=1 \
    && cmake . \
    && make \
    && make install \
    && rm -rf /cmake

ARG LLVM_VERSION
WORKDIR /llvm
RUN curl -L "https://releases.llvm.org/$LLVM_VERSION/llvm-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 \
    \
    && mkdir -p projects/compiler-rt \
    && curl -L "https://releases.llvm.org/$LLVM_VERSION/compiler-rt-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 --directory=projects/compiler-rt \
    \
    && mkdir -p projects/libcxx \
    && curl -L "https://releases.llvm.org/$LLVM_VERSION/libcxx-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 --directory=projects/libcxx \
    \
    && mkdir -p projects/libcxxabi \
    && curl -L "https://releases.llvm.org/$LLVM_VERSION/libcxxabi-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 --directory=projects/libcxxabi \
    \
    && mkdir -p projects/libunwind \
    && curl -L "https://releases.llvm.org/$LLVM_VERSION/libunwind-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 --directory=projects/libunwind \
    \
    && mkdir -p tools/clang \
    && curl -L "https://releases.llvm.org/$LLVM_VERSION/cfe-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 --directory=tools/clang \
    \
    && mkdir -p tools/clang/tools/extra \
    && curl -L "https://releases.llvm.org/$LLVM_VERSION/clang-tools-extra-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 --directory=tools/clang/tools/extra \
    \
    && mkdir -p tools/lld \
    && curl -L "https://releases.llvm.org/$LLVM_VERSION/lld-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 --directory=tools/lld \
    \
    && mkdir -p tools/lldb \
    && curl -L "https://releases.llvm.org/$LLVM_VERSION/lldb-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 --directory=tools/lldb \
    \
    && mkdir -p tools/polly \
    && curl -L "https://releases.llvm.org/$LLVM_VERSION/polly-$LLVM_VERSION.src.tar.xz" \
    | tar --extract --xz --strip-components=1 --directory=tools/polly \
    \
    && mkdir -p build \
    && cd build \
    && cmake \
        -D CMAKE_BUILD_TYPE=Release \
        -D LLVM_ENABLE_CXX=ON \
        .. \
    && make \
    && make install \
    && rm -rf /llvm

WORKDIR /
