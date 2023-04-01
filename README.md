## infrastructure terraform backend

## Deployment Status
[![CircleCI](https://circleci.com/gh/SamRoyDev/samroyio-infrastructure/tree/master.svg?style=svg)](https://circleci.com/gh/SamRoyDev/samroyio-infrastructure/tree/master)

## Github -> CircleCI -> AWS Parameter Store (secrets) -> Cloudflare -> S3

### AWS Parameter store much cheaper than AWS Secrets manager
  - AWS Secrets Manager is $0.40/mo per secret
  - AWS Parameter Store is $Free.99/mo

### CircleCI Deployment
```
  apply:
    docker:
      - image: docker.mirror.hashicorp.services/hashicorp/terraform:light
    steps:
      - attach_workspace:
          at: .
      - run:
          name: terraform
          command: |
            terraform apply -auto-approve tfapply
      - persist_to_workspace:
          root: .
          paths:
            - .
```