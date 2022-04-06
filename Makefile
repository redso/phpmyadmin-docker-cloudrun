VERSION ?= 5.1.3

PROJECT_NAME ?= project-name
REGISTRY ?= asia.gcr.io
REPOSITORY ?= phpmyadmin

DOCKER_PATH := phpmyadmin:${VERSION}-cloudrun
REGISTRY_PATH := ${REGISTRY}/${PROJECT_NAME}/${REPOSITORY}/${DOCKER_PATH}

default: build

login:
	gcloud auth configure-docker ${REGISTRY} --project ${PROJECT_NAME} --quiet

build:
	@echo DOCKER_PATH is ${DOCKER_PATH}
	docker build --build-arg VERSION=${VERSION} -t ${DOCKER_PATH} .

push: build login
	@echo REGISTRY_PATH is ${REGISTRY_PATH}
	docker tag ${DOCKER_PATH} ${REGISTRY_PATH}
	docker push ${REGISTRY_PATH}
