#!/usr/bin/env bash

. .env

###################################################################
# Main
###################################################################

echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

IFS='\n' read -r -a image_ids <<< "$(docker images --filter=reference=rocker/tidyverse --format '{{.ID}}')"
DOCKER_IMAGE_HASH="${DOCKER_IMAGE_HASH:-${image_ids[0]}}"

# To find DOCKER_IMAGE_HASH: docker image ls
docker tag "$DOCKER_IMAGE_HASH" "ghcr.io/${CONTAINER_REG_USER}/${CONTAINER_REG_NAME}:latest"
docker push "ghcr.io/${CONTAINER_REG_USER}/${CONTAINER_REG_NAME}:latest"
