// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

service on new http:Listener(9090) {
    # Archive
    #
    # + return - returns can be any of following types 
    # http:NoContent (No content)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function delete [string contactId]() returns http:NoContent {
        return http:NO_CONTENT;
    }

    # List
    #
    # + 'limit - The maximum number of results to display per page.
    # + after - The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results.
    # + properties - A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored.
    # + propertiesWithHistory - A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored. Usage of this parameter will reduce the maximum number of objects that can be read by a single request.
    # + associations - A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored.
    # + archived - Whether to return only results that have been archived.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get .(string? after, string[]? properties, string[]? propertiesWithHistory, string[]? associations, int:Signed32 'limit = 10, boolean archived = false) returns CollectionResponseSimplePublicObjectWithAssociationsForwardPaging {
        return {
            "paging": {
                "next": {
                    "link": "?after=NTI1Cg%3D%3D",
                    "after": "NTI1Cg%3D%3D"
                }
            },
            "results": [
                {
                    "associations": {
                        "additionalProp1": {
                            "paging": {
                                "next": null,
                                "prev": {
                                    "before": "string",
                                    "link": "string"
                                }
                            },
                            "results": [
                                {
                                    "id": "string",
                                    "type": "string"
                                }
                            ]
                        },
                        "additionalProp2": {
                            "paging": {
                                "next": null,
                                "prev": {
                                    "before": "string",
                                    "link": "string"
                                }
                            },
                            "results": [
                                {
                                    "id": "string",
                                    "type": "string"
                                }
                            ]
                        }
                    },
                    "createdAt": "2025-01-09T17:04:57.288Z",
                    "archived": true,
                    "archivedAt": "2025-01-09T17:04:57.288Z",
                    "propertiesWithHistory": {
                        "additionalProp1": [
                            {
                                "sourceId": "string",
                                "sourceType": "string",
                                "sourceLabel": "string",
                                "updatedByUserId": 0,
                                "value": "string",
                                "timestamp": "2025-01-09T17:04:57.288Z"
                            }
                        ],
                        "additionalProp2": [
                            {
                                "sourceId": "string",
                                "sourceType": "string",
                                "sourceLabel": "string",
                                "updatedByUserId": 0,
                                "value": "string",
                                "timestamp": "2025-01-09T17:04:57.288Z"
                            }
                        ]
                    },
                    "id": "string",
                    "properties": {
                        "additionalProp1": "string",
                        "additionalProp2": "string",
                        "additionalProp3": "string"
                    },
                    "updatedAt": "2025-01-09T17:04:57.288Z"
                }
            ]
        };
    }

    # Read
    #
    # + properties - A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored.
    # + propertiesWithHistory - A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored.
    # + associations - A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored.
    # + archived - Whether to return only results that have been archived.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get [string contactId](string[]? properties, string[]? propertiesWithHistory, string[]? associations, boolean archived = false) returns SimplePublicObjectWithAssociations {
        return {
            "associations": {
                "additionalProp1": {
                    "paging": {
                        "next": {
                            "link": "?after=NTI1Cg%3D%3D",
                            "after": "NTI1Cg%3D%3D"
                        },
                        "prev": {
                            "before": "string",
                            "link": "string"
                        }
                    },
                    "results": [
                        {
                            "id": "string",
                            "type": "string"
                        }
                    ]
                },
                "additionalProp2": {
                    "paging": {
                        "next": {
                            "link": "?after=NTI1Cg%3D%3D",
                            "after": "NTI1Cg%3D%3D"
                        },
                        "prev": {
                            "before": "string",
                            "link": "string"
                        }
                    },
                    "results": [
                        {
                            "id": "string",
                            "type": "string"
                        }
                    ]
                }
            },
            "createdAt": "2025-01-09T17:04:57.293Z",
            "archived": true,
            "archivedAt": "2025-01-09T17:04:57.293Z",
            "propertiesWithHistory": {
                "additionalProp1": [
                    {
                        "sourceId": "string",
                        "sourceType": "string",
                        "sourceLabel": "string",
                        "updatedByUserId": 0,
                        "value": "string",
                        "timestamp": "2025-01-09T17:04:57.293Z"
                    }
                ],
                "additionalProp2": [
                    {
                        "sourceId": "string",
                        "sourceType": "string",
                        "sourceLabel": "string",
                        "updatedByUserId": 0,
                        "value": "string",
                        "timestamp": "2025-01-09T17:04:57.293Z"
                    }
                ]
            },
            "id": contactId,
            "properties": {
                "additionalProp1": "string",
                "additionalProp2": "string",
                "additionalProp3": "string"
            },
            "updatedAt": "2025-01-09T17:04:57.293Z"
        };
    }

    # Update
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function patch [string contactId](@http:Payload SimplePublicObjectInput payload) returns SimplePublicObject {
        return {
            "createdAt": "2025-01-09T17:04:57.303Z",
            "archived": false,
            "archivedAt": "2025-01-09T17:04:57.303Z",
            "propertiesWithHistory": {
                "additionalProp1": [
                    {
                        "sourceId": "string",
                        "sourceType": "string",
                        "sourceLabel": "string",
                        "updatedByUserId": 0,
                        "value": "string",
                        "timestamp": "2025-01-09T17:04:57.303Z"
                    }
                ],
                "additionalProp2": [
                    {
                        "sourceId": "string",
                        "sourceType": "string",
                        "sourceLabel": "string",
                        "updatedByUserId": 0,
                        "value": "string",
                        "timestamp": "2025-01-09T17:04:57.303Z"
                    }
                ]
            },
            "id": "512",
            "properties": payload.properties,
            "updatedAt": "2025-01-09T17:04:57.303Z"
        };
    }

    # Create
    #
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post .(@http:Payload SimplePublicObjectInputForCreate payload) returns SimplePublicObject {
        return {
            "createdAt": "2025-01-09T17:04:57.298Z",
            "archived": false,
            "archivedAt": "2025-01-09T17:04:57.298Z",
            "propertiesWithHistory": {
                "additionalProp1": [
                    {
                        "sourceId": "string",
                        "sourceType": "string",
                        "sourceLabel": "string",
                        "updatedByUserId": 0,
                        "value": "string",
                        "timestamp": "2025-01-09T17:04:57.298Z"
                    }
                ],
                "additionalProp2": [
                    {
                        "sourceId": "string",
                        "sourceType": "string",
                        "sourceLabel": "string",
                        "updatedByUserId": 0,
                        "value": "string",
                        "timestamp": "2025-01-09T17:04:57.298Z"
                    }
                ]
            },
            "id": "512",
            "properties": payload.properties,
            "updatedAt": "2025-01-09T17:04:57.298Z"
        };
    }

    # Archive a batch of contacts by ID
    #
    # + return - returns can be any of following types 
    # http:NoContent (No content)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/archive(@http:Payload BatchInputSimplePublicObjectId payload) returns http:NoContent {
        return http:NO_CONTENT;
    }

    # Create a batch of contacts
    #
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/create(@http:Payload BatchInputSimplePublicObjectInputForCreate payload) returns BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrorsMultiStatus {
        return {
            "completedAt": "2025-01-09T17:04:57.262Z",
            "requestedAt": "2025-01-09T17:04:57.262Z",
            "startedAt": "2025-01-09T17:04:57.262Z",
            "links": {
                "additionalProp1": "string",
                "additionalProp2": "string",
                "additionalProp3": "string"
            },
            "results": [
                {
                    "createdAt": "2025-01-09T17:04:57.262Z",
                    "archived": false,
                    "archivedAt": "2025-01-09T17:04:57.262Z",
                    "propertiesWithHistory": {
                        "additionalProp1": [
                            {
                                "sourceId": "string",
                                "sourceType": "string",
                                "sourceLabel": "string",
                                "updatedByUserId": 0,
                                "value": "string",
                                "timestamp": "2025-01-09T17:04:57.262Z"
                            }
                        ],
                        "additionalProp2": [
                            {
                                "sourceId": "string",
                                "sourceType": "string",
                                "sourceLabel": "string",
                                "updatedByUserId": 0,
                                "value": "string",
                                "timestamp": "2025-01-09T17:04:57.262Z"
                            }
                        ],
                        "additionalProp3": [
                            {
                                "sourceId": "string",
                                "sourceType": "string",
                                "sourceLabel": "string",
                                "updatedByUserId": 0,
                                "value": "string",
                                "timestamp": "2025-01-09T17:04:57.262Z"
                            }
                        ]
                    },
                    "id": "512",
                    "properties": {
                        "property_date": "1572480000000",
                        "property_radio": "option_1",
                        "property_number": "17",
                        "property_string": "value",
                        "property_checkbox": "false",
                        "property_dropdown": "choice_b",
                        "property_multiple_checkboxes": "chocolate;strawberry"
                    },
                    "updatedAt": "2025-01-09T17:04:57.262Z"
                }
            ],
            "status": "PENDING"
        };
    }

    # Gdpr-delete
    #
    # + return - returns can be any of following types 
    # http:NoContent (No content)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post gdpr\-delete(@http:Payload PublicGdprDeleteInput payload) returns http:NoContent {
        return http:NO_CONTENT;
    }
};
