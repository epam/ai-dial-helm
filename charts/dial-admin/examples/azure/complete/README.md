# AI DIAL ADMIN Complete Installation Azure provider with keyvault export integration guide with Azure MSSQL database and AGIC integration 

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
- [Azure keyvault](https://learn.microsoft.com/en-us/azure/key-vault/) configured
- [2 Azure App registrations](https://github.com/epam/ai-dial-admin-backend/blob/development/docs/azure_configuration.md)
- [Static IP address](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-addresses) reserved for Chat
- [DNS records](https://learn.microsoft.com/en-us/azure/dns/public-dns-overview) configured for Chat
- [Azure-managed SSL certificates](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-app-service-certificate) issued for Chat
- [Application Gateway Ingress Controller](https://github.com/Azure/application-gateway-kubernetes-ingress) installed and configured
- [Azure SQL database](https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?view=azuresql) configured with [user-password access](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-user-transact-sql?view=sql-server-ver16#azure_active_directory_principal) 
- [external-dns](https://github.com/kubernetes-sigs/external-dns) installed in the cluster (optional)


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
    - Replace `%%AZURE_MSSQL_HOST%%` with MSSQL server database name
    - Replace `%%AZURE_MSSQL_USER%%` with MSSQL login username
    - Replace `%%AZURE_MSSQL_USER_PASSWORD%%` with MSSQL login password

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
    CHART VERSION: 0.4.1
    APP VERSION: 0.4.1
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
