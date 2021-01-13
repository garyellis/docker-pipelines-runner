IMAGE_NAME=garyellis/pipelines-runner
IMAGE_VERSION=0.2.0
DOCKERFILE=Dockerfile
REGISTRY=docker.io

export IMAGE_NAME IMAGE_VERSION DOCKERFILE REGISTRY

.PHONY: help
	.DEFAULT_GOAL := help

VERSION := . ./version

help: ## show this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker-build: ## build the docker image
	docker build -f ${DOCKERFILE} -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION} .

docker-push: tag ## push the docker image
	docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
