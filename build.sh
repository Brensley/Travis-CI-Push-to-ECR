##### build.sh - Code to build the container
# location build.sh

#!/bin/bash

if [[ $TRAVIS_BRANCH == 'main' ]]
then
  echo "Branch is master"
elif [[ $TRAVIS_BRANCH == 'main' ]]
then
  echo "Branch is dev"
else
  echo "Branch is sandbox"
   sudo docker build -t sample_container_sandbox -f .dockerfile .
fi