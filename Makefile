VERSIONFILE=version.txt
VERSION=`cat $(VERSIONFILE)`

build: fmt
	go build .

release: build-rpi build-linux build-macos build-windows

build-rpi:
	mkdir -p release-$(VERSION)
	env GOOS=linux GOARCH=arm GOARM=7 go build -o release-$(VERSION)/prometheus-klipper-exporter-rpi-armv7-$(VERSION) .
	env GOOD=linux GOARCH=arm64 go build -o release-$(VERSION)/prometheus-klipper-exporter-rpi-arm64-$(VERSION) .

build-linux:
	mkdir -p release-$(VERSION)
	env GOOD=linux GOARCH=amd64 go build -o release-$(VERSION)/prometheus-klipper-exporter-linux-amd64-$(VERSION) .

build-macos:
	mkdir -p release-$(VERSION)
	env GOOS=darwin GOARCH=amd64 go build -o release-$(VERSION)/prometheus-klipper-exporter-macos-amd64-$(VERSION) .
	env GOOS=darwin GOARCH=arm64 go build -o release-$(VERSION)/prometheus-klipper-exporter-macos-arm64-$(VERSION) .

build-windows:
	mkdir -p release-$(VERSION)
	env GOOS=windows GOARCH=amd64 go build -o release-$(VERSION)/prometheus-klipper-exporter-windows-amd64-$(VERSION).exe .

clean:
	rm -rf release-$(VERSION)/*

fmt:
	go fmt

run: fmt
	go run .	


# .PHONY build build-all: build-rpi build-linux build-macos-m1 build-windows run