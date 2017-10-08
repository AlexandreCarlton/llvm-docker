IMAGE_NAME := alexandrecarlton/llvm-toolchain

LLVM_VERSION := 5.0.0
CMAKE_VERSION := 3.9.4

all: build

build:
	docker build \
		--build-arg=CMAKE_VERSION=$(CMAKE_VERSION) \
		--build-arg=LLVM_VERSION=$(LLVM_VERSION) \
		--tag=$(IMAGE_NAME) \
		.
.PHONY: build
