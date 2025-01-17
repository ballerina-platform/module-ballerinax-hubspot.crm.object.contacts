_Author_:  @ShavinAnjithaAlpha
_Created_: 2025/01/06
_Updated_: 2025/01/06
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Ballerina HubSpot CRM Contacts Connector. 
The OpenAPI specification is obtained from [HubSpot CRM Contact OPenAPI Documentation](https://github.com/HubSpot/HubSpot-public-api-spec-collection/blob/main/PublicApiSpecs/CRM/Contacts/Rollouts/424/v3/contacts.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. **Change the `url` property of the `servers` object**:

    - **Original**: [https://api.hubapi.com](https://api.hubapi.com)
    - **Updated**: [https://api.hubapi.com/crm/v3/objects/contacts](https://api.hubapi.com/crm/v3/objects/contacts)
    - **Reason**: This change is made to ensure that all API paths are relative to the versioned base URL (/3), which improves the consistency and usability of the APIs.

2. **Update API Paths**:

    - **Original**: Paths included the version prefix in each endpoint (e.g., /crm/v3/objects/contacts).
    - **Updated**: Paths are modified to remove the common prefix from the endpoints, as it is now included in the base URL. For example:
        - **Original**: /crm/v3/objects/contacts/batch/create
        - **Updated**: /batch/create 
    - **Reason**: This modification simplifies the API paths, making them shorter and more readable. It also centralizes the versioning to the base URL, which is a common best practice.


## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina
```
Note: The license year is hardcoded to 2025, change if necessary.
