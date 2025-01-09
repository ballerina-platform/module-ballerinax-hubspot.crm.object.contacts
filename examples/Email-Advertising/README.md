## Unsubscribe and Remove Customers from Advertisement Groups

This use case demonstrates how the **HubSpot Contacts Connector** can be used to **unsubscribe and remove customers from advertisement groups**. By leveraging the connector, you can easily retrieve contact information and update or delete details related to advertisement campaigns.

## Prerequisites

### 1. Setup Hubspot developer account

Refer to the [Setup guide](../../ballerina/Package.md#setup-guide) to obtain necessary credentials (client Id, client secret, refresh tokens).

### 2. Configuration

Create a `Config.toml` file in the example's root directory and, provide your Hubspot account related configurations as follows:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
credentialBearer =  "POST_BODY_BEARER"
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```