## Event Registration and Follow-up Date Updating via Batch Updates

This use case demonstrates how you can manage **event registrations** and **follow-up date updates** through **batch updates** using contact information extracted from **CSV files**. By utilizing batch operations via the HubSpot Contacts API, you can efficiently update follow-up dates for event attendees.

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