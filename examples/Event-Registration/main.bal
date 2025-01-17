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

import ballerina/io;
import ballerinax/hubspot.crm.obj.contacts;

configurable string csvFilePath = ?;
configurable string task = ?;

configurable contacts:OAuth2RefreshTokenGrantConfig & readonly auth = ?;

final contacts:Client contactClient = check new ({auth});

public function main() returns error? {

    io:println("[TASK] loading csv data");
    string[][] csvData = check io:fileReadCsv(csvFilePath, 1);
    io:println("[TASK] finish loading csv data");

    match task {
        "REGISTER" => {
            check registerParticipants(csvData);
        }
        "ATTENDANCE" => {
            check markBatchAttendance(csvData);
        }
        _ => {
            io:println("task is not defined");
            return;
        }
    }

    return;
}

public function registerParticipants(string[][] csvData) returns error? {
    // create input list with information of the registrants
    contacts:SimplePublicObjectInputForCreate[] inputs = [];

    // push registrants information into the inputs in the following format
    foreach string[] row in csvData {
        // csv data should include following columns:
        // email -- first name -- last name -- company
        string email = row[0];
        string firstName = row[1];
        string lastName = row[2];
        string company = row[3];

        inputs.push({
            properties: {
                "email": email,
                "firstname": firstName,
                "lastname": lastName,
                "company": company
            }
        });
    }

    io:println("[TASK] start calling API");
    // call the batch create endpoint via client 
    contacts:BatchResponseSimplePublicObject|contacts:BatchResponseSimplePublicObjectWithErrors response = check contactClient->/batch/create.post({
        inputs
    });

    if (response is contacts:BatchResponseSimplePublicObjectWithErrors) {
        io:println("[ERROR] there are errors associated with the request");
    } else {
        io:println("[TASK] REGISTRATION INFO STATUS: ", response.status);
        io:println("[TASK] finished all tasks");
    }

}

public function markBatchAttendance(string[][] csvData) returns error? {

    contacts:SimplePublicObjectBatchInputUpsert[] inputs = [];

    foreach string[] row in csvData {
        string email = row[0];
        string attendance = row[1];
        string followUpDate = row[2];

        inputs.push({
            idProperty: "email",
            id: email,
            properties: {
                "event_attended": attendance,
                "follow_up_date": followUpDate
            }
        });
    }

    io:println("[TASK] start calling API");
    // call the batch upsert endpoint via client
    contacts:BatchResponseSimplePublicUpsertObject|contacts:BatchResponseSimplePublicUpsertObjectWithErrors response = check contactClient->/batch/upsert.post({
        inputs
    });

    if (response is contacts:BatchResponseSimplePublicUpsertObjectWithErrors) {
        io:println("[ERROR] there are errors associated with the request");
    } else {
        io:println("[TASK] UPDATING INFO STATUS: ", response.status);
        io:println("[TASK] finished all tasks");
    }

}
