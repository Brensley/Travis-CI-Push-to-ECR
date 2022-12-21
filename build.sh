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
  sudo docker build 
  -t sample_container_prod -f containers/sample_container/dockerfile .
fi