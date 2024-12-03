# AI DIAL Azure Installation Complete Guide

- [AI DIAL Azure Installation Complete Guide](#ai-dial-azure-installation-complete-guide)
  - [Prerequisites](#prerequisites)
  - [Expected Outcome](#expected-outcome)
  - [Install](#install)
  - [Uninstall](#uninstall)
  - [What's next?](#whats-next)

## Prerequisites

- AKS 1.28+
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) installed and configured
- [Helm](https://helm.sh/docs/intro/install/) `3.8.0+` installed
- [external-dns](https://github.com/kubernetes-sigs/external-dns) installed in the cluster (optional)
- [Azure AD Workload Identity](https://azure.github.io/azure-workload-identity/docs/introduction.html) installed and configured
- [GCP Workload Identity Federation with Kubernetes](https://cloud.google.com/iam/docs/workload-identity-federation-with-kubernetes#eks) configured
- [AWS IAM credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started-workloads.html)  installed and configured
- [Static IP address](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-addresses) reserved for Chat
- [DNS records](https://learn.microsoft.com/en-us/azure/dns/public-dns-overview) configured for Chat
- [Azure-managed SSL certificates](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-app-service-certificate) issued for Chat
- [Application Gateway Ingress Controller](https://github.com/Azure/application-gateway-kubernetes-ingress) installed and configured
- [Azure Blob storage](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-overview)
- [Azure Cache for redis](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/quickstart-create-redis)
- [Azure OpenAI](https://learn.microsoft.com/en-us/azure/ai-services/openai/overview)  `gpt-35-turbo` model deployed:
  - [OpenAI Model Deployment Guide](https://docs.epam-rail.com/Deployment/OpenAI%20Model%20Deployment)
- [Google Vertex AI](https://cloud.google.com/vertex-ai/?hl=en) `gemini-1.5-pro` model deployed:
  - [GCP Model Deployment Guide](https://docs.epam-rail.com/Deployment/Vertex%20Model%20Deployment)
- [Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html) `anthropic.claude-v2:1` model deployed:
  - [Bedrock Model Deployment Guide](https://docs.epam-rail.com/Deployment/Bedrock%20Model%20Deployment)

## Expected Outcome

By following the instructions in this guide, you will successfully install the AI DIAL system with configured connection to the OpenAI, Vertex AI, Bedrock APIs.\
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
    - Replace `%%AZURE_WORKLOAD_IDENTITY_CLIENT_ID%%` with appropriate workload identity [link](https://docs.epam-rail.com/Deployment/OpenAI%20Model%20Deployment#use-kubernetes-service-account-assigned-to-azure-user-assigned-managed-identity)
    - Replace `%%AZURE_DEPLOYMENT_HOST%%` with appropriate endpoint [link](https://docs.epam-rail.com/tutorials/quick-start-model#step-2-configuration)
    - Replace `%%AZURE_CLIENT_ID%%` with a unique identifier for the client application registered in Azure Active Directory (AD). It is used to authenticate the client application when accessing Azure AD resources.
    - Replace `%%AZURE_TENANT_ID%%` with a Tenant ID refers to a globally unique identifier (GUID) that represents a specific Azure AD tenant. It is used to identify and authenticate the Azure AD tenant that the client application belongs to.
    - Replace `%%AZURE_CLIENT_SECRET%%` with a client secret or application secret, this parameter is a confidential string that authenticates and authorizes the client application to access Azure AD resources. It serves as a password for the client application.
    - Replace `%%AZURE_CORE_BLOB_STORAGE_NAME%%` with Azure Blob storage name from [prerequisites](#prerequisites)
    - Replace `%%AZURE_CORE_BLOB_STORAGE_ENDPOINT%%` with Azure Blob storage endpoint from [prerequisites](#prerequisites)
    - Replace `%%AZURE_CACHE_REDIS_ADDRESS%%` with Azure Cache for Redis endpoint, e.g. `[\"rediss://10.0.0.2:6380\"]`
    - Replace `%%AZURE_CACHE_REDIS_PASSWORD%%` with Azure Cache for Redis password
    - Replace `%%GCP_REGION%%` with GCP Region e.g. `us-east1`
    - Replace `%%AWS_REGION%%` with GCP Region e.g. `us-east-1`
    - Replace `%%GCP_PROJECT_ID%%` with GCP Project Id e.g. `dial-191923`
    - Replace `%%GCP_SERVICE_ACCOUNT_ID%%` with GCP service account id [link](https://cloud.google.com/iam/docs/workload-identity-federation-with-kubernetes)
    - Replace `%%AWS_ACCESS_KEY%%` with AWS access key from [prerequisites](#prerequisites)
    - Replace `%%AWS_SECRET_KEY%%` with AWS secret key from [prerequisites](#prerequisites)
    - Replace `%%AZURE_WORKLOAD_IDENTITY_CLIENT_ID%%` with appropriate workload identity [link](https://docs.epam-rail.com/Deployment/OpenAI%20Model%20Deployment#use-kubernetes-service-account-assigned-to-azure-user-assigned-managed-identity)
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
