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

import ballerina/file;
import ballerina/http;
import ballerina/io;
import ballerinax/hubspot.crm.obj.contacts;

configurable string csvFilePath = ?;

configurable contacts:OAuth2RefreshTokenGrantConfig & readonly auth = ?;

contacts:Client contactClient = check new ({auth});

public function main() returns error? {
    // load the csv file data into an 2D array if exists
    // format of the csv data shoud be as follows:
    // email --- action ---
    boolean fileExists = check file:test(csvFilePath, file:EXISTS);
    if (!fileExists) {
        io:println("file does not exists: " + csvFilePath);
        return;
    }

    io:println("[TASK] loading csv data");
    string[][] csvData = check io:fileReadCsv(csvFilePath, 1);
    io:println("[TASK] finish loading csv data");


    io:println("[TASK] start fetching contacts from API");
    // fetch the contacts from the contacts API
    contacts:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging contactsResponse = check contactClient->/('limit = 100, properties = ["email"], propertiesWithHistory = []);

    // get the id with their emails
    map<string> contactsWithEmails = {};
    foreach int i in int:range(0, contactsResponse.results.length(), 1) {
        if (contactsResponse.results[i].properties["email"] !== ()) {
            string email = contactsResponse.results[i].properties["email"].toString();
            contactsWithEmails[email] = contactsResponse.results[i].id;
        }
    }

    // iterate through the email in the csv file and take the action mentioned in the `action` column
    // possible actions as follow:
    // UNSUBSCRIBE: unsubsribe from email advertiesments
    // DELETE: remove the contacts from the system
    io:println("[TASK] start unsubscribing and deleting customers via HubSpot");
    foreach string[] row in csvData {
        string email = row[0];
        string action = row[1];

        match action {
            "UNSUBSCRIBE" => {
                check unsubscribeCustomer(email, contactsWithEmails);
            }

            "DELETE" => {
                check deleteCustomer(email, contactsWithEmails);
            }

            _ => {
                // done nothing
            }
        }
    }

    io:println("[TASK] finish all the tasks");
}

public function unsubscribeCustomer(string email, map<string> contactsWithEmail) returns error? {    
    if (contactsWithEmail.hasKey(email)) {
        // get the id of the contact with given email
        string? id = contactsWithEmail[email];
        // update the contact with the given email as removed from subscribers
        contacts:SimplePublicObject response = check contactClient->/[id.toString()].patch({
            properties: {
                "opt-out": "true"
            }
        });
    }
}

public function deleteCustomer(string email, map<string> contactsWithEmail) returns error? {
    if (contactsWithEmail.hasKey(email)) {
        // get the id of the contact with given email
        string? id = contactsWithEmail[email];
        // delete the contact with customer with given id
        http:Response response = check contactClient->/[id.toString()].delete();
    }
}
