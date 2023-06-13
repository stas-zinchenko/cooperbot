.DEFAULT_GOAL := help
SHELL := /bin/bash

APP := cooperbot
VERSION := $(shell git describe --tags --abbrev=0)
REGISTRY := docker.io/staszinch
TARGETOS := linux #linux darwin windows
TARGETARCH := amd64
CGO_ENABLED = 0

.PHONY: help
help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "  linux            to build the Linux binary"
	@echo "  macOS            to build the macOS binary"
	@echo "  windows          to build the Windows binary"
	@echo "  image            to build Docker image"
	@echo "  push             to push Docker image to repository"
	@echo "  clean            to remove the Docker image"

linux:
	${MAKE} build TARGETOS=linux TARGETARCH=${TARGETARCH}

macOS:
	${MAKE} build TARGETOS=darwin TARGETARCH=${TARGETARCH}

windows:
	${MAKE} build TARGETOS=windows TARGETARCH=${TARGETARCH} CGO_ENABLED=1

build:
	CGO_ENABLED=${CGO_ENABLED} GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o cooperbot -ldflags "-X="github.com/redman-dev29/cooperbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg CGO_ENABLED=${CGO_ENABLED} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
	@echo=off rm -f $(APP)
