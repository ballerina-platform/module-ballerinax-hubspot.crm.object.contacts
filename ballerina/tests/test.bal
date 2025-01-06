// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
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

configurable OAuth2RefreshTokenGrantConfig & readonly authConfig = ?;

Client baseClient = check new (config = {auth: authConfig});

const int contactToContactAssociationTypeId = 449;
string testContactId = "";

@test:Config {
    dependsOn: [testCreateBatchOfContacts]
}
function testMergeTwoContactsWithSameType() returns error? {
    // create a another contact to be merged
    string testFirstName = "jimmy";
    SimplePublicObject|error newContact = baseClient->/.post({
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
    string newContactId = newContact is SimplePublicObject ? newContact.id : "";
    // merge the two contacts created
    SimplePublicObject|error response = baseClient->/merge.post({
        objectIdToMerge: testContactId,
        primaryObjectId: newContactId
    });
    test:assertTrue(response is SimplePublicObject);
}

@test:Config {}
function testArchiveBatchOfContactsById() returns error? {
    string contactId = "4243242";
    http:Response|error response = check baseClient->/batch/archive.post({
        inputs: [
            {
                id: contactId
            }
        ]
    });

    test:assertTrue(response is http:Response && response.statusCode == 204);

}

@test:Config {
    dependsOn: [testCreateContact]
}
function testReadBatchOfContactsByInternalIdOrUniquePropertyValues() returns error? {
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error response = baseClient->/batch/read.post({
        propertiesWithHistory: ["firstname"],
        idProperty: "email",
        inputs: [
            {
                id: testContactId
            }
        ],
        properties: ["firstname"]
    });

    test:assertTrue(response is BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors);

}

@test:Config {}
function testCreateContact() returns error? {
    string testFirstName = "john";
    SimplePublicObject|error response = baseClient->/.post({
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
    testContactId = response is SimplePublicObject ? response.id : "";
    test:assertTrue(response is SimplePublicObject && response.properties["firstname"] == testFirstName);
}

@test:Config {}
function testGetPageOfContacts() returns error? {
    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging|error response = baseClient->/();
    test:assertTrue(response is CollectionResponseSimplePublicObjectWithAssociationsForwardPaging);
}

@test:Config {
    dependsOn: [testCreateContact]
}
function testGetContactByContactId() returns error? {
    SimplePublicObjectWithAssociations|error response = baseClient->/[testContactId]();
    test:assertTrue(response is SimplePublicObjectWithAssociations && response.id == testContactId);
}

@test:Config {
    dependsOn: [testGetContactByContactId]
}
function testPartialUpdateOfContactByContactId() returns error? {
    string testNewFirstName = "johny";
    SimplePublicObject|error response = baseClient->/[testContactId].patch({
        objectWriteTraceId: "1",
        properties: {
            "firstname": testNewFirstName
        }
    });
    test:assertTrue(response is SimplePublicObject && response.properties["firstname"] == testNewFirstName);
}

@test:Config {
    dependsOn: [testMergeTwoContactsWithSameType]
}
function testDeleteContactById() returns error? {
    http:Response|error response = baseClient->/[testContactId].delete();
    test:assertTrue(response is http:Response && response.statusCode == 204);
}

@test:Config {
    dependsOn: [testUpsertBatchOfContacts]
}
function testCreateBatchOfContacts() returns error? {
    string testFirstName = "gayumi";
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error response = baseClient->/batch/create.post({
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
    test:assertTrue(response is BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors);

}

@test:Config {}
function testSearch() returns error? {
    string testSearchQuery = "john";
    CollectionResponseWithTotalSimplePublicObjectForwardPaging|error response = baseClient->/search.post({
        query: testSearchQuery,
        'limit: 1,
        after: "0"
    });
    test:assertTrue(response is CollectionResponseWithTotalSimplePublicObjectForwardPaging && response.total >= 0);
}

@test:Config {
    dependsOn: [testDeleteContactById]
}
function testGDPRDelete() returns error? {
    http:Response|error response = baseClient->/gdpr\-delete.post({
        objectId: testContactId
    });
    test:assertTrue(response is http:Response && response.statusCode == 204);

}

@test:Config {}
function testBatchRead() returns error? {
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error response = baseClient->/batch/read.post({
        propertiesWithHistory: ["firstname"],
        idProperty: "",
        inputs: [
            {
                id: testContactId
            }
        ],
        properties: ["firstname"]
    });
    test:assertTrue(response is BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors);

}

@test:Config {
    dependsOn: [testPartialUpdateOfContactByContactId]
}
function testUpsertBatchOfContacts() returns error? {
    string testUpdatedFirstName = "johnee";
    string testEmail = "johnee@example.com";
    BatchResponseSimplePublicUpsertObject|BatchResponseSimplePublicUpsertObjectWithErrors|error response = baseClient->/batch/upsert.post({
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
    test:assertTrue(response is BatchResponseSimplePublicUpsertObject|BatchResponseSimplePublicUpsertObjectWithErrors);
}
