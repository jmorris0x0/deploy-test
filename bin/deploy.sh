#!/usr/bin/env bash

set -e


check_deploy_changes() {
    # Does diff of current commit with last merge commit for the deploy/ directory.
    # This makes sure that a new image is deployed to ECR only when there has been
    # a change to the Dockerfile, the docker-compose.yml, or something that goes into it.
    last_merge_commit=$(git --no-pager log --pretty=oneline --format=format:%H --merges -n 1)
    DIFF=$(git diff $last_merge_commit -- deploy/)

    echo $DIFF

    if [ "$DIFF" ]; then
        echo 1
    else echo 0
    fi
}

echo

echo

if [ "$(check_deploy_changes)" == 1 ]; then
    echo "Yes change to this branch in deploy/"
else 
    echo "No change to this branch in deploy/"
fi



