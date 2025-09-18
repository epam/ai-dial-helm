# AI DIAL ADMIN Simple Installation Azure provider with keyvault export integration guide

- [AI DIAL Generic Installation Simple Guide](#ai-dial-generic-installation-simple-guide)
  - [Prerequisites](#prerequisites)
  - [Expected Outcome](#expected-outcome)
  - [Install](#install)
  - [Uninstall](#uninstall)
  - [What's next?](#whats-next)

## Prerequisites

- AKS 1.28+
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) installed and configured
- [Helm](https://helm.sh/docs/intro/install/) `3.8.0+` installed
- [Azure AD Workload Identity](https://azure.github.io/azure-workload-identity/docs/introduction.html) installed and configured
- [Azure AKS CSI Addon](https://learn.microsoft.com/en-us/azure/aks/csi-storage-drivers) enabled
- [Azure keyvault](https://learn.microsoft.com/en-us/azure/key-vault/) configured
- [2 Azure App registrations](https://github.com/epam/ai-dial-admin-backend/blob/development/docs/azure_configuration.md)
- [Ingress-Nginx Controller](https://kubernetes.github.io/ingress-nginx/deploy/) installed in the cluster
- [cert-manager](https://cert-manager.io/docs/installation/) installed in the cluster (optional)
- [external-dns](https://github.com/kubernetes-sigs/external-dns) installed in the cluster (optional)
- [H2 database credential](https://github.com/epam/ai-dial-admin-backend/blob/development/secrets-utils/keys_generator.py) generate special keys for H2 database and store them inside of Azure Keyvault service


## Expected Outcome

By following the instructions in this guide, you will successfully install the AI DIAL Admin system with export AI DIAL configuration features enabled.
Please note that this guide represents a very basic deployment scenario, and **should never be used in production**.
Configuring Ingress allowlisting and other security measures are **out of scope** of this guide.

## Install

1. Create Kubernetes namespace, e.g. `dial-admin`

    **Command:**

    ```sh
    kubectl create namespace dial-admin
    ```

    **Output:**

    ```console
    namespace/dial-admin created
    ```

1. Copy [values.yaml](values.yaml) file to your working directory and fill in missing values:
    - Replace `%%CONFIGMAP_EXPORT_NAMES%%` with kubernetes secret name which contains dial configuration json, e.g. `core-config-secret`
    - Replace `%%SECRET_EXPORT_KEY%%` with kubernetes secret key with dial configuration, e.g. `env.config.json`
    - Replace `%%CONFIG_EXPORT_NAMESPACE%%` kubernetes namespace where ai-dial installed
    - Replace `%%THEMES_URL%%` with public DIAL themes url
    - Replace `%%DOMAIN%%` with your domain name, e.g. `example.com`
    - Replace `%%NEXTAUTH_SECRET%%` with generated value (`openssl rand -base64 64`)
    - Replace `%%KEY_VAULT_URL%%` with azure keyvault url, ex. https://keyvault-example.vault.azure.net/ 
    - Replace `KEYVAULT_SECRETS_ARRAY` with list of keyvault secrets with dial configuration json.
    - Replace `%%AZURE_CLIENT_ID%%` with a unique identifier for the client application registered in Azure Active Directory (AD). It is used to authenticate the client application when accessing Azure AD resources.
    - Replace `%%AZURE_TENANT_ID%%` with a Tenant ID refers to a globally unique identifier (GUID) that represents a specific Azure AD tenant. It is used to identify and authenticate the Azure AD tenant that the client application belongs to.
    - Replace `%%AZURE_CLIENT_SECRET%%` with a client secret or application secret, this parameter is a confidential string that authenticates and authorizes the client application to access Azure AD resources. It serves as a password for the client application.
    - Replace `%%AZURE_EXPOSE_CLIENT_ID%%` id with a unique identifier for the client application registered in Azure Active Directory (AD) which is used to expose an API .
    - Replace `%%MANAGED_IDENTITY_CLIENT_ID%%` id with a unique identifier for backend managed identity.
    - It's assumed you've configured **external-dns** and **cert-manager** beforehand, so replace `%%CLUSTER_ISSUER%%` with your cluster issuer name, e.g. `letsencrypt-production`

1. Install `dial` helm chart in created namespace, applying custom values file:

2. Install `dial-admin` helm chart in created namespace, applying custom values file:

    **Command:**

    ```sh
    helm install dial-admin dial/dial-admin -f values.yaml --namespace dial-admin
    ```
    **Output:**

    ```console
    Release "dial-admin" does not exist. Installing it now.
    NAME: dial-admin
    LAST DEPLOYED: Wed Jul 16 18:44:10 2025
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

3. Now you can access:
    - Chat by the following URL: `https://chat.%%DOMAIN%%/`, e.g. `https://chat.example.com/`
    - API by the following URL: `https://dial.%%DOMAIN%%/`, e.g. `https://dial.example.com/`
      - Use previously generated `%%DIAL_API_KEY%%` value

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