#!/bin/bash
DIRNAME=`dirname $0`
DOCKER_BUILD_DIR=`cd $DIRNAME/../; pwd`
echo "DOCKER_BUILD_DIR=${DOCKER_BUILD_DIR}"
cd ${DOCKER_BUILD_DIR}

BUILD_ARGS="--no-cache"
ORG="onap"
VERSION="1.0.0-SNAPSHOT"
STAGING_VERSION="1.0.0-STAGING"
PROJECT="multicloud"
IMAGE="azure"
DOCKER_REPOSITORY="aeenexus3:10003"
IMAGE_NAME="${DOCKER_REPOSITORY}/${ORG}/${PROJECT}/${IMAGE}"

if [ $HTTP_PROXY ]; then
    BUILD_ARGS+=" --build-arg HTTP_PROXY=${HTTP_PROXY}"
fi
if [ $HTTPS_PROXY ]; then
    BUILD_ARGS+=" --build-arg HTTPS_PROXY=${HTTPS_PROXY}"
fi

function build_image {
    docker build ${BUILD_ARGS} -f docker/Dockerfile -t ${IMAGE_NAME}:${VERSION} -t ${IMAGE_NAME}:latest -t ${IMAGE_NAME}:${STAGING_VERSION} .
}

function push_image {
    docker push ${IMAGE_NAME}:${VERSION}
    docker push ${IMAGE_NAME}:${STAGING_VERSION}
    docker push ${IMAGE_NAME}:latest
}

build_image
push_image