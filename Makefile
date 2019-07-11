SHELL = /bin/bash -o nounset -o errexit -o pipefail
.PHONY: *

REPO := machinistlabs/concourse-http-publish
TAG ?= latest

build:
	docker build -t $(REPO):$(TAG) .

push:
	docker push $(REPO):$(TAG)
