VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS ?= linux
TARGETARCH ?= $(shell dpkg --print-architecture)

format:
	gofmt -s -w ./

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "X="github.com/SlavaGrach/kbot/cmd.appVersion=${VERSION}

lint:
	golint

test:
	go test -v

clean:
	rm -rf kbot

linux: build

windows: format get
	CGO_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "X="github.com/SlavaGrach/kbot/cmd.appVersion=${VERSION}

arm: format get
	CGO_ENABLED=0 GOOS=arm GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "X="github.com/SlavaGrach/kbot/cmd.appVersion=${VERSION}

macos: format get
	CGO_ENABLED=0 GOOS=ios GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "X="github.com/SlavaGrach/kbot/cmd.appVersion=${VERSION}