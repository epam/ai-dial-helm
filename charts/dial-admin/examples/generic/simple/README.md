# AI DIAL ADMIN Generic Installation Simple Guide

- [AI DIAL ADMIN Generic Installation Simple Guide](#ai-dial-admin-generic-installation-simple-guide)
  - [Prerequisites](#prerequisites)
  - [Expected Outcome](#expected-outcome)
  - [Install](#install)
  - [Uninstall](#uninstall)
  - [What's next?](#whats-next)

## Prerequisites

- Kubernetes cluster 1.28+
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) installed and configured
- [Helm](https://helm.sh/docs/intro/install/) `3.8.0+` installed
- [Ingress-Nginx Controller](https://kubernetes.github.io/ingress-nginx/deploy/) installed in the cluster
- [cert-manager](https://cert-manager.io/docs/installation/) installed in the cluster (optional)
- [external-dns](https://github.com/kubernetes-sigs/external-dns) installed in the cluster (optional)
- [H2 database credentional](https://github.com/epam/ai-dial-admin-backend/blob/development/secrets-utils/keys_generator.py) generate special keys for H2 database

## Expected Outcome

By following the instructions in this guide, you will successfully install the AI DIAL ADMIN system with export AI DIAL configuration features enabled.
Please note that this guide represents a very basic deployment scenario, and **should never be used in production**.
Configuring authentication provider, Ingress allowlisting and other security measures are **out of scope** of this guide.

## Install

1. Create Kubernetes namespace, e.g. `dial-admin`

    **Command:**

    ```sh
    kubectl create namespace dial admin
    ```

    **Output:**

    ```console
    namespace/dial-admin created
    ```

1. Copy [values.yaml](values.yaml) file to your working directory and fill in missing values:
    - Replace `%%CONFIG_EXPORT_NAMESPACE%%` kubentes namespace where ai-dial installed
    - Replace `%%THEMES_URL%%` with public DIAL themes url
    - Replace `%%DOMAIN%%` with your domain name, e.g. `example.com`
    - Replace `%%NEXTAUTH_SECRET%%` with generated value (`openssl rand -base64 64`)
    - Replace `%%H2_DATASOURCE_PASSWORD%%` with DB Password Key from script output from [prerequisites](#prerequisites)
    - Replace `%%H2_DATASOURCE_ENCRYPTEDFILEKEY%%` with Master Key from script output from [prerequisites](#prerequisites)
    - Replace `%%H2_DATASOURCE_MASTERKEY%%` with Base64 Encrypted Encryption Key from script output from [prerequisites](#prerequisites)
    - It's assumed you've configured **external-dns** and **cert-manager** beforehand, so replace `%%CLUSTER_ISSUER%%` with your cluster issuer name, e.g. `letsencrypt-production`

1. Install `dial admin` helm chart in created namespace, applying custom values file:

    **Command:**

    ```sh
    helm install dial-admin dial/dial-admin -f values.yaml --namespace dial-admin
    ```

    **Output:**

    ```console
    Release "dial-admin" does not exist. Installing it now.
    NAME: dial-admin
    LAST DEPLOYED: Mon Jul 07 16:35:54 2025
    NAMESPACE: dial-admin
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    CHART NAME: dial-admin
    CHART VERSION: 0.4.0
    APP VERSION: 0.4.0
    ** Please be patient while the chart is being deployed **
    ```

1. Now you can access:
    - DIAL admin frontend by the following URL: `https://dial-admin.%%DOMAIN%%/`, e.g. `https://dial-admin.example.com/`

## Uninstall

1. Uninstall `dial-admin` helm chart from created namespace

    **Command:**

    ```sh
    helm uninstall dial-admin --namespace dial-admin
    ```

    **Output:**

    ```console
    release "dial-admin" uninstalled
    ```

1. Delete Kubernetes namespace, e.g. `dial-admin`

    **Command:**

    ```sh
    kubectl delete namespace dial-admin
    ```

    **Output:**

    ```console
    namespace "dial-admin" deleted
    ```

## What's next?

You can configure DIAL Admin application, please refer to documentation:

- [DIAL Admin frontend](https://github.com/epam/ai-dial-admin-frontend)
- [DIAL Admin backend]((https://github.com/epam/ai-dial-admin-backend))
