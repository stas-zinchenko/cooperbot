VERSION=$(shell git describe --tags --abbrev=0)

format:
	gofmt -s -w ./

build:
	go build -v -o cooperbot -ldflags "-X="github.com/redman-dev29/cooperbot/cmd.appVersion=${VERSION}