##### build.sh - Code to build the container
# location build.sh

#!/bin/bash

if [[ $TRAVIS_BRANCH == 'master' ]]
then
  echo "Branch is master"
elif [[ $TRAVIS_BRANCH == 'dev' ]]
then
  echo "Branch is dev"
else
  echo "Branch is sandbox"
   sudo docker build -t sample_container_sandbox -f .dockerfile .
  --build-arg AWS_KEY=$AWS_ACCESS_KEY_ID
  --build-arg AWS_SECRET_KEY=$AWS_SECRET_ACCESS_KEY
  --build-arg env_type=sandbox

fi