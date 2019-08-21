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