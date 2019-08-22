# CodePipeline / CodeBuild / CodeCommit git metadata example

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This project illustrates how to get git metadata into CodePipeline by cloning the
repository and winding it back to the right commit. It is the companion code to [this blog post](https://medium.com/@timothyjones_88921/how-to-access-git-metadata-in-codebuild-when-using-codepipeline-codecommit-ceacf2c5c1dc), which explains the strategy in detail.

You can deploy it with a command like this:

```
aws cloudformation deploy --template-file cfn-pipeline.yaml \
    --stack-name=<YOUR_STACK_NAME>                          \
    --parameter-overrides                                   \
      RepositoryName=<YOUR_REPO_NAME>                       \
      RepositoryCloneUrl=<YOUR_REPO_CLONE_URL>              \
      RepositoryBranch=<OPTIONAL_YOUR_REPO_BRANCH>          \
      --capabilities CAPABILITY_IAM
```

Make sure to replace the bracketed values before deployment.

## Full instructions

To see this in action, follow the following steps:

1) Clone this repository.

```
git clone https://github.com/TimothyJones/codepipeline-git-metadata-example.git
```

2) Create an AWS CodeCommit repository, note down the repository name and the clone URL.

3) Add your new CodeCommit repo as a remote, and push:

```
git remote add aws <YOUR CLONE URL>
git push -u aws master
```

3b) If the above push fails, you will probably need to [configure the AWS credential helper](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-https-unixes.html)

4) Deploy the pipeline: 

```
aws cloudformation deploy --template-file cfn-pipeline.yaml \
    --stack-name=<ANY_NEW_STACK_NAME>                       \
    --parameter-overrides                                   \
      RepositoryName=<YOUR_REPO_NAME>                       \
      RepositoryCloneUrl=<YOUR_REPO_CLONE_URL>              \
      --capabilities CAPABILITY_IAM
```
