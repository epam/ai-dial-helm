# AI DIAL GCP Installation Complete Guide

- [AI DIAL GCP Installation Complete Guide](#ai-dial-gcp-installation-complete-guide)
  - [Prerequisites](#prerequisites)
  - [Expected Outcome](#expected-outcome)
  - [Install](#install)
  - [Uninstall](#uninstall)
  - [What's next?](#whats-next)

## Prerequisites

- GKE 1.24+
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) installed and configured
- [Helm](https://helm.sh/docs/intro/install/) `3.8.0+` installed
- [external-dns](https://github.com/kubernetes-sigs/external-dns) installed in the cluster (optional)
- [GCP IAM roles for service accounts](https://cloud.google.com/iam/docs/service-account-overview) installed and configured
- [Azure AD Workload Identity](https://azure.github.io/azure-workload-identity/docs/introduction.html) installed and configured
- [AWS IAM credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started-workloads.html) configured
- [GKE Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity) installed and configured
- [GKE Ingress](https://cloud.google.com/kubernetes-engine/docs/concepts/ingress) installed
- [Static IP address](https://cloud.google.com/vpc/docs/reserve-static-external-ip-address) reserved for Chat and Core
- [DNS records](https://cloud.google.com/dns/docs/set-up-dns-records-domain-name) configured for Chat and Core
- [Google-managed SSL certificates](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs) issued for Chat and Core
- [Google Storage bucket](https://cloud.google.com/storage/docs/buckets)
- [Google MemoryStore RedisCluster](https://cloud.google.com/memorystore/docs/cluster)
    - [Downloading the Certificate Authority](https://cloud.google.com/memorystore/docs/redis/manage-in-transit-encryption#downloading_the_certificate_authority)
    - [Creating TrustStore](https://docs.oracle.com/cd/E19509-01/820-3503/ggfka/index.html)
- [Google Identity](https://docs.epam-rail.com/Auth/Web/IDPs/google) as identity provider
- [Google Vertex AI](https://cloud.google.com/vertex-ai/?hl=en) `gemini-1.5-pro` model deployed:
  - [GCP Model Deployment Guide](https://docs.epam-rail.com/Deployment/Vertex%20Model%20Deployment)
- [Azure OpenAI](https://learn.microsoft.com/en-us/azure/ai-services/openai/overview)
  - [OpenAI Model Deployment Guide](https://docs.epam-rail.com/Deployment/OpenAI%20Model%20Deployment)
- [Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html) `anthropic.claude-v1` model deployed:
  - [Bedrock Model Deployment Guide](https://docs.epam-rail.com/Deployment/Bedrock%20Model%20Deployment)

## Expected Outcome

By following the instructions in this guide, you will successfully install the AI DIAL system with configured connection to the Vertex AI, OpenAI, Bedrock APIs.\
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
    - Replace `%%TRUSTSTORE_PASSWORD%%` with Java truststore password, e.g. `changeit`
    - Replace `%%GCP_CORE_SERVICE_ACCOUNT%%` with Google Service Account from [prerequisites](#prerequisites)
    - Replace `%%GCP_CORE_STORAGE_BUCKET_NAME%%` with Google Storage bucket name from [prerequisites](#prerequisites)
    - Replace `%%GCP_CHAT_IP_ADDRESS%%` with static IP address name for Chat from [prerequisites](#prerequisites)
    - Replace `%%GCP_CHAT_CERTIFICATE%%` with Google-managed certificate name for Chat from [prerequisites](#prerequisites)
    - Replace `%%GCP_CORE_IP_ADDRESS%%` with static IP address name for Core from [prerequisites](#prerequisites)
    - Replace `%%GCP_CORE_CERTIFICATE%%` with Google-managed certificate name for Core from [prerequisites](#prerequisites)
    - Replace `%%GCP_PROJECT_ID%%` with GCP Project Id e.g. `dial-191923`
    - Replace `%%GCP_REGION%%` with GCP Region e.g. `us-east1`
    - Replace `%%GCP_MEMORYSTORE_REDISCLUSTER_ENDPOINT%%` with MemoryStore RedisCluster endpoint, e.g. `[\"rediss://10.0.0.2:6379\"]`
    - Replace `%%AUTH_GOOGLE_CLIENT_ID%%` with Cloud Identity client ID from [prerequisites](#prerequisites)
    - Replace `%%AUTH_GOOGLE_SECRET%%` with Cloud Identity client secret from [prerequisites](#prerequisites)
    - Replace `%%GCP_VERTEXAI_SERVICE_ACCOUNT%%` with Google Service Account from [prerequisites](#prerequisites)
    - Replace `%%AWS_ACCESS_KEY%%` with AWS access key from [prerequisites](#prerequisites)
    - Replace `%%AWS_SECRET_KEY%%` with AWS secret key from [prerequisites](#prerequisites)
    - Replace `%%AZURE_WORKLOAD_IDENTITY_CLIENT_ID%%` with appropriate workload identity [link](https://docs.epam-rail.com/Deployment/OpenAI%20Model%20Deployment#use-kubernetes-service-account-assigned-to-azure-user-assigned-managed-identity)

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
