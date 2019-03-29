.PHONY: all
all: build test

IMAGE_NAME=sheeeng/codenarc

TEST_CMD=docker run \
	--rm \
	--volume `pwd`/test:/workspace:rw \
	--user `id --user`:`id --group` \
	$(IMAGE_NAME)

.PHONY: build
build:
	docker build --tag $(IMAGE_NAME) .

.PHONY: test.%
test.%:
	$(MAKE) build

.PHONY: test
test:
	$(TEST_CMD) -rulesetfiles=file:all.groovy

.PHONY: test-example
test.example:
	$(TEST_CMD) -rulesetfiles="rulesets/imports.xml,rulesets/naming.xml"

.PHONY: exec
exec:
	$(MAKE) build \
	&& docker run \
	--tty \
	--interactive \
	--rm \
	--volume `pwd`/test:/workspace \
	--user=$(id --user):$(id --group) \
	--entrypoint=/bin/bash $(IMAGE_NAME)
