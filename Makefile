VERSION=$(shell git describe --tags --abbrev=0)

format:
	gofmt -s -w ./

build_linux: format
	GOOS=linux GOARCH=amd64 go build -v -o cooperbot -ldflags "-X="github.com/redman-dev29/cooperbot/cmd.appVersion=${VERSION}

clean:
	docker rmi ${IMAGE_ID}