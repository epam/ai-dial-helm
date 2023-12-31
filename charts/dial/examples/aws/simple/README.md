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
- Azure `gpt-35-turbo` model deployed:
  - [Azure Model Deployment Guide](https://docs.epam-rail.com/Deployment/Azure%20Model%20Deployment)

## Expected Outcome

By following the instructions in this guide, you will successfully install the AI DIAL system with configured connection to the Azure GPT-3.5 API.\
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
    - It's assumed you've configured **aws-load-balancer-controller** and **external-dns** beforehand, so replace `%%DOMAIN%%` with your domain name, e.g. `example.com`, and `%%CERTIFICATE_ARN%%` with your AWS ACM certificate ARN, e.g. `arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012`
    - Replace `%%OPENAI_API_KEY%%` with generated value (`pwgen -s -1 64`)
    - Replace `%%NEXTAUTH_SECRET%%` with generated value (`openssl rand -base64 64`)
    - Replace `%%MODEL_ENDPOINT%%` with Azure OpenAI Model Endpoint from [prerequisites](#prerequisites), e.g. `https://not-a-real-endpoint.openai.azure.com/openai/deployments/gpt-35-turbo/chat/completions`
    - Replace `%%MODEL_KEY%%` with Azure OpenAI Model Key from [prerequisites](#prerequisites), e.g. `3F0UZREXNOTAREALKEYDCvzSkznPFa`

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
      - Use previously generated `%%OPENAI_API_KEY%%` value

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
