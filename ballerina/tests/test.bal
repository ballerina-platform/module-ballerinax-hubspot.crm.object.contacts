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
import ballerina/test;

configurable OAuth2RefreshTokenGrantConfig & readonly auth = ?;

Client hubSpotCrmContact = check new ({ auth });

const int CONTACT_TO_CONTACT_ASSOCIATION_TYPE_ID = 449;
string testContactId = "";

@test:Config {
    dependsOn: [testCreateBatchOfContacts]
}
function testMergeTwoContactsWithSameType() returns error? {
    // create a another contact to be merged
    string testFirstName = "jimmy";
    SimplePublicObject newContact = check hubSpotCrmContact->/.post({
        associations: [
            {
                to: {
                    id: "1"
                }
            }
        ],
        objectWriteTraceId: "1",
        properties: {
            "firstname": testFirstName
        }
    });
    string newContactId = newContact.id;
    // merge the two contacts created
    SimplePublicObject response = check hubSpotCrmContact->/merge.post({
        objectIdToMerge: testContactId,
        primaryObjectId: newContactId
    });
    test:assertTrue(response.id.length() > 0);
}

@test:Config {}
function testArchiveBatchOfContactsById() returns error? {
    string contactId = "4243242";
    http:Response response = check hubSpotCrmContact->/batch/archive.post({
        inputs: [
            {
                id: contactId
            }
        ]
    });

    test:assertEquals(response.statusCode, 204);
}

@test:Config {
    dependsOn: [testCreateContact]
}
function testReadBatchOfContactsByInternalIdOrUniquePropertyValues() returns error? {
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubSpotCrmContact->/batch/read.post({
        propertiesWithHistory: ["firstname"],
        idProperty: "email",
        inputs: [
            {
                id: testContactId
            }
        ],
        properties: ["firstname"]
    });

    string[] statuses = ["PENDING", "PROCESSING", "CANCELED", "COMPLETE"];
    test:assertTrue(statuses.filter(status => status == response.status).length() > 0);
}

@test:Config {}
function testCreateContact() returns error? {
    string testFirstName = "john";
    SimplePublicObject response = check hubSpotCrmContact->/.post({
        associations: [
            {
                to: {
                    id: "1"
                }
            }
        ],
        objectWriteTraceId: "1",
        properties: {
            "firstname": testFirstName
        }
    });
    // set the test contact id as created one
    testContactId = response.id;
    test:assertEquals(response.properties["firstname"], testFirstName);
}

@test:Config {}
function testGetPageOfContacts() returns error? {
    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check hubSpotCrmContact->/();
    test:assertTrue(response.results.length() >= 0);
}

@test:Config {
    dependsOn: [testCreateContact]
}
function testGetContactByContactId() returns error? {
    SimplePublicObjectWithAssociations response = check hubSpotCrmContact->/[testContactId]();
    test:assertEquals(response.id, testContactId);
}

@test:Config {
    dependsOn: [testGetContactByContactId]
}
function testPartialUpdateOfContactByContactId() returns error? {
    string testNewFirstName = "johny";
    SimplePublicObject response = check hubSpotCrmContact->/[testContactId].patch({
        objectWriteTraceId: "1",
        properties: {
            "firstname": testNewFirstName
        }
    });
    test:assertEquals(response.properties["firstname"], testNewFirstName);
}

@test:Config {
    dependsOn: [testMergeTwoContactsWithSameType]
}
function testDeleteContactById() returns error? {
    http:Response response = check hubSpotCrmContact->/[testContactId].delete();
    test:assertEquals(response.statusCode, 204);
}

@test:Config {
    dependsOn: [testUpsertBatchOfContacts]
}
function testCreateBatchOfContacts() returns error? {
    string testFirstName = "gayumi";
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubSpotCrmContact->/batch/create.post({
        inputs: [
            {
                associations: [   
                ],
                properties: {
                    "firstname": testFirstName
                }
            }
        ]
    });
    
    string[] statuses = ["PENDING", "PROCESSING", "CANCELED", "COMPLETE"];
    test:assertTrue(statuses.filter(status => status == response.status).length() > 0);
}

@test:Config {}
function testSearch() returns error? {
    string testSearchQuery = "john";
    CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check hubSpotCrmContact->/search.post({
        query: testSearchQuery,
        'limit: 1,
        after: "0"
    });
    test:assertTrue(response.total >= 0);
}

@test:Config {
    dependsOn: [testDeleteContactById]
}
function testGDPRDelete() returns error? {
    http:Response response = check hubSpotCrmContact->/gdpr\-delete.post({
        objectId: testContactId
    });
    test:assertEquals(response.statusCode, 204);
}

@test:Config {}
function testBatchRead() returns error? {
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubSpotCrmContact->/batch/read.post({
        propertiesWithHistory: ["firstname"],
        idProperty: "",
        inputs: [
            {
                id: testContactId
            }
        ],
        properties: ["firstname"]
    });
    
    string[] statuses = ["PENDING", "PROCESSING", "CANCELED", "COMPLETE"];
    test:assertTrue(statuses.filter(status => status == response.status).length() > 0);
}

@test:Config {
    dependsOn: [testPartialUpdateOfContactByContactId]
}
function testUpsertBatchOfContacts() returns error? {
    string testUpdatedFirstName = "johnee";
    string testEmail = "johnee@example.com";
    BatchResponseSimplePublicUpsertObject|BatchResponseSimplePublicUpsertObjectWithErrors response = check hubSpotCrmContact->/batch/upsert.post({
        inputs: [
            {
                idProperty: "email",
                id: testEmail,
                properties: {
                    "firstname": testUpdatedFirstName
                }
            }
        ]
    });
    
    string[] statuses = ["PENDING", "PROCESSING", "CANCELED", "COMPLETE"];
    test:assertTrue(statuses.filter(status => status == response.status).length() > 0);
}
