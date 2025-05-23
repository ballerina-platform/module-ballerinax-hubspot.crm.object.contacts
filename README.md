# Ballerina Ballerina HubSpot CRM Contacts Connector connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.contacts/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.contacts/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-hubspot.crm.object.contacts.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.contacts/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/hubspot.crm.object.contacts.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%hubspot.crm.object.contacts)

## Overview

[HubSpot](https://www.hubspot.com) is an AI-powered customer relationship management (CRM) platform.

The `ballerinax/module-ballerinax-hubspot.crm.obj.contacts` package offers APIs to connect and interact with the [HubSpot Contact API](https://api.hubapi.com/crm/v3/objects/contacts) endpoints, specifically based on the [HubSpot REST API](https://developers.hubspot.com/docs/reference/api/crm/objects/contacts).

Using this API, users can develop applications easily that enables you to manage contacts easily.

## Setup guide

To use the HubSpot connector, you must have access to the HubSpot API through a [HubSpot developer account](https://developers.hubspot.com/get-started) and a project under it. If you do not have a HubSpot Developer account, you can sign up for one [here](https://app.hubspot.com/signup-hubspot/developers?_ga=2.207749649.2047916093.1734412948-232493525.1734412948&step=landing_page).

### Step 1: Create a HubSpot Developer Project

1. Open the [HubSpot Developer Portal](https://app.hubspot.com/login/?loginRedirectUrl=https%3A%2F%2Fapp.hubspot.com%2Fsignup-hubspot%2Fdevelopers%3F_ga%3D2.269102326.624948025.1734413225-1764281074.1734413225%26step%3Dlanding_page)

2. Click on the 'App' tab and select an existing project or create a new project for which you want API keys and Authentication Access.

![hubspot-app-home](https://github.com/user-attachments/assets/8f14b6d5-f537-41fe-a860-1f5fe9489b1c)

In order to create a new project, you must provide a public app name and a redirect url/s. Optionally you can add a app logo and a description for the app.

![hubspot-new-app-info](https://github.com/user-attachments/assets/9985a3b4-b540-4f8e-9607-04f384f229b0)

To add redirect url/s for the app, click the 'Auth' tab on top of the page, and navigate to 'Redirect URLs' section.

![hubspot-new-app-auth](https://github.com/user-attachments/assets/85bff298-0c54-4edb-8620-2f244b8eeb5b)

![hubspot-new-app-redirect-url](https://github.com/user-attachments/assets/fff04140-2445-411d-9dca-f8b6596f678b)

### Step 2. Obtain Client ID and Client Secret

1. After completing the project setup, you will be provided with your client id and client secret.  Make sure to save the provided client id and client secret.

![hubspot-new-app-client-id-secret](https://github.com/user-attachments/assets/bc2f76ad-91a9-452f-b35f-0344f130beb8)

### 2. Setup OAuth 2.0 Flow

Before proceeding with Quick start, ensure you ave obtained the Access Token and refresh Token using the following steps:

1. Add the following scopes for using the Contact API:

    - `crm.objects.contacts.write`
    - `crm.objects.contacts.read`

2. Obtain the authorization URL (Install URL) from the Auth Section under 'Sample install URL (OAuth)' section.  It will be in this format:

    ```
    https://app.hubspot.com/oauth/authorize?client_id=<client_id>&redirect_uri=<redirect_url>&scope=<scopes>
    ```

3. Copy and paste the generated URL into your browser. This will redirect you to the HubSpot authorization page.

    ![hubspot-oauth-consent-screen](https://github.com/user-attachments/assets/d503ef64-f3e4-4959-a3ee-b390c5c9bc62)

4. Once you authorize, you will be redirected to your specified redirect URI with an authorization code in the URL.

    > **Note**: Store the authorization code and use it promptly as it expires quickly.

5. Use the obtained authorization code to run the following curl command, replacing `<your_client_id>`, `<your_redirect_url>`, and `<your_authorization_code>` with your specific values:

    - Linux/MacOS:

    ```bash
    curl --request POST \
    --url https://api.hubapi.com/oauth/v1/token \
    --header 'content-type: application/x-www-form-urlencoded' \
    --data 'grant_type=authorization_code&code=<your_authorization_code>&redirect_uri=<your_redirect_url>&client_id=<your_client_id>&client_secret=<your_client_secret>'
    ```

    - Windows:

    ```bash
    curl --request POST \
    --url https://api.hubapi.com/oauth/v1/token ^
    --header 'content-type: application/x-www-form-urlencoded' ^
    --data 'grant_type=authorization_code&code=<your_authorization_code>&redirect_uri=<your_redirect_url>&client_id=<your_client_id>&client_secret=<your_client_secret>'
    ```

    This command will return the access token and refresh token necessary for API calls.

    ```json
    {
    "token_type": "bearer",
    "refresh_token": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "access_token": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "expires_in": 1800
    }
    ```

 6. Store the access token securely for use in your application.

## Quickstart

To use the `HubSpot CRM Contact Connector` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `ballerinax/hubspot.crm.obj.contacts` module.

````ballerina
import ballerinax/hubspot.crm.obj.contacts;
````

### Step 2: Instantiate a new connector

1. Create a `OAuth2RefreshTokenGrantConfig` with the obtained access token and initialize the connector with it.

    ```ballerina
    configurable OAuth2RefreshTokenGrantConfig & readonly auth = ?;

    final contacts:Client hubSpotContacts = check new ({ auth });
    ```

2. Create a Config.toml file and, configure the obtained credentials in the above steps as follows:

    ````toml
    [auth]
    clientId = "<Client Id>"
    clientSecret =  "<Client Secret>"
    refreshToken = "<Refresh Token>"
    credentialBearer =  "POST_BODY_BEARER"
    ````

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Create a contact

```ballerina
contacts:SimplePublicObjectInputForCreate newContact = {
    associations: [
        {
            to: {
                id: "associated_id"
            }
        }
    ],
    objectWriteTraceId: "object_write_trace_id",
    properties: {
        "sample_property": "sample_value"
    }
};

contacts:SimplePublicObject response = check hubSpotContacts->/.post(newContact);
```

#### List contacts

```ballerina
contacts:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging contacts = check hubSpotContacts->/.get();
```

### Step 4: Run the Ballerina application

````bash
bal run
````

## Examples

The `Ballerina HubSpot CRM Contacts Connector` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/module-ballerinax-hubspot.crm.object.contacts/tree/main/examples/), covering the following use cases:

1. [Email-Advertising](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.contacts/tree/main/examples/Email-Advertising) - Unsubscribe and remove customers based on email addresses of CSV-imported data.
2. [Event-Registration](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.contacts/tree/main/examples/Event-Registration) - Event registration and follow-up using CSV-imported data.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`hubspot.crm.object.contacts` package](https://central.ballerina.io/ballerinax/hubspot.crm.obj.contacts/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
