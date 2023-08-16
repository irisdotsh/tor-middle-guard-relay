IMAGE_NAME=irisdotsh/tor-middle-guard-relay

.PHONY: tag
tag:
	@[ "${VERSION}" ] || ( echo "VERSION is not set"; exit 1 )
	docker tag $(IMAGE_NAME) $(IMAGE_NAME):$(VERSION)
	docker tag $(IMAGE_NAME) $(IMAGE_NAME):latest

.PHONY: release
release:
	@[ "${VERSION}" ] || ( echo "VERSION is not set"; exit 1 )
	docker push $(IMAGE_NAME):$(VERSION)
	docker push $(IMAGE_NAME):latest

.PHONY: build
build:
	docker build -t ${IMAGE_NAME} .

.PHONY: build-no-cache
build-no-cache:
	docker build -t ${IMAGE_NAME} . --no-cache

.PHONY: crossbuild
crossbuild:
	@[ "${ARCH}" ] || ( echo "ARCH is not set"; exit 1 )
	docker buildx build -t $(IMAGE_NAME) --platform linux/${ARCH} .

.PHONY: crossbuild-and-release
crossbuild-and-release:
	@[ "${VERSION}" ] || ( echo "VERSION is not set"; exit 1 )
	docker buildx build -t $(IMAGE_NAME):$(VERSION) -t ${IMAGE_NAME}:latest --platform linux/arm64,linux/amd64,linux/386,linux/arm --push .

.PHONY: deploy
deploy:
	docker compose up -d tor-middle-guard-relay
	@echo "Please allow inbound and outbound traffic to and from port $(OR_PORT)/tcp on your firewall."