.PHONY: all test clean

BUILDS_DIR = builds

RELEASE = $(shell git tag -l | tail -1 )

all:
	@if [ -z "$(RELEASE)" ]; then \
		echo "Could not determine tag to use. Aborting." ; \
		exit 1 ; \
	else \
		echo "Building $(RELEASE)" ; \
		goxc -bc="!plan9" -arch='amd64' -pv="$(RELEASE)" -d="$(BUILDS_DIR)" -include=LICENSE -os='darwin freebsd linux windows' go-vet go-test xc archive-zip archive-tar-gz ; \
	fi

test:
	@go test -cover -race ./...

clean:
	rm -rf "$(BUILDS_DIR)"
