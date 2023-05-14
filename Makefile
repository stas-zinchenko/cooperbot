.DEFAULT_GOAL := help
SHELL := /bin/bash

PROJECT_NAME := cooperbot
VERSION := $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
REGISTRY := ghcr.io/redman-dev29

IMAGE_TAG := $(REGISTRY)/$(PROJECT_NAME):$(VERSION)

.PHONY: help
help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "  linux            to build the Linux binary"
	@echo "  arm              to build the ARM binary"
	@echo "  mac              to build the macOS binary"
	@echo "  windows          to build the Windows binary"
	@echo "  clean            to remove the Docker image"

linux:
	GOOS=linux GOARCH=amd64 go build -o $(PROJECT_NAME)-linux-amd64

arm:
	GOOS=linux GOARCH=arm GOARM=7 go build -o $(PROJECT_NAME)-linux-arm

mac:
	GOOS=darwin GOARCH=amd64 go build -o $(PROJECT_NAME)-darwin-amd64

windows:
	GOOS=windows GOARCH=amd64 go build -o $(PROJECT_NAME)-windows-amd64.exe

build: 
	docker build -t $(IMAGE_TAG) .

push:
	docker push $(IMAGE_TAG)

clean:
	docker rmi $(IMAGE_TAG)
	rm -f $(PROJECT_NAME)-linux-amd64 $(PROJECT_NAME)-linux-arm $(PROJECT_NAME)-darwin-amd64 $(PROJECT_NAME)-windows-amd64.exe
