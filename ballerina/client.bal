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

import ballerina/data.jsondata;
import ballerina/http;

public isolated client class Client {
    final http:Client clientEp;
    final readonly & ApiKeysConfig? apiKeyConfig;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.hubapi.com/crm/v3/objects/contacts") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, http1Settings: config.http1Settings, http2Settings: config.http2Settings, timeout: config.timeout, forwarded: config.forwarded, followRedirects: config.followRedirects, poolConfig: config.poolConfig, cache: config.cache, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, cookieConfig: config.cookieConfig, responseLimits: config.responseLimits, secureSocket: config.secureSocket, proxy: config.proxy, socketConfig: config.socketConfig, validation: config.validation, laxDataBinding: config.laxDataBinding};
        if config.auth is ApiKeysConfig {
            self.apiKeyConfig = (<ApiKeysConfig>config.auth).cloneReadOnly();
        } else {
            httpClientConfig.auth = <http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig>config.auth;
            self.apiKeyConfig = ();
        }
        self.clientEp = check new (serviceUrl, httpClientConfig);
    }

    # Read a batch of contacts by internal ID, or unique property values
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful operation 
    resource isolated function post batch/read(BatchReadInputSimplePublicObjectId payload, map<string|string[]> headers = {}, *PostCrmV3ObjectsContactsBatchReadReadQueries queries) returns BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error {
        string resourcePath = string `/batch/read`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Read
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful operation 
    resource isolated function get [string contactId](map<string|string[]> headers = {}, *GetCrmV3ObjectsContactsContactIdGetByIdQueries queries) returns SimplePublicObjectWithAssociations|error {
        string resourcePath = string `/${getEncodedUri(contactId)}`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<Encoding> queryParamEncoding = {"properties": {style: FORM, explode: true}, "propertiesWithHistory": {style: FORM, explode: true}, "associations": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Archive
    #
    # + headers - Headers to be sent with the request 
    # + return - No content 
    resource isolated function delete [string contactId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/${getEncodedUri(contactId)}`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Update
    #
    # + headers - Headers to be sent with the request 
    # + return - successful operation 
    resource isolated function patch [string contactId](SimplePublicObjectInput payload, map<string|string[]> headers = {}) returns SimplePublicObject|error {
        string resourcePath = string `/${getEncodedUri(contactId)}`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->patch(resourcePath, request, httpHeaders);
    }

    # Merge two contacts with same type
    #
    # + headers - Headers to be sent with the request 
    # + return - successful operation 
    resource isolated function post merge(PublicMergeInput payload, map<string|string[]> headers = {}) returns SimplePublicObject|error {
        string resourcePath = string `/merge`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Archive a batch of contacts by ID
    #
    # + headers - Headers to be sent with the request 
    # + return - No content 
    resource isolated function post batch/archive(BatchInputSimplePublicObjectId payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/batch/archive`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create a batch of contacts
    #
    # + headers - Headers to be sent with the request 
    # + return - successful operation 
    resource isolated function post batch/create(BatchInputSimplePublicObjectInputForCreate payload, map<string|string[]> headers = {}) returns BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error {
        string resourcePath = string `/batch/create`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Update a batch of contacts by internal ID, or unique property values
    #
    # + headers - Headers to be sent with the request 
    # + return - successful operation 
    resource isolated function post batch/update(BatchInputSimplePublicObjectBatchInput payload, map<string|string[]> headers = {}) returns BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error {
        string resourcePath = string `/batch/update`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # GDPR DELETE
    #
    # + headers - Headers to be sent with the request 
    # + return - No content 
    resource isolated function post gdpr\-delete(PublicGdprDeleteInput payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/gdpr-delete`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # List
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful operation 
    resource isolated function get .(map<string|string[]> headers = {}, *GetCrmV3ObjectsContactsGetPageQueries queries) returns CollectionResponseSimplePublicObjectWithAssociationsForwardPaging|error {
        string resourcePath = string `/`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<Encoding> queryParamEncoding = {"properties": {style: FORM, explode: true}, "propertiesWithHistory": {style: FORM, explode: true}, "associations": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queries, queryParamEncoding);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Create
    #
    # + headers - Headers to be sent with the request 
    # + return - successful operation 
    resource isolated function post .(SimplePublicObjectInputForCreate payload, map<string|string[]> headers = {}) returns SimplePublicObject|error {
        string resourcePath = string `/`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Create or update a batch of contacts by unique property values
    #
    # + headers - Headers to be sent with the request 
    # + return - successful operation 
    resource isolated function post batch/upsert(BatchInputSimplePublicObjectBatchInputUpsert payload, map<string|string[]> headers = {}) returns BatchResponseSimplePublicUpsertObject|BatchResponseSimplePublicUpsertObjectWithErrors|error {
        string resourcePath = string `/batch/upsert`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # + headers - Headers to be sent with the request 
    # + return - successful operation 
    resource isolated function post search(PublicObjectSearchRequest payload, map<string|string[]> headers = {}) returns CollectionResponseWithTotalSimplePublicObjectForwardPaging|error {
        string resourcePath = string `/search`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }
}
