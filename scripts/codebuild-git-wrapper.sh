#!/bin/bash -eu

# This function prints the usage
function usage {
  {
    echo "Usage:"
    echo "   ${BASH_SOURCE[0]} <REPO_URL> <BRANCH>"
    echo "      REPO_URL - the URL for the CodeCommit repository"
    echo "      BRANCH - (optional) the branch to check out. Defaults to the default branch." 
  } >&2
}

# Confirm that there are at least two arguments
if [ "$#" -lt 1 ]; then
  usage
  exit 1
fi

# Confirm that CODEBUILD_RESOLVED_SOURCE_VERSION is set
if [ -z "${CODEBUILD_RESOLVED_SOURCE_VERSION:-}" ]; then
  {
    echo "Error: CODEBUILD_RESOLVED_SOURCE_VERSION is not set"
  } >&2 
  usage
  exit 1
fi

# Read arguments
REPO_URL="$1"
if [ ! -z "${2:-}" ]; then
  BRANCH=$2
fi

# Remember the working directory
WORKING_DIR="$(pwd)"

# Check out the repository to a temporary directory
# Note that --quiet doesn't work on the current CodeBuild agents, but
# hopefully it will in the future
TEMP_FOLDER="$(mktemp -d)"
git clone --quiet "$REPO_URL" "$TEMP_FOLDER"

# Wind the repository back to the specified branch and commit
cd "$TEMP_FOLDER"
if [ ! -z "${BRANCH:-}" ]; then
  git checkout "$BRANCH"
fi
git reset "$CODEBUILD_RESOLVED_SOURCE_VERSION"

# Confirm that the git checkout worked
if [ ! -d  .git ] ; then
  {
    echo "Error: .git directory missing. Git checkout probably failed"
  } >&2 
  exit 1
fi

mv .git "$WORKING_DIR"
