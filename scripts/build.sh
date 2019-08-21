#!/bin/bash -e
__SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"

# version 1.0.0
echo "This is a build"

echo "CODEBUILD_RESOLVED_SOURCE_VERSION=$CODEBUILD_RESOLVED_SOURCE_VERSION"
echo "CODEBUILD_SOURCE_REPO_URL=$CODEBUILD_SOURCE_REPO_URL"
echo "CODEBUILD_SOURCE_VERSION=$CODEBUILD_SOURCE_VERSION"
echo "CODEBUILD_SRC_DIR=$CODEBUILD_SRC_DIR"
echo "CODEBUILD_SOURCE_REPO_URL=$CODEBUILD_SOURCE_REPO_URL"

#aws codecommit get-commit --repository-name tjones-temp-can-delete --commit-id $CODEBUILD_RESOLVED_SOURCE_VERSION


ls -lah $CODEBUILD_SRC_DIR
pwd

scripts/codebuild-git-wrapper.sh https://git-codecommit.ap-southeast-2.amazonaws.com/v1/repos/tjones-temp-can-delete master

scripts/semver-from-git.sh

echo "GIT_SEMVER_FROM_TAG=$GIT_SEMVER_FROM_TAG"
echo "GIT_EXACT_TAG=$GIT_EXACT_TAG"
echo "GIT_BRANCH=$GIT_BRANCH"
