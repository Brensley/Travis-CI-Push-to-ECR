#####travis/docker_push.sh - Code to push the built image to Amazon ECR
# location .travis/docker_push.sh

#!/bin/bash -e

REGISTRY_URL=${AWS_ACCOUNT_ID}.dkr.ecr.${EB_REGION}.amazonaws.com
TIMESTAMP=$(date '+%Y%m%d%H%M%S')
# using datetime as part of a version for versioned image
VERSION="${TIMESTAMP}-${TRAVIS_COMMIT}"
# using specific version as well
# it is useful if you want to reference this particular version
# in additional commands like deployment of new Elasticbeanstalk version

# making sure correct region is set
aws configure set default.region ${EB_REGION}

# Login to ECR
$(aws ecr get-login --no-include-email)

# Tag and Push an image
#######################
if [[ $TRAVIS_BRANCH == 'master' ]]
then
	SOURCE_IMAGE="sample_container_prod"
elif [[ $TRAVIS_BRANCH == 'dev' ]]
then
	SOURCE_IMAGE="sample_container_dev"
else
	SOURCE_IMAGE="sample_container_sandbox"
fi

TARGET_IMAGE_LATEST="${REGISTRY_URL}/${SOURCE_IMAGE}:latest"
TARGET_IMAGE_VERSIONED="${REGISTRY_URL}/${SOURCE_IMAGE}:${VERSION}"

# update and push latest version
docker tag ${SOURCE_IMAGE} ${TARGET_IMAGE_LATEST}
docker push ${TARGET_IMAGE_LATEST}

# update and push new version with timestamp
docker tag ${SOURCE_IMAGE} ${TARGET_IMAGE_VERSIONED}
docker push ${TARGET_IMAGE_VERSIONED}