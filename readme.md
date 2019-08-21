# CodePipeline / CodeBuild / CodeCommit git metadata example

This project illustrates how to get git metadata into CodePipeline by cloning the
repository and winding it back to the right commit.

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

1) Create a CodeCommit repository, note down the repository name and the clone URL.

2) Clone this repository.

```
git clone https://github.com/TimothyJones/codepipeline-git-metadata-example.git
```

3) Add your AWS repo as a remote, and push:

```
git remote add aws <YOUR CLONE URL>
git push -u aws master
```

Deploy the pipeline: 

```
aws cloudformation deploy --template-file cfn-pipeline.yaml \
    --stack-name=<ANY_NEW_STACK_NAME>                       \
    --parameter-overrides                                   \
      RepositoryName=<YOUR_REPO_NAME>                       \
      RepositoryCloneUrl=<YOUR_REPO_CLONE_URL>              \
      --capabilities CAPABILITY_IAM
```
