# AI DIAL AWS Installation Complete Guide

- [AI DIAL AWS Installation Complete Guide](#ai-dial-aws-installation-complete-guide)
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
- [Azure AD Workload Identity](https://azure.github.io/azure-workload-identity/docs/introduction.html) installed and configured
- [GCP Workload Identity Federation with Kubernetes](https://cloud.google.com/iam/docs/workload-identity-federation-with-kubernetes#eks) configured
- [Amazon S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [Amazon Cognito](https://docs.epam-rail.com/Deployment/idp-configuration/cognito)
- [Amazon Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/whats-in-a-secret.html)
- [Amazon ElastiCache for Redis](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/WhatIs.html)
- [Google Vertex AI](https://cloud.google.com/vertex-ai/docs/start/introduction-unified-platform)
  - [Vertex AI Model Deployment Guide](https://docs.epam-rail.com/Deployment/Vertex%20Model%20Deployment)
- [Azure OpenAI](https://learn.microsoft.com/en-us/azure/ai-services/openai/overview)
  - [OpenAI Model Deployment Guide](https://docs.epam-rail.com/Deployment/OpenAI%20Model%20Deployment)
- [Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html) `anthropic.claude-v1` model deployed:
  - [Bedrock Model Deployment Guide](https://docs.epam-rail.com/Deployment/Bedrock%20Model%20Deployment)

## Expected Outcome

By following the instructions in this guide, you will successfully install the AI DIAL system with configured connection to the Vertex AI, OpenAI, Bedrock APIs.\
Please note that this guide represents a very basic deployment scenario, and **should never be used in production**.\
For authenticaConfiguring authentication provider, encrypted secrets, model usage limits, Ingress allowlisting and other security measures are **out of scope** of this guide.

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
    - Replace `%%AWS_COGNITO_REGION%%` - aws region where resides Cognito pool e.g. `us-east-1`
    - Replace `%%AWS_COGNITO_ID%%` with AWS Cognito pool id e.g. `us-east-1_AbcD0efGh`
    - Replace `%%AZURE_DEPLOYMENT_HOST%%` with appropriate endpoint [link](https://docs.epam-rail.com/tutorials/quick-start-model#step-2-configuration)
    - Replace `%%DIAL_CORE_SECRET%%` with DIAL core secrets !!!!!!!!!!!!!!!!
    - Replace `%%CERTIFICATE_ARN%%` with associated ACM certificate arn e.g. `arn:aws:acm:us-east-1:123456789012:certificate/1234567a-b123-4567-8c9d-123456789012`
    - Replace `%%AUTH_COGNITO_CLIENT_ID%%` with AWS Cognito client ID [link](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html)
    - Replace `%%AUTH_COGNITO_HOST%%` with AWS Cognito host like `%%COGNITO_ENDPOINT%%`/`%%AWS_COGNITO_ID%%` e.g. `https://cognito-idp.us-east-1.amazonaws.com/us-east-1_AbcD0efGh`
        * where %%COGNITO_ENDPOINT%% - endpoint of AWS Cognito [link](https://docs.aws.amazon.com/general/latest/gr/cognito_identity.html)
    - Replace `%%AUTH_COGNITO_NAME%%` with Cognito client name e.g. `dial` [link](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html)
    - Replace `%%AUTH_COGNITO_SECRET%%` with Cognito secret [link](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html)

    ####################
    - Replace `%%GCP_PROJECT_ID%%` - with GCP Project id
    - Replace `%%GCP_SERVICE_ACCOUNT_AUDIENCE%%` with audience value from %%GCP_WORKLOAD_IDENTITY_CREDS%%
    - Replace `%%GCP_WORKLOAD_IDENTITY_CREDS%%` - with GCP Workload Identity
    ```
        {
            "type": "external_account",
            "audience": "//iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/$POOL_ID/providers/$PROVIDER_ID",
            "subject_token_type": "urn:ietf:params:oauth:token-type:jwt",
            "service_account_impersonation_url": "https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/$EMAIL:generateAccessToken",
            "token_url": "https://sts.googleapis.com/v1/token",
            "credential_source": {
                "file": "/var/run/service-account/token",
                "format": {
                    "type": "text"
                }
            }
        }

    ```

    - Replace `%%AZURE_WORKLOAD_IDENTITY_CLIENT_ID%%` with appropriate workload identity [link](https://docs.epam-rail.com/Deployment/OpenAI%20Model%20Deployment#use-kubernetes-service-account-assigned-to-azure-user-assigned-managed-identity)

    - Replace `%%NAMESPACE%%` with namespace created above, e.g. `dial`
    - Replace `%%DOMAIN%%` with your domain name, e.g. `example.com`
    - Replace `%%DIAL_API_KEY%%` with generated value (`pwgen -s -1 64`)
    - Replace `%%CORE_ENCRYPT_PASSWORD%%` with generated value (`pwgen -s -1 32`)
    - Replace `%%CORE_ENCRYPT_SALT%%` with generated value (`pwgen -s -1 32`)
    - Replace `%%NEXTAUTH_SECRET%%` with generated value (`openssl rand -base64 64`)
    - Replace `%%AWS_CORE_ROLE_ARN%%` with S3 AWS role ARN from [prerequisites](#prerequisites)
    - Replace `%%AWS_CORE_S3_BUCKET_NAME%%` with S3 bucket name from [prerequisites](#prerequisites)
    - Replace `%%AWS_BEDROCK_ROLE_ARN%%` with bedrock AWS role ARN from [prerequisites](#prerequisites)
    - Replace `%%AWS_BEDROCK_REGION%%` with bedrock region from [prerequisites](#prerequisites)
    - It's assumed you've configured **external-dns** and **aws-load-balancer-controller** beforehand, so replace `%%DOMAIN%%` with your domain name, e.g. `example.com`, and `%%CERTIFICATE_ARN%%` with your AWS ACM certificate ARN, e.g. `arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012`

2. Install `dial` helm chart in created namespace, applying custom values file:

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

3. Now you can access:
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
