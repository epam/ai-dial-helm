# AI DIAL AWS Installation Simple Guide

- [AI DIAL AWS Installation Simple Guide](#ai-dial-aws-installation-simple-guide)
  - [Prerequisites](#prerequisites)
  - [Expected Outcome](#expected-outcome)
  - [Install](#install)
  - [Uninstall](#uninstall)
  - [What's next?](#whats-next)

## Prerequisites

- EKS 1.24+
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) installed and configured
- [Helm](https://helm.sh/docs/intro/install/) `3.8.0+` installed
- [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/latest/deploy/installation/) installed in the cluster
- [external-dns](https://github.com/kubernetes-sigs/external-dns) installed in the cluster (optional)
- [IAM roles for service accounts](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html) installed and configured
- [Amazon S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html) `anthropic.claude-v1` model deployed:
  - [Bedrock Model Deployment Guide](https://docs.epam-rail.com/Deployment/Bedrock%20Model%20Deployment)

## Expected Outcome

By following the instructions in this guide, you will successfully install the AI DIAL system with configured connection to the Bedrock API.\
Please note that this guide represents a very basic deployment scenario, and **should never be used in production**.\
Configuring authentication provider, encrypted secrets, model usage limits, Ingress allowlisting and other security measures are **out of scope** of this guide.

## Install

1. Create Kubernetes namespace, e.g. `dial`

    **Command:**

    ```sh
    kubectl create namespace dial
    ```

    **Output:**

    ```console
    namespace/dial created
    ```

1. Add Helm chart repository

    **Command:**

    ```sh
    helm repo add dial https://charts.epam-rail.com
    ```

    **Output:**

    ```console
    "dial" has been added to your repositories
    ```

1. Copy [values.yaml](values.yaml) file to your working directory and fill in missing values:
    - Replace `%%NAMESPACE%%` with namespace created above, e.g. `dial`
    - Replace `%%DOMAIN%%` with your domain name, e.g. `example.com`
    - Replace `%%DIAL_API_KEY%%` with generated value (`pwgen -s -1 64`)
    - Replace `%%CORE_ENCRYPT_SECRET%%` with generated value (`pwgen -s -1 32`)
    - Replace `%%CORE_ENCRYPT_KEY%%` with generated value (`pwgen -s -1 32`)
    - Replace `%%NEXTAUTH_SECRET%%` with generated value (`openssl rand -base64 64`)
    - Replace `%%REDIS_PASSWORD%%` with generated value (`pwgen -s -1 32`)
    - Replace `%%AWS_CORE_ROLE_ARN%%` with S3 AWS role ARN from [prerequisites](#prerequisites)
    - Replace `%%AWS_CORE_S3_BUCKET_NAME%%` with S3 bucket name from [prerequisites](#prerequisites)
    - Replace `%%AWS_BEDROCK_ROLE_ARN%%` with bedrock AWS role ARN from [prerequisites](#prerequisites)
    - Replace `%%AWS_BEDROCK_REGION%%` with bedrock region from [prerequisites](#prerequisites)
    - It's assumed you've configured **external-dns** and **aws-load-balancer-controller** beforehand, so replace `%%DOMAIN%%` with your domain name, e.g. `example.com`, and `%%AWS_CERTIFICATE_ARN%%` with your AWS ACM certificate ARN, e.g. `arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012`

1. Install `dial` helm chart in created namespace, applying custom values file:

    **Command:**

    ```sh
    helm install dial dial/dial -f values.yaml --namespace dial
    ```

    **Output:**

    ```console
    Release "dial" does not exist. Installing it now.
    NAME: dial
    LAST DEPLOYED: Thu Nov 30 16:35:54 2023
    NAMESPACE: dial
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    CHART NAME: dial
    CHART VERSION: 1.0.0
    APP VERSION: 1.0
    ** Please be patient while the chart is being deployed **
    ```

1. Now you can access:
    - Chat by the following URL: `https://chat.%%DOMAIN%%/`, e.g. `https://chat.example.com/`
    - API by the following URL: `https://dial.%%DOMAIN%%/`, e.g. `https://dial.example.com/`
      - Use previously generated `%%DIAL_API_KEY%%` value

## Uninstall

1. Uninstall `dial` helm chart from created namespace

    **Command:**

    ```sh
    helm uninstall dial --namespace dial
    ```

    **Output:**

    ```console
    release "dial" uninstalled
    ```

1. Delete Kubernetes namespace, e.g. `dial`

    **Command:**

    ```sh
    kubectl delete namespace dial
    ```

    **Output:**

    ```console
    namespace "dial" deleted
    ```

## What's next?

- [Configuration](https://docs.epam-rail.com/Deployment/configuration)
