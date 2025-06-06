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

public type StandardError record {
    record {} subCategory?;
    record {|string[]...;|} context;
    record {|string...;|} links;
    string id?;
    string category;
    string message;
    ErrorDetail[] errors;
    string status;
};

public type CollectionResponseAssociatedId record {
    Paging paging?;
    AssociatedId[] results;
};

public type PublicAssociationsForObject record {
    AssociationSpec[] types?;
    PublicObjectId to?;
};

public type BatchResponseSimplePublicObject record {
    string completedAt;
    string requestedAt?;
    string startedAt;
    record {|string...;|} links?;
    SimplePublicObject[] results;
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

public type FilterGroup record {
    Filter[] filters;
};

public type ErrorDetail record {
    # A specific category that contains more specific detail about the error
    string subCategory?;
    # The status code associated with the error detail
    string code?;
    # The name of the field or parameter in which the error was found
    string 'in?;
    # Context about the error condition
    record {|string[]...;|} context?;
    # A human readable message describing the error along with remediation steps where appropriate
    string message;
};

public type ForwardPaging record {
    NextPage next?;
};

public type SimplePublicObjectId record {
    string id;
};

public type BatchResponseSimplePublicUpsertObjectWithErrors record {
    string completedAt;
    int:Signed32 numErrors?;
    string requestedAt?;
    string startedAt;
    record {|string...;|} links?;
    SimplePublicUpsertObject[] results;
    StandardError[] errors?;
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

public type BatchReadInputSimplePublicObjectId record {
    string[] propertiesWithHistory;
    string idProperty?;
    SimplePublicObjectId[] inputs;
    string[] properties;
};

public type BatchResponseSimplePublicUpsertObject record {
    string completedAt;
    string requestedAt?;
    string startedAt;
    record {|string...;|} links?;
    SimplePublicUpsertObject[] results;
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

# Represents the Queries record for the operation: get-/crm/v3/objects/contacts_getPage
public type GetCrmV3ObjectsContactsGetPageQueries record {
    # A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored
    string[] associations?;
    # Whether to return only results that have been archived
    boolean archived = false;
    # A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored. Usage of this parameter will reduce the maximum number of objects that can be read by a single request
    string[] propertiesWithHistory?;
    # The maximum number of results to display per page
    int:Signed32 'limit = 10;
    # The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results
    string after?;
    # A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored
    string[] properties?;
};

public type ValueWithTimestamp record {
    string sourceId?;
    string sourceType;
    string sourceLabel?;
    int:Signed32 updatedByUserId?;
    string value;
    string timestamp;
};

public type BatchInputSimplePublicObjectId record {
    SimplePublicObjectId[] inputs;
};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://api.hubapi.com/oauth/v1/token";
|};

public type BatchInputSimplePublicObjectBatchInputUpsert record {
    SimplePublicObjectBatchInputUpsert[] inputs;
};

public type CollectionResponseWithTotalSimplePublicObjectForwardPaging record {
    int:Signed32 total;
    ForwardPaging paging?;
    SimplePublicObject[] results;
};

public type SimplePublicObject record {
    string createdAt;
    boolean archived?;
    string archivedAt?;
    record {|ValueWithTimestamp[]...;|} propertiesWithHistory?;
    string id;
    record {|string?...;|} properties;
    string updatedAt;
};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Provides Auth configurations needed when communicating with a remote HTTP endpoint.
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig|ApiKeysConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 30;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects followRedirects?;
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with cookies
    http:CookieConfig cookieConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Provides settings related to client socket configuration
    http:ClientSocketConfig socketConfig = {};
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};

public type PublicObjectId record {
    string id?;
};

public type Paging record {
    NextPage next?;
    PreviousPage prev?;
};

public type PublicObjectSearchRequest record {
    string query?;
    int:Signed32 'limit?;
    string after?;
    string[] sorts?;
    string[] properties?;
    FilterGroup[] filterGroups?;
};

public type SimplePublicObjectBatchInputUpsert record {
    string idProperty?;
    string objectWriteTraceId?;
    string id;
    record {|string...;|} properties;
};

public type BatchResponseSimplePublicObjectWithErrors record {
    string completedAt;
    int:Signed32 numErrors?;
    string requestedAt?;
    string startedAt;
    record {|string...;|} links?;
    SimplePublicObject[] results;
    StandardError[] errors?;
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

public type PublicGdprDeleteInput record {
    string idProperty?;
    string objectId;
};

public type SimplePublicObjectInput record {
    string objectWriteTraceId?;
    record {|string...;|} properties;
};

# Represents the Queries record for the operation: post-/crm/v3/objects/contacts/batch/read_read
public type PostCrmV3ObjectsContactsBatchReadReadQueries record {
    # Whether to return only results that have been archived
    boolean archived = false;
};

public type CollectionResponseSimplePublicObjectWithAssociationsForwardPaging record {
    ForwardPaging paging?;
    SimplePublicObjectWithAssociations[] results;
};

public type PublicMergeInput record {
    string objectIdToMerge;
    string primaryObjectId;
};

public type AssociationSpec record {
    "HUBSPOT_DEFINED"|"USER_DEFINED"|"INTEGRATOR_DEFINED" associationCategory?;
    int:Signed32 associationTypeId?;
};

public type SimplePublicObjectWithAssociations record {
    record {|CollectionResponseAssociatedId...;|} associations?;
    string createdAt;
    boolean archived?;
    string archivedAt?;
    record {|ValueWithTimestamp[]...;|} propertiesWithHistory?;
    string id;
    record {|string?...;|} properties;
    string updatedAt;
};

public type Filter record {
    string highValue?;
    string propertyName;
    string[] values?;
    string value?;
    # null
    "EQ"|"NEQ"|"LT"|"LTE"|"GT"|"GTE"|"BETWEEN"|"IN"|"NOT_IN"|"HAS_PROPERTY"|"NOT_HAS_PROPERTY"|"CONTAINS_TOKEN"|"NOT_CONTAINS_TOKEN" operator;
};

public type PreviousPage record {
    string before;
    string link?;
};

public type BatchInputSimplePublicObjectInputForCreate record {
    SimplePublicObjectInputForCreate[] inputs;
};

public type BatchInputSimplePublicObjectBatchInput record {
    SimplePublicObjectBatchInput[] inputs;
};

public type SimplePublicUpsertObject record {
    string createdAt;
    boolean archived?;
    string archivedAt?;
    boolean 'new;
    record {|ValueWithTimestamp[]...;|} propertiesWithHistory?;
    string id;
    record {|string...;|} properties;
    string updatedAt;
};

# Represents the Queries record for the operation: get-/crm/v3/objects/contacts/{contactId}_getById
public type GetCrmV3ObjectsContactsContactIdGetByIdQueries record {
    # A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored
    string[] associations?;
    # Whether to return only results that have been archived
    boolean archived = false;
    # A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored
    string[] propertiesWithHistory?;
    # A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored
    string[] properties?;
};

public type SimplePublicObjectBatchInput record {
    string idProperty?;
    string objectWriteTraceId?;
    string id;
    record {|string...;|} properties;
};

public type NextPage record {
    string link?;
    string after;
};

public type AssociatedId record {
    string id;
    string 'type;
};

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
public type ApiKeysConfig record {|
    string privateAppLegacy;
    string privateApp;
|};

public type SimplePublicObjectInputForCreate record {
    PublicAssociationsForObject[] associations?;
    string objectWriteTraceId?;
    record {|string...;|} properties;
};
