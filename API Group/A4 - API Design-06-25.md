# A4 - API Design

[TOC]



## 1. Managing Customer Declared Employments

Once the tax year has ended a customer may add any employments they believe are missing from their list of employment via their third party software, once a customer employment has been added it may subsequently be updated, or deleted (logically) by the customer. 

Employments that are added via this method are not rolled over into the next tax year. 

If the ITSD is subsequently notified of the employment via another channel (RTI / NPS) then this will result in a new employment being created (ITSD will not try to match employments), it is the customers responsiblity to then either remove the employment they added or mark the other employment as ignored to avoid an incorrect liability calculation. 

### 1.1 Add Employment

A customer must supply an employer name and start date when adding an employment. 

#### 1.1.1 URI

**POST** */income/employments/{taxableEntityId}/{taxYear}/custom*

#### 1.1.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 1.1.3 Query Parameters

N/A

#### 1.1.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 1.1.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Customer_Defined_Employment",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Customer Defined Employment",
  "description": "Object representing a customer defined employment",
  "type": "object",
  "additionalProperties": false,
  "required": ["employerName", "startDate"],
  "properties": {
    "employerRef": { "type": "string","pattern": "^([0-9]{3})/([^ ].{0,10})$"},
    "employerName": { "type" : "string", "pattern": "^.{0,74}$"},
    "startDate": { "type": "string", "format": "date" },
    "cessationDate": { "type": "string", "format": "date" },
    "payrollId": { "type": "string", "pattern": "^[a-zA-Z0-9]{0,74}$" }
  },
  "examples": [
    { 
      "employerRef": "123/AB12334", 
      "employerName":  "ACME Corp", 
      "startDate": "2020-01-01", 
      "cessationDate":  "2020-06-01",
     	"payrollId": "123213112312"
    },
    { 
      "employerName":  "ACME Corp", 
     	"startDate": "2020-01-01" 
    }
  ]
}
```

#### 1.1.6 Request Examples

##### 1.1.6.1 Full Request

```json
{ 
  "employerRef": "123/AB12334", 
  "employerName":  "ACME Corp", 
  "startDate": "2020-01-01", 
  "cessationDate":  "2020-06-01",
  "payrollId": "123213112312"
}
```
##### 1.1.6.2 Minimum Request
```json
{ 
	"employerName":  "ACME Corp", 
	"startDate": "2020-01-01" 
}
```

#### 1.1.7 Response Status Codes

| Response Code | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| 201           | Success the employment has been created.                     |
| 400           | Invalid Request - the request body or parameters are invalid |
| 401           | The request cannot be authorised                             |
| 422           | Invalid Request - validation / BVR failure                   |
| 502           | Internal Error                                               |

#### 1.1.8 Response Schema

N/A

#### 1.1.9 Response Examples

N/A

#### 1.1.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |
| Location      | Indicates the URL to the newly created resource.         |

#### 1.1.11 ITSD Components Impacted

- ISS

### 1.2 Update Employment

A customer may update a previously created customer employment, if the customer attempts to update a pre-populated employment then this operation will fail with a forbidden response code. 

This operation will replace the previously created resource completely. 

#### 1.2.1 URI

**PUT** */income/employments/{taxableEntityId}/{taxYear}/custom/{employmentId}*

#### 1.2.2 Path Parameters

| Parameter       | Description                                  | Example                              |
| --------------- | -------------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer            | AB123456                             |
| taxYear         | The tax year to which the employment applies | 2019-20                              |
| employmentId    | Unique identifier of the employment          | 123e4567-e89b-12d3-a456-426614174000 |

#### 1.2.3 Query Parameters

N/A

#### 1.2.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 1.2.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Customer_Defined_Employment",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Customer Defined Employment",
  "description": "Object representing a customer defined employment",
  "type": "object",
  "additionalProperties": false,
  "required": ["employerName", "startDate"],
  "properties": {
    "employerRef": { "type": "string","pattern": "^([0-9]{3})/([^ ].{0,10})$"},
    "employerName": { "type" : "string", "pattern": "^.{0,74}$"},
    "startDate": { "type": "string", "format": "date" },
    "cessationDate": { "type": "string", "format": "date" },
    "payrollId": { "type": "string", "pattern": "^[a-zA-Z0-9]{0,74}$" }
  },
  "examples": [
    { 
      "employerRef": "123/AB12334", 
      "employerName":  "ACME Corp", 
      "startDate": "2020-01-01", 
      "cessationDate":  "2020-06-01",
     	"payrollId": "123213112312"
    },
    { 
      "employerName":  "ACME Corp", 
     	"startDate": "2020-01-01" 
    }
  ]
}
```

#### 1.2.6 Request Examples

##### 1.2.6.1 Full Request

```json
{ 
  "employerRef": "123/AB12334", 
  "employerName":  "ACME Corp", 
  "startDate": "2020-01-01", 
  "cessationDate":  "2020-06-01",
  "payrollId": "123213112312"
}
```

##### 1.2.6.1 Minimum Request

```json
{ 
	"employerName":  "ACME Corp", 
	"startDate": "2020-01-01" 
}
```

#### 1.2.7 Response Status Codes



| Response Code | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| 201           | Success the employment has been created.                     |
| 400           | Invalid Request - the request body or parameters are invalid |
| 401           | The request cannot be authorised                             |
| 403           | Forbidden - this response is returned if the employment id supplied does not relate to a customer added emploment. |
| 404           | If the employment does not exist.                            |
| 422           | Invalid Request - validation / BVR failure                   |
| 502           | Internal Error                                               |



#### 1.2.8 Response Schema

N/A

#### 1.2.9 Response Examples

N/A

#### 1.2.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 1.2.11 ITSD Components Impacted

- ISS

### 1.3 Delete Employment

A customer can (logically) delete a previously added employment if they so choose, this will also (logically) delete any financial information related to the employment. 

If the customer attempts to delete a pre-populated employment then the operation will fail with a forbidden response. 

#### 1.3.1 URI

**DELETE** */income/employments/{taxableEntityId}/{taxYear}/custom/{employmentId}*

#### 1.3.2 Path Parameters

| Parameter       | Description                                  | Example                              |
| --------------- | -------------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer            | AB123456                             |
| taxYear         | The tax year to which the employment applies | 2019-20                              |
| employmentId    | Unique identifier of the customer            | 123e4567-e89b-12d3-a456-426614174000 |

#### 1.3.3 Query Parameters

N/A

#### 1.3.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 1.3.5 Request Schema

N/A

#### 1.3.6 Request Examples

N/A

#### 1.3.7 Response Status Codes

| Response Code | Description                                                  |
| :------------ | :----------------------------------------------------------- |
| 204           | Success                                                      |
| 400           | Parameter error                                              |
| 401           | Unauthorised                                                 |
| 403           | Forbidden - returned if the customer tries to delete a pre-populated employment |
| 404           | No data found                                                |
| 502           | Glitch in the matrix                                         |

#### 1.3.8 Response Schema

N/A

#### 1.3.9 Response Examples

N/A

#### 1.3.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 1.3.11 ITSD Components Impacted

- ISS

## 2. Ignoring Employments

A customer can opt to ignore an employment, this should be consider as an instruction to the the calculator

### 2.1 Ignore Employment Toggle

#### 2.1.1 URI

**PUT** */income/employments/{taxableEntityId}/{taxYear}/{employmentId}/ignore*

#### 2.1.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |
| employmentId    | Unique id employment.                        |          |

#### 2.1.3 Query Parameters

N/A

#### 2.1.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 2.1.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/ignore_employment_schema.json",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Ignore Employment",
  "description": "This schema allows a customer to mark an employment as ignored.",
  "type": "object",
  "additionalProperties": false,
  "required": ["ignoreEmployment"],
  "properties":{
    "ignoreEmployment":{
      "type","boolean"
    }
  }
}
```



#### 2.1.6 Request Examples

##### 2.1.6.1 Mark Employment Ignored

```json
{
  "ignoreEmployment": true
}
```

##### 2.1.6.2 Mark Employment not ignored

```json
{
  "ignoreEmployment": false
}
```



#### 2.1.7 Response Status Codes

| Response Code | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| 201           | Success the employment has been created.                     |
| 400           | Invalid Request - the request body or parameters are invalid |
| 401           | The request cannot be authorised                             |
| 403           | Forbidden - this response is returned if the employment id supplied does not relate to a customer added emploment. |
| 422           | Invalid Request - validation / BVR failure                   |
| 502           | Internal Error                                               |

#### 2.1.8 Response Schema

N/A

#### 2.1.9 Response Examples

N/A

#### 2.1.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 2.1.11 ITSD Impact Components

* ISS

## 3. Viewing a Customers Employments

### 3.1 View Customer Employments

This operation will provide the customer with a list of the active employments for the tax year. 

#### 3.1.1 URI

**GET** */income/employments/{taxableEntityId}/{taxYear}*

#### 3.1.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 3.1.3 Query Parameters

| Parameter | Description                                                  | Optionality | Type    | Example / Values | Default Value |
| --------- | ------------------------------------------------------------ | ----------- | ------- | ---------------- | ------------- |
| internal  | Query parameter specifying that view should include historic data | Optional    | Boolean | true/false       | False         |

#### 3.1.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 3.1.5 Request Schema

N/A

#### 3.1.6 Request Examples

N/A

#### 3.1.7 Response Status Codes

| Response Code | Description          |
| :------------ | :------------------- |
| 200           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 3.1.8 Response Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/View_Employments",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "View Customer Employments",
  "description": "View a list of employments associated with the customer, the list may contain employments that the customer has added via their third party software, these are clearly marked.",
  "type": "object",
  "oneOf": [
    {
      "properties": {
        "employments": {
          "type": "array",
          "additionalItems": false,
          "minItems": 1,
          "items": {
            "$ref": "#/definitions/hmrcEmployment"
          }
        },
        "customerDeclaredEmployments": {
          "type": "array",
          "additionalItems": false,
          "minItems": 1,
          "items": {
            "$ref": "#/definitions/customerEmployment"
          }
        }
      },
      "required": ["employments"],
      "additionalProperties": false
    },
    {
      "properties": {
        "employments": {
          "type": "array",
          "additionalItems": false,
          "minItems": 1,
          "items": {
            "$ref": "#/definitions/hmrcEmploymentHistory"
          }
        },
        "customerDeclaredEmployments": {
          "type": "array",
          "additionalItems": false,
          "minItems": 1,
          "items": {
            "$ref": "#/definitions/customerEmploymentHistory"
          }
        }
      },
      "required": ["employments"],
      "additionalProperties": false
    }
  ],
  "definitions": {
    "employmentId": {
      "id": "#employmentId",
      "description": "Unique identifier of the employment",
      "type": "string",
      "pattern": "^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$",
      "format": "uuid"
    },
    "employerRef": {
      "description": "The unique reference for the employer",
      "id": "#employerRef",
      "type": "string",
      "pattern": "^([0-9]{3})/([^ ].{0,10})$"
    },
    "employerName": {
      "description": "The name of the employer",
      "id": "#employerName",
      "type": "string",
      "pattern": "^.{0,74}$"
    },
    "payrollId": {
      "description": "Unique identifier of the employment within the employer",
      "id": "#payrollId",
      "type": "string",
      "pattern": "^[a-zA-Z0-9]{0,74}$"
    },
    "hmrcEmployment": {
      "type": "object",
      "additionalProperties": false,
      "required": ["employmentId","employerName"],
      "properties": {
        "employmentId": {
          "$ref": "#/definitions/employmentId"
        },
        "employerName": {
          "$ref": "#/definitions/employerName"
        },
        "employerRef": {
          "$ref": "#/definitions/employerRef"
        },
        "payrollId": {
          "$ref": "#/definitions/payrollId"
        },
        "startDate": {
          "type": "string",
          "format": "date"
        },
        "cessationDate": {
          "type": "string",
          "format": "date"
        },
        "dateIgnored": {
          "type": "string",
          "format": "date-time"
        }
      }
    },
    "hmrcEmploymentHistory": {
      "type": "object",
      "additionalProperties": false,
      "required": ["employmentId","employerName", "history"],
      "properties": {
        "employmentId": {
          "$ref": "#/definitions/employmentId"
        },
        "employerName": {
          "$ref": "#/definitions/employerName"
        },
        "employerRef": {
          "$ref": "#/definitions/employerRef"
        },
        "payrollId": {
          "$ref": "#/definitions/payrollId"
        },
        "startDate": {
          "type": "string",
          "format": "date"
        },
        "cessationDate": {
          "type": "string",
          "format": "date"
        },
        "dateIgnored": {
          "type": "string",
          "format": "date-time"
        },
        "history": {
          "type": "array",
          "additionalItems": false,
          "items": {
            "action": {
              "type" : "string",
              "enum": ["IGNORED", "UN-IGNORED"]
            },
            "submittedOn": {
              "type" : "string",
              "format": "date-time"
            }
          }
        }
      }
    },
    "customerEmployment": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "employmentId",
        "employerName",
        "submittedOn"
      ],
      "properties": {
        "employmentId": {
          "$ref": "#/definitions/employmentId"
        },
        "employerName": {
          "$ref": "#/definitions/employerName"
        },
        "employerRef": {
          "$ref": "#/definitions/employerRef"
        },
        "payrollId": {
          "$ref": "#/definitions/payrollId"
        },
        "startDate": {
          "type": "string",
          "format": "date"
        },
        "cessationDate": {
          "type": "string",
          "format": "date"
        },
        "submittedOn": {
          "type": "string",
          "format": "date-time"
        }
      }
    },
    "customerEmploymentHistory": {
      "type": "object",
      "additionalProperties": false,
      "required": ["employmentId","employerName", "submittedOn","history"],
      "properties": {
        "employmentId": {
          "$ref": "#/definitions/employmentId"
        },
        "employerName": {
          "$ref": "#/definitions/employerName"
        },
        "employerRef": {
          "$ref": "#/definitions/employerRef"
        },
        "payrollId": {
          "$ref": "#/definitions/payrollId"
        },
        "startDate": {
          "type": "string",
          "format": "date"
        },
        "cessationDate": {
          "type": "string",
          "format": "date"
        },
        "submittedOn": {
          "type": "string",
          "format": "date-time"
        },
        "deletedOn": {
          "type": "string",
          "format": "date-time"
        },
        "history": {
          "type": "array",
          "additionalItems": false,
          "items": {
            "$ref": "#/definitions/customerEmployment"
          }
        }
      }
    }
  },
  "examples": [
    {
      "employments": [
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc"
        },
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "employerRef": "123/AB12343"
        },
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "employerRef": "123/AB12343",
          "startDate": "2000-01-01",
          "cessationDate": "2001-01-01"
        },
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "dateIgnored": "2020-03-03T01:01:01Z"
        }
      ],
      "customerDeclaredEmployments": [
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "submittedOn": "2020-03-03T01:01:01Z"
        },
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "employerRef": "123/AB12343",
          "startDate": "2000-01-01",
          "cessationDate": "2001-01-01",
          "submittedOn": "2020-03-03T01:01:01Z"
        }
      ]
    },
    {
      "employments": [
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "history": [
            {
              "action": "UN-IGNORED",
              "submittedOn": "2020-03-03T01:01:01Z"
            },
            {
              "action": "IGNORED",
              "submittedOn": "2020-02-02T01:01:01Z"
            }
          ]
        },
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "employerRef": "123/AB12343",
          "history": []
        }
      ],
      "customerDeclaredEmployments": [
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "submittedOn": "2020-03-03T01:01:01Z",
          "deletedOn": "2020-03-03T01:01:01Z",
          "history": [
            {
              "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
              "employerName": "Wibble Inc",
              "submittedOn": "2020-03-03T01:01:01Z"
            },
            {
              "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
              "employerName": "Wobble Inc",
              "submittedOn": "2020-03-03T01:01:01Z"
            }
          ]
        },
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "employerRef": "123/AB12343",
          "startDate": "2000-01-01",
          "cessationDate": "2001-01-01",
          "submittedOn": "2020-03-03T01:01:01Z",
          "history": []
        }
      ]
    }
  ]
}
```



#### 3.1.9 Response Examples

##### 3.1.9.1 Without History

```json
{
  "employments": [
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc"
    },
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc",
      "employerRef": "123/AB12343"
    },
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc",
      "employerRef": "123/AB12343",
      "startDate": "2000-01-01",
      "cessationDate": "2001-01-01"
    },
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc",
      "dateIgnored": "2020-03-03T01:01:01Z"
    },
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerRef" : "123/JSA",
      "employerName": "JSA", //Need to check where this comes from etc
      "startDate": "", //Mandatory ??
      "cessationDate": "" //optional
    }
  ],
  "customerDeclaredEmployments": [
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc",
      "submittedOn": "2020-03-03T01:01:01Z"
    },
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc",
      "employerRef": "123/AB12343",
      "startDate": "2000-01-01",
      "cessationDate": "2001-01-01",
      "submittedOn": "2020-03-03T01:01:01Z"
    }
  ]
}
```
##### 3.1.9.1 With History

```json
{
  "employments": [
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc",
      "history": [
        {
          "action": "UN-IGNORED",
          "submittedOn": "2020-03-03T01:01:01Z"
        },
        {
          "action": "IGNORED",
          "submittedOn": "2020-02-02T01:01:01Z"
        }
      ]
    },
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc",
      "employerRef": "123/AB12343",
      "history": []
    }
  ],
  "customerDeclaredEmployments": [
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc",
      "submittedOn": "2020-03-03T01:01:01Z",
      "deletedOn": "2020-03-03T01:01:01Z",
      "history": [
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wibble Inc",
          "submittedOn": "2020-03-03T01:01:01Z"
        },
        {
          "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
          "employerName": "Wobble Inc",
          "submittedOn": "2020-03-03T01:01:01Z"
        }
      ]
    },
    {
      "employmentId": "960b4a0f-05f2-4b6f-9b87-c3e001a84472",
      "employerName": "Wibble Inc",
      "employerRef": "123/AB12343",
      "startDate": "2000-01-01",
      "cessationDate": "2001-01-01",
      "submittedOn": "2020-03-03T01:01:01Z",
      "history": []
    }
  ]
}
```

#### 3.1.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 3.1.11 ITSD Components Impacted

- ISS

## 4. Managing Employment Data

### 4.1 Get Employment Data

Returns a view of the customer data, the type of view is managed by query parameters, where the customer can select either the latest view (which returns a blend of HMRC data and customer submitted overrides), the customer view (which returns any overrides submitted via their third party software), or the HMRC view (which returns the latest data held by HMRC other than any data submitted by the customer using their third party software).

An additional query parameter allows internal customer to request the history of customer submissions. 

#### 4.1.1 URI

**GET** */income/employments/{taxableEntityId}/{taxYear}/{employmentId}*

#### 4.1.2 Path Parameters

| Parameter       | Description                                  | Example                              |
| --------------- | -------------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer            | AB123456                             |
| taxYear         | The tax year to which the employment applies | 2019-20                              |
| employmentId    | Unique identifier of the customer            | 123e4567-e89b-12d3-a456-426614174000 |

#### 4.1.3 Query Parameters

| Parameter | Description                                                  | Optionality | Type               | Example / Values            | Default Value |
| --------- | ------------------------------------------------------------ | ----------- | ------------------ | --------------------------- | ------------- |
| view      | Specify the type of view that you want to see, either HMRC, Customer or Latest which combines the HMRC and Customer views | Optional    | String enumeration | HMRC HELD, CUSTOMER, LATEST | LATEST        |
| internal  | Query parameter specifying that view should include historic data | Optional    | Boolean            | true/false                  | False         |

#### 4.1.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 4.1.5 Request Schema

N/A

#### 4.1.6 Request Examples

N/A

#### 4.1.7 Response Status Codes

| Response Code | Description          |
| :------------ | :------------------- |
| 200           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 4.1.8 Response Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Employment_Response",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Get Employment Response",
  "description": "A view of the low level details of a customers employment, this view is created by blending data from various sources based on set of precedence rules.",
  "type": "object",
  "oneOf": [
    {
      "$ref": "#/definitions/employmentView"
    },
    {
      "$ref": "#/definitions/employmentViewHistory"
    }
  ],
  "definitions": {
    "moneyPositive": {
      "$id": "#moneyPositive",
      "description": "Definition of a positive money value",
      "type": "number",
      "multipleOf": 0.01,
      "minimum": 0,
      "maximum": 99999999.99
    },
    "employment": {
      "type": "object",
      "required": [
        "employer",
        "pay"
      ],
      "properties": {
        "payrollId": {
          "id": "#payrollId",
          "type": "string",
          "pattern": "^[a-zA-Z0-9]{0,35}$"
        },
        "companyDirector": {
          "type": "boolean"
        },
        "closeCompany": {
          "type": "boolean"
        },
        "directorshipCeasedDate": {
          "type": "string",
          "format": "date"
        },
        "startDate": {
          "type": "string",
          "format": "date"
        },
        "cessationDate": {
          "type": "string",
          "format": "date"
        },
        "occPen": {
          "type": "boolean"
        },
        "disguisedRemuneration": {
          "type": "boolean"
        },
        "employer": {
          "type": "object",
          "additionalProperties": false,
          "required": [ "employerRef" ],
          "properties": {
            "employerRef": {
              "type": "string",
              "pattern": "^([0-9]{3})/([^ ].{0,10})$"
            },
            "employerName": {
              "type": "string",
              "pattern": "^.{0,74}$"
            }
          }
        },
        "pay": {
          "type": "object",
          "oneOf": [
            {
              "required": [
                "taxablePayToDate",
                "totalTaxToDate",
                "payFrequency",
                "paymentDate",
                "taxWeekNo"
              ],
              "not": {
                "required": [
                  "taxMonthNo"
                ]
              }
            },
            {
              "required": [
                "taxablePayToDate",
                "totalTaxToDate",                
                "payFrequency",
                "paymentDate",
                "taxMonthNo"
              ],
              "not": {
                "required": [
                  "taxWeekNo"
                ]
              }
            }
          ],
          "properties": {
            "taxablePayToDate": {
              "$ref": "#/definitions/moneyPositive"
            },
            "totalTaxToDate": {
              "type":"number",
              "minimum" : -999999999.99,
              "maximum" : 999999999.99,
              "multipleOf": 0.01,
            },
            "tipsAndOtherPayments": {
              "$ref": "#/definitions/moneyPositive"
            },
            "payFrequency": {
              "type": "string",
              "enum": [
                "WEEKLY",
                "FORTNIGHTLY",
                "FOUR WEEKLY",
                "CALENDAR MONTHLY",
                "QUARTERLY",
                "BI-ANNUALLY",
                "ONE-OFF",
                "IRREGULAR",
                "ANNUALLY"
              ]
            },
            "paymentDate": {
              "type": "string",
              "format": "date"
            },
            "taxWeekNo": {
              "type": "number",
              "minimum": 1,
              "maxumum": 56
            },
            "taxMonthNo": {
              "type": "number",
              "minimum": 1,
              "maximum": 12
            }
          }
        },
        "deductions": {
          "type": "object",
          "additionalProperties": false,
          "minProperties": 1,
          "properties": {
            "studentLoans": {
              "type": "object",
              "additionalProperties": false,
              "minProperties": 1,
              "properties": {
                "uglDeductionAmount": {
                  "$ref": "#moneyPositive"
                },
                "pglDeductionAmount": {
                  "$ref": "#moneyPositive"
                }
              }
            }
          }
        },
        "benefitsInKind": {
          "type": "object",
          "additionalProperties": false,
          "minProperties": 1,
          "properties": {
            "accommodation": {
              "$ref": "#moneyPositive"
            },
            "assets": {
              "$ref": "#moneyPositive"
            },
            "assetTransfer": {
              "$ref": "#moneyPositive"
            },
            "beneficialLoan": {
              "$ref": "#moneyPositive"
            },
            "car": {
              "$ref": "#moneyPositive"
            },
            "carFuel": {
              "$ref": "#moneyPositive"
            },
            "educationalServices": {
              "$ref": "#moneyPositive"
            },
            "entertaining": {
              "$ref": "#moneyPositive"
            },
            "expenses": {
              "$ref": "#moneyPositive"
            },
            "medicalInsurance": {
              "$ref": "#moneyPositive"
            },
            "telephone": {
              "$ref": "#moneyPositive"
            },
            "service": {
              "$ref": "#moneyPositive"
            },
            "taxableExpenses": {
              "$ref": "#moneyPositive"
            },
            "van": {
              "$ref": "#moneyPositive"
            },
            "vanFuel": {
              "$ref": "#moneyPositive"
            },
            "mileage": {
              "$ref": "#moneyPositive"
            },
            "nonQualifyingRelocationExpenses": {
              "$ref": "#moneyPositive"
            },
            "nurseryPlaces": {
              "$ref": "#moneyPositive"
            },
            "otherItems": {
              "$ref": "#moneyPositive"
            },
            "paymentsOnEmployeesBehalf": {
              "$ref": "#moneyPositive"
            },
            "personalIncidentalExpenses": {
              "$ref": "#moneyPositive"
            },
            "qualifyingRelocationExpenses": {
              "$ref": "#moneyPositive"
            },
            "employerProvidedProfessionalSubscriptions": {
              "$ref": "#moneyPositive"
            },
            "employerProvidedServices": {
              "$ref": "#moneyPositive"
            },
            "incomeTaxPaidByDirector": {
              "$ref": "#moneyPositive"
            },
            "travelAndSubsistence": {
              "$ref": "#moneyPositive"
            },
            "vouchersAndCreditCards": {
              "$ref": "#moneyPositive"
            },
            "nonCash": {
              "$ref": "#moneyPositive"
            }
          }
        }
      }
    },
    "employmentView": {
      "type": "object",
      "additionalProperties": false,
      "oneOf": [
        {
          "allOf":[
            {
              "not": {
                "required":["source"]
              }
            },
            {
              "not": {
                "required": [
                  "customerAdded"
                ]
              }
            },
            {
              "not": {
                "required": [
                  "dateIgnored"
                ]
              }
            },
            {
              "required": [
                "submittedOn",
                "employment"
              ]
            }
          ]
        },
        {
          "allOf":[
            {
              "not": {
                "required":["source"]
              }
            },
            {
              "not": {
                "required": [
                  "customerAdded"
                ]
              }
            },
            {
              "required": [
                "submittedOn",
                "employment",
                "dateIgnored"
              ]
            }
          ]
        },
        {
          "allOf":[
            {
              "not": {
                "required":["source"]
              }
            },
            {
              "not": {
                "required": [
                  "dateIgnored"
                ]
              }
            },
            {
              "required": [
                "submittedOn",
                "employment",
                "customerAdded"
              ]
            }
          ]
        },
        {
          "allOf": [
            {
              "not": {
                "required": [
                  "customerAdded"
                ]
              }
            },
            {
              "not": {
                "required": [
                  "dateIgnored"
                ]
              }
            },
            {
              "required": [
                "submittedOn",
                "source",
                "employment"
              ]
            }
          ]
        },
        {
          "allOf": [
            {
              "not": {
                "required" : ["customerAdded"]
              }
            },
            {
              "required": [
                "submittedOn",
                "source",
                "employment",
                "dateIgnored"
              ]
            }
          ]
        },
        {
          "allOf": [
            {
              "not": {
                "required" : ["dateIgnored"]
              }
            },
            {
              "required": [
                "submittedOn",
                "source",
                "employment",
                "customerAdded"
              ]
            }
          ]
        }
      ],
      "properties": {
        "submittedOn": {
          "type": "string",
          "format": "date-time"
        },
        "source": {
          "type": "string",
          "enum": [
            "CUSTOMER",
            "HMRC HELD"
          ]
        },
        "customerAdded": {
          "type": "string",
          "format": "date-time"
        },
        "dateIgnored": {
          "type": "string",
          "format": "date-time"
        },
        "employment": {
          "$ref": "#/definitions/employment"
        }
      }
    },
    "employmentViewHistory": {
      "type" : "object",
      "oneOf": [
        {
          "allOf":[
            {
              "not": {
                "required":["source"]
              }
            },
            {
              "not": {
                "required": [
                  "customerAdded"
                ]
              }
            },
            {
              "not": {
                "required": [
                  "dateIgnored"
                ]
              }
            },
            {
              "required": [
                "submittedOn",
                "employment",
                "history"
              ]
            }
          ]
        },
        {
          "allOf":[
            {
              "not": {
                "required":["source"]
              }
            },
            {
              "not": {
                "required": [
                  "customerAdded"
                ]
              }
            },
            {
              "required": [
                "submittedOn",
                "employment",
                "dateIgnored",
                "history"
              ]
            }
          ]
        },
        {
          "allOf":[
            {
              "not": {
                "required":["source"]
              }
            },
            {
              "not": {
                "required": [
                  "dateIgnored"
                ]
              }
            },
            {
              "required": [
                "submittedOn",
                "employment",
                "customerAdded",
                "history"
              ]
            }
          ]
        },
        {
          "allOf": [
            {
              "not": {
                "required": [
                  "customerAdded"
                ]
              }
            },
            {
              "not": {
                "required": [
                  "dateIgnored"
                ]
              }
            },
            {
              "required": [
                "submittedOn",
                "source",
                "employment",
                "history"
              ]
            }
          ]
        },
        {
          "allOf": [
            {
              "not": {
                "required" : ["customerAdded"]
              }
            },
            {
              "required": [
                "submittedOn",
                "source",
                "employment",
                "dateIgnored",
                "history"
              ]
            }
          ]
        },
        {
          "allOf": [
            {
              "not": {
                "required" : ["dateIgnored"]
              }
            },
            {
              "required": [
                "submittedOn",
                "source",
                "employment",
                "customerAdded",
                "history"
              ]
            }
          ]
        }
      ],
      "additionalProperties": false,
      "properties": {
        "source": {
          "type" : "string",
          "enum": ["CUSTOMER", "HMRC HELD"]
        },
        "submittedOn": {
          "type" : "string",
          "format" : "date-time"
        },
        "customerAdded": {
          "type" : "string",
          "format" : "date-time"
        },
        "dateIgnored": {
          "type" : "string",
          "format" : "date-time"
        },
        "deletedOn": {
          "type" : "string",
          "format" : "date-time"
        },
        "employment": {
          "$ref" : "#/definitions/employment"
        },
        "history": {
          "type" : "array",
          "additionalItems": false,
          "items": {
            "properties": {
              "submittedOn": {
                "type" : "string",
                "format" : "date-time"
              },
              "employment": {
                "$ref" : "#/definitions/employment"
              },
              "additionalProperties": false
            }
          }
        }
      }
    }
  }
}
```



#### 4.1.9 Response Examples

##### 4.1.9.1 Customer / HMRC Held View 

```json
{ 
  "submittedOn": "2019-04-04T01:01:01Z",
  "employment": {
    "payrollId": "124432423423",
    "companyDirector": false,
    "closeCompany": false,
    "directorshipCeasedDate": "2020-01-01",
    "startDate": "2019-01-01",
    "dateEmploymentEnded": "2020-01-01",
    "occPen": false,
    "disguisedRemuneration": false,
    "employer": {
      "employerRef": "123/XX12345",
      "employerName": "wibble"
    },
    "pay": {
      "taxablePayToDate": 1234.15,
      "totalTaxToDate": 12.22,
      "tipsAndOtherPayments": 10000,
      "payFrequency": "CALENDAR MONTHLY",
      "paymentDate": "2020-05-12",
      "taxWeekNo": 52
    },
    "deductions": {
      "studentLoans": {
        "uglDeductionAmount": 1232.22,
        "pglDeductionAmount": 1232.22
      }
    },
    "benefitsInKind": {
      "accommodation": 124.22,
      "assets": 124.22,
      "assetTransfer": 124.22,
      "beneficialLoan": 124.22,
      "car": 124.22,
      "carFuel": 124.22,
      "educationalServices": 124.22,
      "entertaining": 124.22,
      "expenses": 124.22,
      "medicalInsurance": 124.22,
      "telephone": 124.22,
      "service": 124.22,
      "taxableExpenses": 124.22,
      "van": 124.22,
      "vanFuel": 124.22,
      "mileage": 124.22,
      "nonQualifyingRelocationExpenses": 124.22,
      "nurseryPlaces": 124.22,
      "otherItems": 124.22,
      "paymentsOnEmployeesBehalf": 124.22,
      "personalIncidentalExpenses": 124.22,
      "qualifyingRelocationExpenses": 124.22,
      "employerProvidedProfessionalSubscriptions": 124.22,
      "employerProvidedServices": 124.22,
      "incomeTaxPaidByDirector": 124.22,
      "travelAndSubsistence": 124.22,
      "vouchersAndCreditCards": 124.22,
      "nonCash": 124.22
    }
  }
}
```



##### 4.1.9.2 Ignored Employment

```json
{ 
  "submittedOn": "2019-04-04T01:01:01Z",
  "dateIgnored": "2019-04-04T01:01:01Z",
  "employment": {
    "payrollId": "124432423423",
    "companyDirector": false,
    "closeCompany": false,
    "directorshipCeasedDate": "2020-01-01",
    "startDate": "2019-01-01",
    "dateEmploymentEnded": "2020-01-01",
    "occPen": false,
    "disguisedRemuneration": false,
    "employer": {
      "employerRef": "123/XX12345",
      "employerName": "wibble"
    },
    "pay": {
      "taxablePayToDate": 1234.15,
      "totalTaxToDate": 12.22,
      "tipsAndOtherPayments": 10000,
      "payFrequency": "CALENDAR MONTHLY",
      "paymentDate": "2020-05-12",
      "taxWeekNo": 52
    },
    "deductions": {
      "studentLoans": {
        "uglDeductionAmount": 1232.22,
        "pglDeductionAmount": 1232.22
      }
    },
    "benefitsInKind": {
      "accommodation": 124.22,
      "assets": 124.22,
      "assetTransfer": 124.22,
      "beneficialLoan": 124.22,
      "car": 124.22,
      "carFuel": 124.22,
      "educationalServices": 124.22,
      "entertaining": 124.22,
      "expenses": 124.22,
      "medicalInsurance": 124.22,
      "telephone": 124.22,
      "service": 124.22,
      "taxableExpenses": 124.22,
      "van": 124.22,
      "vanFuel": 124.22,
      "mileage": 124.22,
      "nonQualifyingRelocationExpenses": 124.22,
      "nurseryPlaces": 124.22,
      "otherItems": 124.22,
      "paymentsOnEmployeesBehalf": 124.22,
      "personalIncidentalExpenses": 124.22,
      "qualifyingRelocationExpenses": 124.22,
      "employerProvidedProfessionalSubscriptions": 124.22,
      "employerProvidedServices": 124.22,
      "incomeTaxPaidByDirector": 124.22,
      "travelAndSubsistence": 124.22,
      "vouchersAndCreditCards": 124.22,
      "nonCash": 124.22
    }
  }
}
```

##### 4.1.9.3 Customer Added Employment

```json
{ 
  "submittedOn": "2019-04-04T01:01:01Z",
  "customerAdded": "2019-04-04T01:01:01Z",
  "employment": {
    "payrollId": "124432423423",
    "companyDirector": false,
    "closeCompany": false,
    "directorshipCeasedDate": "2020-01-01",
    "startDate": "2019-01-01",
    "dateEmploymentEnded": "2020-01-01",
    "occPen": false,
    "disguisedRemuneration": false,
    "employer": {
      "employerRef": "123/XX12345",
      "employerName": "wibble"
    },
    "pay": {
      "taxablePayToDate": 1234.15,
      "totalTaxToDate": 12.22,
      "tipsAndOtherPayments": 10000,
      "payFrequency": "CALENDAR MONTHLY",
      "paymentDate": "2020-05-12",
      "taxWeekNo": 52
    },
    "deductions": {
      "studentLoans": {
        "uglDeductionAmount": 1232.22,
        "pglDeductionAmount": 1232.22
      }
    },
    "benefitsInKind": {
      "accommodation": 124.22,
      "assets": 124.22,
      "assetTransfer": 124.22,
      "beneficialLoan": 124.22,
      "car": 124.22,
      "carFuel": 124.22,
      "educationalServices": 124.22,
      "entertaining": 124.22,
      "expenses": 124.22,
      "medicalInsurance": 124.22,
      "telephone": 124.22,
      "service": 124.22,
      "taxableExpenses": 124.22,
      "van": 124.22,
      "vanFuel": 124.22,
      "mileage": 124.22,
      "nonQualifyingRelocationExpenses": 124.22,
      "nurseryPlaces": 124.22,
      "otherItems": 124.22,
      "paymentsOnEmployeesBehalf": 124.22,
      "personalIncidentalExpenses": 124.22,
      "qualifyingRelocationExpenses": 124.22,
      "employerProvidedProfessionalSubscriptions": 124.22,
      "employerProvidedServices": 124.22,
      "incomeTaxPaidByDirector": 124.22,
      "travelAndSubsistence": 124.22,
      "vouchersAndCreditCards": 124.22,
      "nonCash": 124.22
    }
  }
}
```

##### 4.1.9.4 Latest View

```json
{
  "submittedOn": "2019-04-04T01:01:01Z",
  "source": "CUSTOMER",
  "employment": {
    "payrollId": "124432423423",
    "companyDirector": false,
    "closeCompany": false,
    "directorshipCeasedDate": "2020-01-01",
    "startDate": "2019-01-01",
    "cessationDate": "2020-01-01",
    "occupationalPension": false,
    "disguisedRemuneration": false,
    "employer": {
      "employerRef": "123/XX12345",
      "employerName": "wibble"
    },
    "pay": {
      "grossAmountPaidYtd": 1234.15,
      "taxTakenOffYtd": 12.22,
      "tipsAndOtherPayments": 10000,
      "payFrequency": "CALENDAR MONTHLY",
      "paymentDate": "2020-05-12",
      "taxWeekNo": 52
    },
    "deductions": {
      "studentLoans": {
        "uglDeductionAmount": 1232.22,
        "pglDeductionAmount": 1232.22
      }
    },
    "benefitsInKind": {
      "accommodation": 124.22,
      "assets": 124.22,
      "assetTransfer": 124.22,
      "beneficialLoan": 124.22,
      "car": 124.22,
      "carFuel": 124.22,
      "educationalServices": 124.22,
      "entertaining": 124.22,
      "expenses": 124.22,
      "medicalInsurance": 124.22,
      "telephone": 124.22,
      "service": 124.22,
      "taxableExpenses": 124.22,
      "van": 124.22,
      "vanFuel": 124.22,
      "mileage": 124.22,
      "nonQualifyingRelocationExpenses": 124.22,
      "nurseryPlaces": 124.22,
      "otherItems": 124.22,
      "paymentsOnEmployeesBehalf": 124.22,
      "personalIncidentalExpenses": 124.22,
      "qualifyingRelocationExpenses": 124.22,
      "employerProvidedProfessionalSubscriptions": 124.22,
      "employerProvidedServices": 124.22,
      "incomeTaxPaidByDirector": 124.22,
      "travelAndSubsistence": 124.22,
      "vouchersAndCreditCards": 124.22,
      "nonCash": 124.22
    }
  }
}
```

##### 4.1.9.5 Latest View (customer added employment)

```json
{
  "submittedOn": "2019-04-04T01:01:01Z",
  "source": "CUSTOMER",
  "customerAdded":"2019-04-04T01:01:01Z",
  "employment": {
    "payrollId": "124432423423",
    "companyDirector": false,
    "closeCompany": false,
    "directorshipCeasedDate": "2020-01-01",
    "startDate": "2019-01-01",
    "cessationDate": "2020-01-01",
    "occupationalPension": false,
    "disguisedRemuneration": false,
    "employer": {
      "employerRef": "123/XX12345",
      "employerName": "wibble"
    },
    "pay": {
      "grossAmountPaidYtd": 1234.15,
      "taxTakenOffYtd": 12.22,
      "tipsAndOtherPayments": 10000,
      "payFrequency": "CALENDAR MONTHLY",
      "paymentDate": "2020-05-12",
      "taxWeekNo": 52
    },
    "deductions": {
      "studentLoans": {
        "uglDeductionAmount": 1232.22,
        "pglDeductionAmount": 1232.22
      }
    },
    "benefitsInKind": {
      "accommodation": 124.22,
      "assets": 124.22,
      "assetTransfer": 124.22,
      "beneficialLoan": 124.22,
      "car": 124.22,
      "carFuel": 124.22,
      "educationalServices": 124.22,
      "entertaining": 124.22,
      "expenses": 124.22,
      "medicalInsurance": 124.22,
      "telephone": 124.22,
      "service": 124.22,
      "taxableExpenses": 124.22,
      "van": 124.22,
      "vanFuel": 124.22,
      "mileage": 124.22,
      "nonQualifyingRelocationExpenses": 124.22,
      "nurseryPlaces": 124.22,
      "otherItems": 124.22,
      "paymentsOnEmployeesBehalf": 124.22,
      "personalIncidentalExpenses": 124.22,
      "qualifyingRelocationExpenses": 124.22,
      "employerProvidedProfessionalSubscriptions": 124.22,
      "employerProvidedServices": 124.22,
      "incomeTaxPaidByDirector": 124.22,
      "travelAndSubsistence": 124.22,
      "vouchersAndCreditCards": 124.22,
      "nonCash": 124.22
    }
  }
}
```



##### 4.1.9.6 Historical View - with history

```json
{
  "submittedOn": "2019-04-04T01:01:01Z",
  "customerAdded": "2019-04-04T01:01:01Z",
  "deletedOn": "2019-04-04T01:01:01Z",
  "employment": {
    "payrollId": "124432423423",
    "companyDirector": false,
    "closeCompany": false,
    "directorshipCeasedDate": "2020-01-01",
    "startDate": "2019-01-01",
    "cessationDate": "2020-01-01",
    "occupationalPension": false,
    "disguisedRemuneration": false,
    "employer": {
      "employerRef": "123/XX12345",
      "employerName": "wibble"
    },
    "pay": {
      "grossAmountPaidYtd": 1234.15,
      "taxTakenOffYtd": 12.22,
      "tipsAndOtherPayments": 10000.0,
      "payFrequency": "CALENDAR MONTHLY",
      "paymentDate": "2020-05-12",
      "taxWeekNo": 52
    },
    "deductions": {
      "studentLoans": {
        "uglDeductionAmount": 1232.22,
        "pglDeductionAmount": 1232.22
      }
    },
    "benefitsInKind": {
      "accommodation": 124.22,
      "assets": 124.22,
      "assetTransfer": 124.22,
      "beneficialLoan": 124.22,
      "car": 124.22,
      "carFuel": 124.22,
      "educationalServices": 124.22,
      "entertaining": 124.22,
      "expenses": 124.22,
      "medicalInsurance": 124.22,
      "telephone": 124.22,
      "service": 124.22,
      "taxableExpenses": 124.22,
      "van": 124.22,
      "vanFuel": 124.22,
      "mileage": 124.22,
      "nonQualifyingRelocationExpenses": 124.22,
      "nurseryPlaces": 124.22,
      "otherItems": 124.22,
      "paymentsOnEmployeesBehalf": 124.22,
      "personalIncidentalExpenses": 124.22,
      "qualifyingRelocationExpenses": 124.22,
      "employerProvidedProfessionalSubscriptions": 124.22,
      "employerProvidedServices": 124.22,
      "incomeTaxPaidByDirector": 124.22,
      "travelAndSubsistence": 124.22,
      "vouchersAndCreditCards": 124.22,
      "nonCash": 124.22
    }
  },
  "history": [
    {
      "submittedOn": "2019-04-04T01:01:01Z",
      "customerAdded": "2019-04-04T01:01:01Z",
      "employment": {
        "payrollId": "124432423423",
        "companyDirector": false,
        "closeCompany": false,
        "directorshipCeasedDate": "2020-01-01",
        "startDate": "2019-01-01",
        "cessationDate": "2020-01-01",
        "occupationalPension": false,
        "disguisedRemuneration": false,
        "employer": {
          "employerRef": "123/XX12345",
          "employerName": "wibble"
        },
        "pay": {
          "grossAmountPaidYtd": 1234.15,
          "taxTakenOffYtd": 12.22,
          "tipsAndOtherPayments": 10000.0,
          "payFrequency": "CALENDAR MONTHLY",
          "paymentDate": "2020-05-12",
          "taxWeekNo": 52
        },
        "deductions": {
          "studentLoans": {
            "uglDeductionAmount": 1232.22,
            "pglDeductionAmount": 1232.22
          }
        },
        "benefitsInKind": {
          "accommodation": 124.22,
          "assets": 124.22,
          "assetTransfer": 124.22,
          "beneficialLoan": 124.22,
          "car": 124.22,
          "carFuel": 124.22,
          "educationalServices": 124.22,
          "entertaining": 124.22,
          "expenses": 124.22,
          "medicalInsurance": 124.22,
          "telephone": 124.22,
          "service": 124.22,
          "taxableExpenses": 124.22,
          "van": 124.22,
          "vanFuel": 124.22,
          "mileage": 124.22,
          "nonQualifyingRelocationExpenses": 124.22,
          "nurseryPlaces": 124.22,
          "otherItems": 124.22,
          "paymentsOnEmployeesBehalf": 124.22,
          "personalIncidentalExpenses": 124.22,
          "qualifyingRelocationExpenses": 124.22,
          "employerProvidedProfessionalSubscriptions": 124.22,
          "employerProvidedServices": 124.22,
          "incomeTaxPaidByDirector": 124.22,
          "travelAndSubsistence": 124.22,
          "vouchersAndCreditCards": 124.22,
          "nonCash": 124.22
        }
      }
    }
  ]
}
```

##### 4.1.9.7 Historical View - empty history

```json
{
  "submittedOn": "2019-04-04T01:01:01Z",
  "customerAdded": "2019-04-04T01:01:01Z",
  "deletedOn": "2019-04-04T01:01:01Z",
  "employment": {
    "payrollId": "124432423423",
    "companyDirector": false,
    "closeCompany": false,
    "directorshipCeasedDate": "2020-01-01",
    "startDate": "2019-01-01",
    "cessationDate": "2020-01-01",
    "occupationalPension": false,
    "disguisedRemuneration": false,
    "employer": {
      "employerRef": "123/XX12345",
      "employerName": "wibble"
    },
    "pay": {
      "grossAmountPaidYtd": 1234.15,
      "taxTakenOffYtd": 12.22,
      "tipsAndOtherPayments": 10000.0,
      "payFrequency": "CALENDAR MONTHLY",
      "paymentDate": "2020-05-12",
      "taxWeekNo": 52
    },
    "deductions": {
      "studentLoans": {
        "uglDeductionAmount": 1232.22,
        "pglDeductionAmount": 1232.22
      }
    },
    "benefitsInKind": {
      "accommodation": 124.22,
      "assets": 124.22,
      "assetTransfer": 124.22,
      "beneficialLoan": 124.22,
      "car": 124.22,
      "carFuel": 124.22,
      "educationalServices": 124.22,
      "entertaining": 124.22,
      "expenses": 124.22,
      "medicalInsurance": 124.22,
      "telephone": 124.22,
      "service": 124.22,
      "taxableExpenses": 124.22,
      "van": 124.22,
      "vanFuel": 124.22,
      "mileage": 124.22,
      "nonQualifyingRelocationExpenses": 124.22,
      "nurseryPlaces": 124.22,
      "otherItems": 124.22,
      "paymentsOnEmployeesBehalf": 124.22,
      "personalIncidentalExpenses": 124.22,
      "qualifyingRelocationExpenses": 124.22,
      "employerProvidedProfessionalSubscriptions": 124.22,
      "employerProvidedServices": 124.22,
      "incomeTaxPaidByDirector": 124.22,
      "travelAndSubsistence": 124.22,
      "vouchersAndCreditCards": 124.22,
      "nonCash": 124.22
    }
  },
  "history": []
}
```



#### 4.1.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 4.1.11 ITSD Components Impacted

- ISS
- View
- IBD

### 4.2 Override Employment Data

Customers can override their employments by submitting a replacement "submission" via their third party software. The customer must submit all data items they wish to be considered, i.e. if they want to remove a data item then can simply omit it from their submission. 

#### 4.2.1 URI

**PUT** */income/employments/{taxableEntityId}/{taxYear}/{employmentId}*

#### 4.2.2 Path Parameters

| Parameter       | Description                                  | Example                              |
| --------------- | -------------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer            | AB123456                             |
| taxYear         | The tax year to which the employment applies | 2019-20                              |
| employmentId    | Unique identifier of the customer            | 123e4567-e89b-12d3-a456-426614174000 |

#### 4.2.3 Query Parameters

N/A

#### 4.2.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 4.2.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Put_Employment_Request",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Put Employment Request",
  "type": "object",
  "additionalProperties": false,
  "required": [
    "employment"
  ],
  "properties": {
    "employment": {
      "$ref": "#/definitions/employment"
    }
  },
  "definitions": {
    "moneyPositive": {
      "$id": "#moneyPositive",
      "description": "Definition of a positive money value",
      "type": "number",
      "multipleOf": 0.01,
      "minimum": 0,
      "maximum": 99999999.99
    },
    "employment": {
      "id": "#employment",
      "description": "The delta changes the customer wants to make against the employment",
      "type": "object",
      "additionalProperties": false,
      "minProperties": 1,
      "properties": {
        "pay": {
          "type": "object",
          "additionalProperties": false,
          "minProperties": 1,
          "properties": {
            "grossAmountPaidYtd": {
              "$ref": "#/definitions/moneyPositive"
            },
            "taxTakenOffYtd": {
              "type":"number",
              "minimum" : -999999999.99,
              "maximum" : 999999999.99,
              "multipleOf": 0.01,
            },
            "tipsAndOtherPayments": {
              "$ref": "#/definitions/moneyPositive"
            },
          }
        },
        "deductions": {
          "type": "object",
          "additionalProperties": false,
          "minProperties": 1,
          "properties": {
            "studentLoans": {
              "type": "object",
              "additionalProperties": false,
              "minProperties": 1,
              "properties": {
                "uglDeductionAmount": {
                  "$ref": "#moneyPositive"
                },
                "pglDeductionAmount": {
                  "$ref": "#moneyPositive"
                }
              }
            }
          }
        },
        "benefitsInKind": {
          "type": "object",
          "additionalProperties": false,
          "minProperties": 1,
          "properties": {
            "accommodation": {
              "$ref": "#moneyPositive"
            },
            "assets": {
              "$ref": "#moneyPositive"
            },
            "assetTransfer": {
              "$ref": "#moneyPositive"
            },
            "beneficialLoan": {
              "$ref": "#moneyPositive"
            },
            "car": {
              "$ref": "#moneyPositive"
            },
            "carFuel": {
              "$ref": "#moneyPositive"
            },
            "educationalServices": {
              "$ref": "#moneyPositive"
            },
            "entertaining": {
              "$ref": "#moneyPositive"
            },
            "expenses": {
              "$ref": "#moneyPositive"
            },
            "medicalInsurance": {
              "$ref": "#moneyPositive"
            },
            "telephone": {
              "$ref": "#moneyPositive"
            },
            "service": {
              "$ref": "#moneyPositive"
            },
            "taxableExpenses": {
              "$ref": "#moneyPositive"
            },
            "van": {
              "$ref": "#moneyPositive"
            },
            "vanFuel": {
              "$ref": "#moneyPositive"
            },
            "mileage": {
              "$ref": "#moneyPositive"
            },
            "nonQualifyingRelocationExpenses": {
              "$ref": "#moneyPositive"
            },
            "nurseryPlaces": {
              "$ref": "#moneyPositive"
            },
            "otherItems": {
              "$ref": "#moneyPositive"
            },
            "paymentsOnEmployeesBehalf": {
              "$ref": "#moneyPositive"
            },
            "personalIncidentalExpenses": {
              "$ref": "#moneyPositive"
            },
            "qualifyingRelocationExpenses": {
              "$ref": "#moneyPositive"
            },
            "employerProvidedProfessionalSubscriptions": {
              "$ref": "#moneyPositive"
            },
            "employerProvidedServices": {
              "$ref": "#moneyPositive"
            },
            "incomeTaxPaidByDirector": {
              "$ref": "#moneyPositive"
            },
            "travelAndSubsistence": {
              "$ref": "#moneyPositive"
            },
            "vouchersAndCreditCards": {
              "$ref": "#moneyPositive"
            },
            "nonCash": {
              "$ref": "#moneyPositive"
            }
          }
        }
      }
    }
  },
  "examples": [
    {
      "employment": {
        "payrollId": "124432423423",
        "companyDirector": false,
        "closeCompany": false,
        "directorshipCeasedDate": "2020-01-01",
        "startDate": "2019-01-01",
        "cessationDate": "2020-01-01",
        "occupationalPension": false,
        "disguisedRemuneration": false,
        "employer": {
          "employerName": "wibble"
        },
        "pay": {
          "grossAmountPaidYtd": 1234.15,
          "taxTakenOffYtd": 12.22,
          "tipsAndOtherPayments": 10000.0,
          "payFrequency": "CALENDAR MONTHLY",
          "paymentDate": "2020-05-12",
          "taxWeekNo": 52
        },
        "deductions": {
          "studentLoans": {
            "uglDeductionAmount": 1232.22,
            "pglDeductionAmount": 1232.22
          }
        },
        "benefitsInKind": {
          "accommodation": 124.22,
          "assets": 124.22,
          "assetTransfer": 124.22,
          "beneficialLoan": 124.22,
          "car": 124.22,
          "carFuel": 124.22,
          "educationalServices": 124.22,
          "entertaining": 124.22,
          "expenses": 124.22,
          "medicalInsurance": 124.22,
          "telephone": 124.22,
          "service": 124.22,
          "taxableExpenses": 124.22,
          "van": 124.22,
          "vanFuel": 124.22,
          "mileage": 124.22,
          "nonQualifyingRelocationExpenses": 124.22,
          "nurseryPlaces": 124.22,
          "otherItems": 124.22,
          "paymentsOnEmployeesBehalf": 124.22,
          "personalIncidentalExpenses": 124.22,
          "qualifyingRelocationExpenses": 124.22,
          "employerProvidedProfessionalSubscriptions": 124.22,
          "employerProvidedServices": 124.22,
          "incomeTaxPaidByDirector": 124.22,
          "travelAndSubsistence": 124.22,
          "vouchersAndCreditCards": 124.22,
          "nonCash": 124.22
        }
      }
    }
  ]
}
```



#### 4.2.6 Request Examples

```json
{
  "employment": {
    "pay": {
      "grossAmountPaidYtd": 1234.15,
      "taxTakenOffYtd": 12.22,
      "tipsAndOtherPayments": 10000.0
    },
    "deductions": {
      "studentLoans": {
        "uglDeductionAmount": 1232.22,
        "pglDeductionAmount": 1232.22
      }
    },
    "benefitsInKind": {
      "accommodation": 124.22,
      "assets": 124.22,
      "assetTransfer": 124.22,
      "beneficialLoan": 124.22,
      "car": 124.22,
      "carFuel": 124.22,
      "educationalServices": 124.22,
      "entertaining": 124.22,
      "expenses": 124.22,
      "medicalInsurance": 124.22,
      "telephone": 124.22,
      "service": 124.22,
      "taxableExpenses": 124.22,
      "van": 124.22,
      "vanFuel": 124.22,
      "mileage": 124.22,
      "nonQualifyingRelocationExpenses": 124.22,
      "nurseryPlaces": 124.22,
      "otherItems": 124.22,
      "paymentsOnEmployeesBehalf": 124.22,
      "personalIncidentalExpenses": 124.22,
      "qualifyingRelocationExpenses": 124.22,
      "employerProvidedProfessionalSubscriptions": 124.22,
      "employerProvidedServices": 124.22,
      "incomeTaxPaidByDirector": 124.22,
      "travelAndSubsistence": 124.22,
      "vouchersAndCreditCards": 124.22,
      "nonCash": 124.22
    }
  }
}
```



#### 4.2.7 Response Status Codes

| Response Code | Description            |
| :------------ | :--------------------- |
| 204           | Success                |
| 400           | Parameter error        |
| 401           | Unauthorised           |
| 422           | validation / bvr error |
| 404           | No data found          |
| 502           | Glitch in the matrix   |

#### 4.2.8 Response Schema

N/A

#### 4.2.9 Response Examples

N/A

#### 4.2.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 4.2.11 ITSD Components Impacted

- ISS
- IBD

### 4.3 Delete Employment Data Override

The customer can delete any overrides they have submitted via their third party software package. 

#### 4.3.1 URI

**DELETE** */income/employments/{taxableEntityId}/{taxYear}/{employmentId}*

#### 4.3.2 Path Parameters

| Parameter       | Description                                  | Example                              |
| --------------- | -------------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer            | AB123456                             |
| taxYear         | The tax year to which the employment applies | 2019-20                              |
| employmentId    | Unique identifier of the customer            | 123e4567-e89b-12d3-a456-426614174000 |

#### 4.3.3 Query Parameters

N/A

#### 4.3.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 4.3.5 Request Schema

N/A

#### 4.3.6 Request Examples

N/A

#### 4.3.7 Response Status Codes

| Response Code | Description          |
| :------------ | :------------------- |
| 204           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 4.3.8 Response Schema

N/A

#### 4.3.9 Response Examples

N/A

#### 4.3.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 4.3.11 ITSD Components Impacted

- IBD

## 5. Employment Expenses

Employment related expenses are pre-populated by HMRC, however the customer can choose to either request that all employment related expenses are ignored or override individual values. 

### 5.1 Get Employment Expenses

A customer can choose to retrieve either the latest view of expenses (a blending of HMRC an customer values), the HMRC view of expenses, or the overrides they have submitted via the software.

#### 5.1.1 URI

**GET** */expenses/employments/{taxableEntityId}/{taxYear}*

#### 5.1.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 5.1.3 Query Parameters

| Parameter | Description                                                  | Optionality | Type               | Example / Values       | Default Value |
| --------- | ------------------------------------------------------------ | ----------- | ------------------ | ---------------------- | ------------- |
| view      | Specify the type of view that you want to see, either HMRC, Customer or Latest which combines the HMRC and Customer views | Optional    | String enumeration | HMRC, CUSTOMER, LATEST | LATEST        |
| internal  | Query parameter specifying that view should include historic data | Optional    | Boolean            | true/false             | False         |

#### 5.1.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 5.1.5 Request Schema

N/A

#### 5.1.6 Request Examples

N/A

#### 5.1.7 Response Status Codes

| Response Code | Description          |
| :------------ | :------------------- |
| 200           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 5.1.8 Response Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/View_Employment_Expenses_Response",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "View Employment Expenses Response",
  "type": "object",
  "description": "A view of the expenses a customer has declared in relation to the their activities as an employee.",
  "additionalProperties": false,
  "required": [
    "submittedOn",
    "totalExpenses",
    "expenses"
  ],
  "properties": {
    "submittedOn":{
      "type":"string",
      "foramt":"date-time"
    },
    "dateIgnored": {
      "type": "string",
      "format": "date-time",
      "description": "An ISO-8601 compliant date-time representing when the customer requested the data set was ignored."
    },
    "source":{
      "type":"string",
      "enum":["CUSTOMER","HMRC HELD", "LATEST"]
    },
    "totalExpenses": {
      "$ref": "#/definitions/moneyPositive"
    },
    "expenses": {
      "$ref": "#/definitions/expenses"
    }
  },
  "definitions": {
    "moneyPositive": {
      "id": "#moneyPostive",
      "description": "Total of all itemised expenses",
      "type": "number",
      "minimum": 0.0,
      "maximum": 9999999.99,
      "multipleOf": 0.01
    },
    "expenses": {
      "id": "#expenses",
      "type": "object",
      "description": "itemised expenses",
      "additionalProperties": false,
      "minProperties": 1,
      "properties": {
        "businessTravelCosts": {
          "$ref": "#/definitions/moneyPositive"
        },
        "jobExpenses": {
          "$ref": "#/definitions/moneyPositive"
        },
        "flatRateJobExpenses": {
          "$ref": "#/definitions/moneyPositive"
        },
        "professionalSubscriptions": {
          "$ref": "#/definitions/moneyPositive"
        },
        "hotelAndMealExpenses": {
          "$ref": "#/definitions/moneyPositive"
        },
        "otherAndCapitalAllowances": {
          "$ref": "#/definitions/moneyPositive"
        },
        "vehicleExpenses": {
          "$ref": "#/definitions/moneyPositive"
        },
        "mileageAllowanceRelief": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    }
  },
  "examples": [
    {
			"submittedOn":"2019-04-04T01:01:01Z",
      "dateIgnored":"2019-04-04T01:01:01Z",
      "totalExpenses": 1232.22,
      "expenses": {
        "businessTravelCosts": 122.22,
        "jobExpenses": 124.22,
        "flatRateJobExpenses": 124.22,
        "professionalSubscriptions": 124.22,
        "hotelAndMealExpenses": 124.22,
        "otherAndCapitalAllowances": 123.12,
        "vehicleExpenses": 124.22,
        "mileageAllowanceRelief": 124.22
      }
    },
    {
			"submittedOn":"2019-04-04T01:01:01Z",
      "totalExpenses": 1232.22,      
      "expenses": {
        "businessTravelCosts": 122.22,
        "jobExpenses": 124.22,
        "flatRateJobExpenses": 124.22,
        "professionalSubscriptions": 124.22,
        "hotelAndMealExpenses": 124.22,
        "otherAndCapitalAllowances": 123.12,
        "vehicleExpenses": 124.22,
        "mileageAllowanceRelief": 124.22
      }
    },
    {
			"submittedOn":"2019-04-04T01:01:01Z",
      "totalExpenses": 1232.22,      
      "expenses": {
        "businessTravelCosts": 122.22,
        "jobExpenses": 100.00,
        "flatRateJobExpenses": 1000.00,
        "professionalSubscriptions": 0.00,
        "hotelAndMealExpenses": 0.00,
        "otherAndCapitalAllowances": 123.12,
        "vehicleExpenses": 124.22,
        "mileageAllowanceRelief": 124.22
      }
    },
    {
			"submittedOn":"2019-04-04T01:01:01Z",
      "source": "CUSTOMER",
      "totalExpenses": 1232.22,
      "expenses": {
        "businessTravelCosts": 122.22,
        "jobExpenses": 124.22,
        "flatRateJobExpenses": 124.22,
        "professionalSubscriptions": 124.22,
        "hotelAndMealExpenses": 124.22,
        "otherAndCapitalAllowances": 123.12,
        "vehicleExpenses": 124.22,
        "mileageAllowanceRelief": 124.22
      }
    } 
  ]
}
```

#### 5.1.9 Response Examples

##### 5.1.9.1 Customer View

```json
{
  "submittedOn": "2019-04-04T01:01:01Z",
  "totalExpenses": 1232.22,
  "expenses": {
    "businessTravelCosts": 122.22,
    "jobExpenses": 124.22,
    "flatRateJobExpenses": 124.22,
    "professionalSubscriptions": 124.22,
    "hotelAndMealExpenses": 124.22,
    "otherAndCapitalAllowances": 123.12,
    "vehicleExpenses": 124.22,
    "mileageAllowanceRelief": 124.22
  }
}
```

##### 5.1.9.2 HMRC View

The submitted on date represents the latest change date within an HMRC system. 

```json
{
  "submittedOn": "2019-04-04T01:01:01Z", 
  "totalExpenses": 1232.22,
  "expenses": {
    "businessTravelCosts": 122.22,    
    "jobExpenses": 124.22,
    "flatRateJobExpenses": 124.22,
    "professionalSubscriptions": 124.22,
    "hotelAndMealExpenses": 124.22,
    "otherAndCapitalAllowances": 123.12,
    "vehicleExpenses": 124.22,
    "mileageAllowanceRelief": 124.22
  }
}
```



##### 5.1.9.3 Latest View

```json
{
  "submittedOn": "2019-04-04T01:01:01Z",
  "source": "CUSTOMER",
  "totalExpenses": 1232.22,
  "expenses": {
    "businessTravelCosts": 122.22,
    "jobExpenses": 124.22,
    "flatRateJobExpenses": 124.22,
    "professionalSubscriptions": 124.22,
    "hotelAndMealExpenses": 124.22,
    "otherAndCapitalAllowances": 123.12,
    "vehicleExpenses": 124.22,
    "mileageAllowanceRelief": 124.22
  }
}
```



##### 5.1.9.4 Ignored Expenses

```json
{
  "submittedOn": "2019-04-04T01:01:01Z",
  "dateIgnored": "2019-04-04T01:01:01Z",
  "totalExpenses": 1232.22,
  "expenses": {
    "businessTravelCosts": 122.22,
    "jobExpenses": 124.22,
    "flatRateJobExpenses": 124.22,
    "professionalSubscriptions": 124.22,
    "hotelAndMealExpenses": 124.22,
    "otherAndCapitalAllowances": 123.12,
    "vehicleExpenses": 124.22,
    "mileageAllowanceRelief": 124.22
  }
}
```



#### 5.1.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 5.1.11 ITSD Components Impacted

- View
- IBD

### 5.2 Override Employment Expenses

A customer can override employment related expenses via this operation, specifically they can add an expense, change the value of an expense (including setting it to zero).

#### 5.2.1 URI

**PUT** */expenses/employments/{taxableEntityId}/{taxYear}*

#### 5.2.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 5.2.3 Query Parameters

N/A

#### 5.2.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 5.2.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Employment_Response",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Get Employment Response",
  "type": "object",
  "oneOf": [
    { "$ref": "#/definitions/ignore"},
    { "$ref": "#/definitions/expenses"}
  ],

  "definitions": {
    "moneyPositive": {
      "$id": "#moneyPositive",
      "description": "Definition of a positive money value",
      "type": "number",
      "multipleOf": 0.01,
      "minimum": 0,
      "maximum": 99999999.99
    },
    "ignore": {
      "type": "object",
      "properties": {
        "ignoreExpenses": {
          "const": true
        }
      },
      "additionalProperties": false,
      "required": ["ignoreExpenses"]
    },
    "expenses": {
      "type": "object",
      "properties": {
        "businessTravelCosts": {
          "$ref": "#/definitions/moneyPositive"
        },
        "jobExpenses": {
          "$ref": "#/definitions/moneyPositive"
        },
        "flatRateJobExpenses": {
          "$ref": "#/definitions/moneyPositive"
        },
        "professionalSubscriptions": {
          "$ref": "#/definitions/moneyPositive"
        },
        "hotelAndMealExpenses": {
          "$ref": "#/definitions/moneyPositive"
        },
        "otherAndCapitalAllowances": {
          "$ref": "#/definitions/moneyPositive"
        },
        "vehicleExpenses": {
          "$ref": "#/definitions/moneyPositive"
        },
        "mileageAllowanceRelief": {
          "$ref": "#/definitions/moneyPositive"
        }
      },
      "additionalProperties": false,
      "minProperties": 1
    }
  },
  "examples": [
    {
      "businessTravelCosts": 122.22,
      "jobExpenses": 124.22,
      "flatRateJobExpenses": 0.00,
      "professionalSubscriptions": 124.22,
      "hotelAndMealExpenses": 124.22,
      "otherAndCapitalAllowances": 123.12,
      "vehicleExpenses": 124.22,
      "mileageAllowanceRelief": 124.22
    },
    {
     "ignoreExpenses": true
    }
  ]
}
```



#### 5.2.6 Request Examples

##### 5.2.6.1 Ignore all Expenses

```json
{
  "ignoreExpenses": true
}
```



##### 5.2.6.2 Override Expenses

```json
{
  "expenses": {
    "businessTravelCosts": 122.22,
    "jobExpenses": 124.22,
    "flatRateJobExpenses": 124.22,
    "professionalSubscriptions": 124.22,
    "hotelAndMealExpenses": 124.22,
    "otherAndCapitalAllowances": 123.12,
    "vehicleExpenses": 124.22,
    "mileageAllowanceRelief": 124.22
  }
}
```



#### 5.2.7 Response Status Codes

| Response Code | Description            |
| :------------ | :--------------------- |
| 204           | Success                |
| 400           | Parameter error        |
| 401           | Unauthorised           |
| 422           | validation / bvr error |
| 404           | No data found          |
| 502           | Glitch in the matrix   |



#### 5.2.8 Response Schema

N/A

#### 5.2.9 Response Examples

N/A

#### 5.2.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 5.2.11 ITSD Components Impacted

- IBD

### 5.3 Delete Customer Expense Overrides

The customer can delete any overrides they have supplied via their third party software with regards to their employment expenses

#### 5.3.1 URI

**DELETE** */expenses/employments/{taxbleEntityId}/{taxYear}/*

#### 5.3.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 5.3.3 Query Parameters

N/A

#### 5.3.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 5.3.5 Request Schema

N/A

#### 5.3.6 Request Examples

N/A

#### 5.3.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 204           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 5.3.8 Response Schema

N/A

#### 5.3.9 Response Examples

N/A

#### 5.3.10 Response Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 5.3.11 ITSD Components Impacted

- IBD

## 6. Pension Charges

### 6.1 Retrieve Pension Related Charges

#### 6.1.1 URI

**GET** */charges/pensions/{taxableEntityId}/{taxYear}* 

#### 6.1.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 6.1.3 Query Parameters

| Parameter | Description                                                  | Optionality | Type    | Example / Values | Default Value |
| --------- | ------------------------------------------------------------ | ----------- | ------- | ---------------- | ------------- |
| internal  | Query parameter specifying that view should include historic data | Optional    | Boolean | true/false       | False         |

#### 6.1.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 6.1.5 Request Schema

N/A

#### 6.1.6 Request Examples

N/A

#### 6.1.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 200           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 6.1.8 Response Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Charges",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Get Pension Charges",
  "description": "A view of pensions charges",
  "type": "object",
  "oneOf": [
    {
      "$ref": "#/definitions/submission"
    },
    {
      "$ref": "#/definitions/submissionWithHistory"
    }
  ],
  "definitions": {
    "submission": {
      "type": "object",
      "additionalProperties": false,
      "required": ["submittedOn"],
      "anyOf": [
        {
          "required": ["pensionSavingsTaxCharges"]
        },
        {
          "required": ["pensionSchemeOverseasTransfers"]
        },
        {
          "required": ["pensionSchemeUnauthorisedPayments"]
        },
        {
          "required": ["pensionContributions"]
        },
        {
          "required": ["overseasPensionContributions"]
        }
      ],
      "properties": {
        "submittedOn": {
          "type": "string",
          "format": "date-time"
        },
        "deletedOn": {
          "type": "string",
          "format": "date-time"
        },
        "pensionSavingsTaxCharges": {
          "$ref": "#/definitions/pensionSavingsTaxChargesType"
        },
        "pensionSchemeOverseasTransfers": {
          "$ref": "#/definitions/pensionSchemeOverseasTransfersType"
        },
        "pensionSchemeUnauthorisedPayments": {
          "$ref": "#/definitions/pensionSchemeUnauthorisedPaymentsType"
        },
        "pensionContributions": {
          "$ref": "#/definitions/pensionContributionsType"
        },
        "overseasPensionContributions": {
          "$ref": "#/definitions/overseasPensionContributionsType"
        }
      }
    },
    "submissionWithHistory": {
      "type": "object",
      "additionalProperties": false,
      "required": ["submittedOn", "history"],
      "anyOf": [
        {
          "required": ["pensionSavingsTaxCharges"]
        },
        {
          "required": ["pensionSchemeOverseasTransfers"]
        },
        {
          "required": ["pensionSchemeUnauthorisedPayments"]
        },
        {
          "required": ["pensionContributions"]
        },
        {
          "required": ["overseasPensionContributions"]
        }
      ],
      "properties": {
        "submittedOn": {
          "type": "string",
          "format": "date-time"
        },
        "deletedOn": {
          "type": "string",
          "format": "date-time"
        },
        "pensionSavingsTaxCharges": {
          "$ref": "#/definitions/pensionSavingsTaxChargesType"
        },
        "pensionSchemeOverseasTransfers": {
          "$ref": "#/definitions/pensionSchemeOverseasTransfersType"
        },
        "pensionSchemeUnauthorisedPayments": {
          "$ref": "#/definitions/pensionSchemeUnauthorisedPaymentsType"
        },
        "pensionContributions": {
          "$ref": "#/definitions/pensionContributionsType"
        },
        "overseasPensionContributions": {
          "$ref": "#/definitions/overseasPensionContributionsType"
        },
        "history": {
          "$ref": "#/definitions/historyType"
        }
      }
    },
    "historyType": {
      "type": "array",
      "additionalItems": false,
      "items": {
        "$ref": "#/definitions/submission"
      }
    },
    "pensionSavingsTaxChargesType": {
      "type" : "object",
      "additionalProperties": false,
      "oneOf": [
        {
          "required": ["pensionSchemeTaxReference", "lumpSumBenefitTakenInExcessOfLifetimeAllowance"],
          "not": {"required": ["benefitInExcessOfLifetimeAllowance"]}},
        {
          "required": ["pensionSchemeTaxReference", "benefitInExcessOfLifetimeAllowance"],
          "not": {"required": ["lumpSumBenefitTakenInExcessOfLifetimeAllowance"]}
        },
        {"required": ["pensionSchemeTaxReference", "lumpSumBenefitTakenInExcessOfLifetimeAllowance","benefitInExcessOfLifetimeAllowance"]}
      ],
      "properties": {
        "pensionSchemeTaxReference": {
          "$ref" : "#/definitions/pensionSchemeTaxReference"
        },
        "lumpSumBenefitTakenInExcessOfLifetimeAllowance": {
          "type" : "object",
          "properties": {
            "amount": {
              "$ref": "#/definitions/moneyPositive"
            },
            "taxPaid": {
              "$ref": "#/definitions/moneyPositive"
            }
          },
          "additionalProperties": false,
          "required": ["amount"]
        },
        "benefitInExcessOfLifetimeAllowance": {
          "type" : "object",
          "properties": {
            "amount": {
              "$ref": "#/definitions/moneyPositive"
            },
            "taxPaid": {
              "$ref": "#/definitions/moneyPositive"
            }
          },
          "additionalProperties": false,
          "required": ["amount"]
        }
      }
    },
    "pensionSchemeOverseasTransfersType": {
      "type": "object",
      "additionalProperties": false,
      "required": ["overseasSchemeProvider","transferCharge"],
      "properties": {
        "overseasSchemeProvider": {
          "$ref": "#/definitions/overseasSchemeProvider"
        },
        "transferCharge": {
          "$ref": "#/definitions/moneyPositive"
        },
        "transferChargeTaxPaid": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "pensionSchemeUnauthorisedPaymentsType": {
      "type" : "object",
      "additionalProperties": false,
      "oneOf": [
        {
          "required": ["pensionSchemeTaxReference","surcharge"],
          "not": { "required": ["noSurcharge"]}
        },
        {
          "required": ["pensionSchemeTaxReference","noSurcharge"],
          "not": { "required": ["surcharge"]}
        },
        {
          "required": ["pensionSchemeTaxReference","surcharge","noSurcharge"]
        }
      ],
      "properties": {
        "pensionSchemeTaxReference": {
          "$ref" : "#/definitions/pensionSchemeTaxReference"
        },
        "surcharge": {
          "type": "object",
          "additionalProperties": false,
          "required": [ "amount"],
          "properties": {
            "amount": {
              "$ref" : "#/definitions/moneyPositive"
            },
            "foreignTaxPaid": {
              "$ref" : "#/definitions/moneyPositive"
            }
          }
        },
        "noSurcharge": {
          "type": "object",
          "additionalProperties": false,
          "required": [ "amount"],
          "properties": {
            "amount": {
              "$ref" : "#/definitions/moneyPositive"
            },
            "foreignTaxPaid": {
              "$ref" : "#/definitions/moneyPositive"
            }
          }
        }
      }
    },
    "pensionContributionsType": {
      "type": "object",
      "additionalProperties": false,
      "required": ["pensionSchemeTaxReference","inExcessOfTheAnnualAllowance"],
      "properties": {
        "pensionSchemeTaxReference": {
          "$ref" : "#/definitions/pensionSchemeTaxReference"
        },
        "inExcessOfTheAnnualAllowance": {
          "$ref": "#/definitions/moneyPositive"
        },
        "annualAllowanceTaxPaid": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "overseasPensionContributionsType": {
      "type": "object",
      "additionalProperties": false,
      "required": ["overseasSchemeProvider", "shortServiceRefund"],
      "properties": {
        "overseasSchemeProvider": {
          "$ref": "#/definitions/overseasSchemeProvider"
        },
        "shortServiceRefund": {
          "$ref": "#/definitions/moneyPositive"
        },
        "shortServiceRefundTaxPaid": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "pensionSchemeTaxReference": {
      "type": "array",
      "items" : {
        "type": "string",
        "pattern": "^[0-9]{8}[A-Z]{2}$"
      },
      "additionalItems": false,
      "minItems": 1
    },
    "schemeProvider": {
      "type": "object",
      "properties": {
        "providerName": {
          "type": "string",
          "maxLength": 105,
          "minLength": 1
        },
        "providerAddress": {
          "type": "string",
          "maxLength": 250,
          "minLength": 1
        },
        "providerCountryCode": {
          "$ref": "#/definitions/countryCodes"
        }
      },
      "additionalProperties": false,
      "required": ["providerName","providerAddress","providerCountryCode"]
    },
    "overseasSchemeProvider": {
      "type": "array",
      "additionalItems": false,
      "minItems": 1,
      "items": {
        "$ref": "#/definitions/schemeProvider"
      }
    },
    "moneyPositive": {
      "$id": "#moneyPositive",
      "type": "number",
      "minimum": 0.00,
      "maximum": 99999999999.99,
      "multipleOf": 0.01
    },
    "countryCodes": {
      "type": "string",
      "enum": [
        "ABW",
        "AFG",
        "AGO",
        "AIA",
        "ALA",
        "ALB",
        "AND",
        "ANT",
        "ARE",
        "ARG",
        "ARM",
        "ASM",
        "ATA",
        "ATF",
        "ATG",
        "AUS",
        "AUT",
        "AZE",
        "BDI",
        "BEL",
        "BEN",
        "BFA",
        "BGD",
        "BGR",
        "BHR",
        "BHS",
        "BIH",
        "BLM",
        "BLR",
        "BLZ",
        "BMU",
        "BOL",
        "BRA",
        "BRB",
        "BRN",
        "BTN",
        "BVT",
        "BWA",
        "CAF",
        "CAN",
        "CCK",
        "CHE",
        "CHL",
        "CHN",
        "CIV",
        "CMR",
        "COD",
        "COG",
        "COK",
        "COL",
        "COM",
        "CPV",
        "CRI",
        "CUB",
        "CXR",
        "CYM",
        "CYP",
        "CZE",
        "DEU",
        "DJI",
        "DMA",
        "DNK",
        "DOM",
        "DZA",
        "ECU",
        "EGY",
        "ERI",
        "ESH",
        "ESP",
        "EST",
        "ETH",
        "FIN",
        "FJI",
        "FLK",
        "FRA",
        "FRO",
        "FSM",
        "GAB",
        "GBR",
        "GEO",
        "GGY",
        "GHA",
        "GIB",
        "GIN",
        "GLP",
        "GMB",
        "GNB",
        "GNQ",
        "GRC",
        "GRD",
        "GRL",
        "GTM",
        "GUF",
        "GUM",
        "GUY",
        "HKG",
        "HMD",
        "HND",
        "HRV",
        "HTI",
        "HUN",
        "IDN",
        "IMN",
        "IND",
        "IOT",
        "IRL",
        "IRN",
        "IRQ",
        "ISL",
        "ISR",
        "ITA",
        "JAM",
        "JEY",
        "JOR",
        "JPN",
        "KAZ",
        "KEN",
        "KGZ",
        "KHM",
        "KIR",
        "KNA",
        "KOR",
        "KWT",
        "LAO",
        "LBN",
        "LBR",
        "LBY",
        "LCA",
        "LIE",
        "LKA",
        "LSO",
        "LTU",
        "LUX",
        "LVA",
        "MAC",
        "MAF",
        "MAR",
        "MCO",
        "MDA",
        "MDG",
        "MDV",
        "MEX",
        "MHL",
        "MKD",
        "MLI",
        "MLT",
        "MMR",
        "MNE",
        "MNG",
        "MNP",
        "MOZ",
        "MRT",
        "MSR",
        "MTQ",
        "MUS",
        "MWI",
        "MYS",
        "MYT",
        "NAM",
        "NCL",
        "NER",
        "NFK",
        "NGA",
        "NIC",
        "NIU",
        "NLD",
        "NOR",
        "NPL",
        "NRU",
        "NZL",
        "OMN",
        "PAK",
        "PAN",
        "PCN",
        "PER",
        "PHL",
        "PLW",
        "PNG",
        "POL",
        "PRI",
        "PRK",
        "PRT",
        "PRY",
        "PSE",
        "PYF",
        "QAT",
        "REU",
        "ROU",
        "RUS",
        "RWA",
        "SAU",
        "SDN",
        "SEN",
        "SGP",
        "SGS",
        "SHN",
        "SJM",
        "SLB",
        "SLE",
        "SLV",
        "SMR",
        "SOM",
        "SPM",
        "SRB",
        "STP",
        "SUR",
        "SVK",
        "SVN",
        "SWE",
        "SWZ",
        "SYC",
        "SYR",
        "TCA",
        "TCD",
        "TGO",
        "THA",
        "TJK",
        "TKL",
        "TKM",
        "TLS",
        "TON",
        "TTO",
        "TUN",
        "TUR",
        "TUV",
        "TWN",
        "TZA",
        "UGA",
        "UKR",
        "UMI",
        "URY",
        "USA",
        "UZB",
        "VAT",
        "VCT",
        "VEN",
        "VGB",
        "VIR",
        "VNM",
        "VUT",
        "WLF",
        "WSM",
        "YEM",
        "ZAF",
        "ZMB",
        "ZWE"
      ]
    }
  }
}
```

#### 6.1.9 Response Examples

##### 6.1.9.1 Without History

```json
{
  "submittedOn": "2020-03-03T01:01:01Z",
  "pensionSavingsTaxCharges": {
   
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA" //8 digits followed by 2 letters first of which must be an R
    ],
    "lumpSumBenefitTakenInExcessOfLifetimeAllowance": {
      "amount": 1213.0,
      "taxPaid": 123.0 // Mandataory when amount is present can be ZERO
    },
    "benefitInExcessOfLifetimeAllowance": {
      "amount": 1213.0,
      "taxPaid": 123.0 //Mandatory when amount is present CAN BE ZERO
    },
    "isAnnualAllowanceReduced": true, // if this is true then one of tapered annual allowance or moneyPallowance must also be true
    "taperedAnnualAllowance" : true, // 
    "moneyPurchasedAllowance": false // 
    
  },
  "pensionSchemeOverseasTransfers": {
    "overseasSchemeProvider": [
      {
        "providerName": "Overseas Pensions Plc",
        "providerAddress": "111 Main Street, George Town, Grand Cayman",
        "countryCode": "CYM", //CHANGED 
        "pensionSchemeTaxReference": "00123456RA", //pstr qrops are optional but mutually exclusive
        "qualifyingRecognisedOverseasPensionScheme": "Q123456" //Total 7 must start with Q followed by 6 digits
      }
    ],
    "transferCharge": 123.0,
    "transferChargeTaxPaid": 123.00 //Mandatory at least zero
    
  },
  "pensionSchemeUnauthorisedPayments": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "surcharge": {
      "amount": 123.0,
      "foreignTaxPaid": 123.0 //Mandatory can be zero
    },
    "noSurcharge": { 
      "amount" : 123.00,
      "foreignTaxPaid": 123.00 //Mandatory can be zero 
    }
  },
  "pensionContributions": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "inExcessOfTheAnnualAllowance": 123.0,
    "annualAllowanceTaxPaid": 123.0 //Mandatory can be zero
  },
  "overseasPensionContributions": {
    "overseasSchemeProvider": [
      {
        "providerName": "Overseas Pensions Plc",
        "providerAddress": "111 Main Street, George Town, Grand Cayman",
        "countryCode": "CYM" //CHANGED
      }
    ],
    "shortServiceRefund": 123.0,
    "shortServiceRefundTaxPaid": 123.0 //Mandatory can be zero 
  }
}
```

##### 6.1.9.2 With History Empty

```json
{
  "submittedOn": "2020-03-03T01:01:01Z",
  "pensionSavingsTaxCharges": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "lumpSumBenefitTakenInExcessOfLifetimeAllowance": {
      "amount": 1213.0,
      "taxPaid": 123.0
    },
    "benefitInExcessOfLifetimeAllowance": {
      "amount": 1213.0,
      "taxPaid": 123.0
    }
  },
  "pensionSchemeOverseasTransfers": {
    "overseasSchemeProvider": [
      {
        "providerName": "Overseas Pensions Plc",
        "providerAddress": "111 Main Street, George Town, Grand Cayman",
        "providerCountryCode": "CYM"
      }
    ],
    "transferCharge": 123.0,
    "transferChargeTaxPaid": 123.0
  },
  "pensionSchemeUnauthorisedPayments": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "surcharge": {
      "amount": 123.0,
      "foreignTaxPaid": 123.0 //Mandatory can be zero
    }
  },
  "pensionContributions": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "inExcessOfTheAnnualAllowance": 123.0,
    "annualAllowanceTaxPaid": 123.0
  },
  "overseasPensionContributions": {
    "overseasSchemeProvider": [
      {
        "providerName": "Overseas Pensions Plc",
        "providerAddress": "111 Main Street, George Town, Grand Cayman",
        "providerCountryCode": "CYM"
      }
    ],
    "shortServiceRefund": 123.0,
    "shortServiceRefundTaxPaid": 123.0
  },
  "history": []
}
```

##### 6.1.9.3 With History 

```json
{
  "submittedOn": "2020-03-03T01:01:01Z",
  "pensionSavingsTaxCharges": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "lumpSumBenefitTakenInExcessOfLifetimeAllowance": {
      "amount": 1213.0,
      "taxPaid": 123.0
    },
    "benefitInExcessOfLifetimeAllowance": {
      "amount": 1213.0,
      "taxPaid": 123.0
    }
  },
  "pensionSchemeOverseasTransfers": {
    "overseasSchemeProvider": [
      {
        "providerName": "Overseas Pensions Plc",
        "providerAddress": "111 Main Street, George Town, Grand Cayman",
        "providerCountryCode": "CYM"
      }
    ],
    "transferCharge": 123.0,
    "transferChargeTaxPaid": 123.0
  },
  "pensionSchemeUnauthorisedPayments": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "surcharge": {
      "amount": 123.0,
      "foreignTaxPaid": 123.0
    }
  },
  "pensionContributions": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "inExcessOfTheAnnualAllowance": 123.0,
    "annualAllowanceTaxPaid": 123.0
  },
  "overseasPensionContributions": {
    "overseasSchemeProvider": [
      {
        "providerName": "Overseas Pensions Plc",
        "providerAddress": "111 Main Street, George Town, Grand Cayman",
        "providerCountryCode": "CYM"
      }
    ],
    "shortServiceRefund": 123.0,
    "shortServiceRefundTaxPaid": 123.0
  },
  "history": [
    {
      "submittedOn": "2020-03-03T01:01:01Z",
      "pensionSavingsTaxCharges": {
        "pensionSchemeTaxReference": [
          "00123456RA",
          "00654321RA"
        ],
        "lumpSumBenefitTakenInExcessOfLifetimeAllowance": {
          "amount": 1213.0,
          "taxPaid": 123.0
        },
        "benefitInExcessOfLifetimeAllowance": {
          "amount": 1213.0,
          "taxPaid": 123.0
        }
      },
      "pensionSchemeOverseasTransfers": {
        "overseasSchemeProvider": [
          {
            "providerName": "Overseas Pensions Plc",
            "providerAddress": "111 Main Street, George Town, Grand Cayman",
            "providerCountryCode": "CYM"
          }
        ],
        "transferCharge": 123.0,
        "transferChargeTaxPaid": 123.0
      },
      "pensionSchemeUnauthorisedPayments": {
        "pensionSchemeTaxReference": [
          "00123456RA",
          "00654321RA"
        ],
        "surcharge": {
          "amount": 123.0,
          "foreignTaxPaid": 123.0
        }
      },
      "pensionContributions": {
        "pensionSchemeTaxReference": [
          "00123456RA",
          "00654321RA"
        ],
        "inExcessOfTheAnnualAllowance": 123.0,
        "annualAllowanceTaxPaid": 123.0
      },
      "overseasPensionContributions": {
        "overseasSchemeProvider": [
          {
            "providerName": "Overseas Pensions Plc",
            "providerAddress": "111 Main Street, George Town, Grand Cayman",
            "providerCountryCode": "CYM"
          }
        ],
        "shortServiceRefund": 123.0,
        "shortServiceRefundTaxPaid": 123.0
      }
    }
  ]
}
```



#### 6.1.10 Response Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 6.1.11 ITSD Components Impacted

* IBD

### 6.2 Declare pension related charges. 

#### 6.2.1 URI

**PUT** */charges/pensions/{taxableEntityId}/{taxYear}* 

#### 6.2.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 6.2.3 Query Parameters

N/A

#### 6.2.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 6.2.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Submit_Pension_Charges",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Submit Pension Charges",
  "description": "Customer provided pension charges",
  "type": "object",
  "additionalProperties": false,
  "minProperties": 1,
  "properties": {
    "pensionSavingsTaxCharges": {
      "$ref": "#/definitions/pensionSavingsTaxChargesType"
    },
    "pensionSchemeOverseasTransfers": {
      "$ref": "#/definitions/pensionSchemeOverseasTransfersType"
    },
    "pensionSchemeUnauthorisedPayments": {
      "$ref": "#/definitions/pensionSchemeUnauthorisedPaymentsType"
    },
    "pensionContributions": {
      "$ref": "#/definitions/pensionContributionsType"
    },
    "overseasPensionContributions": {
      "$ref": "#/definitions/overseasPensionContributionsType"
    }
  },
  "definitions": {
    "pensionSavingsTaxChargesType": {
      "type" : "object",
      "additionalProperties": false,
      "oneOf": [
        {
          "required": ["pensionSchemeTaxReference", "lumpSumBenefitTakenInExcessOfLifetimeAllowance"],
          "not": {"required": ["benefitInExcessOfLifetimeAllowance"]}},
        {
          "required": ["pensionSchemeTaxReference", "benefitInExcessOfLifetimeAllowance"],
          "not": {"required": ["lumpSumBenefitTakenInExcessOfLifetimeAllowance"]}
        },
        {"required": ["pensionSchemeTaxReference", "lumpSumBenefitTakenInExcessOfLifetimeAllowance","benefitInExcessOfLifetimeAllowance"]}
      ],
      "properties": {
        "pensionSchemeTaxReference": {
          "$ref" : "#/definitions/pensionSchemeTaxReference"
        },
        "lumpSumBenefitTakenInExcessOfLifetimeAllowance": {
          "type" : "object",
          "properties": {
            "amount": {
              "$ref": "#/definitions/moneyPositive"
            },
            "taxPaid": {
              "$ref": "#/definitions/moneyPositive"
            }
          },
          "additionalProperties": false,
          "required": ["amount"]
        },
        "benefitInExcessOfLifetimeAllowance": {
          "type" : "object",
          "properties": {
            "amount": {
              "$ref": "#/definitions/moneyPositive"
            },
            "taxPaid": {
              "$ref": "#/definitions/moneyPositive"
            }
          },
          "additionalProperties": false,
          "required": ["amount"]
        }
      }
    },
    "pensionSchemeOverseasTransfersType": {
      "type": "object",
      "additionalProperties": false,
      "required": ["overseasSchemeProvider","transferCharge"],
      "properties": {
        "overseasSchemeProvider": {
          "$ref": "#/definitions/overseasSchemeProvider"
        },
        "transferCharge": {
          "$ref": "#/definitions/moneyPositive"
        },
        "transferChargeTaxPaid": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "pensionSchemeUnauthorisedPaymentsType": {
      "type" : "object",
      "additionalProperties": false,
      "oneOf": [
        {
          "required": ["pensionSchemeTaxReference","surcharge"],
          "not": { "required": ["noSurcharge"]}
        },
        {
          "required": ["pensionSchemeTaxReference","noSurcharge"],
          "not": { "required": ["surcharge"]}
        },
        {
          "required": ["pensionSchemeTaxReference","surcharge","noSurcharge"]
        }
      ],
      "properties": {
        "pensionSchemeTaxReference": {
          "$ref" : "#/definitions/pensionSchemeTaxReference"
        },
        "surcharge": {
          "type": "object",
          "additionalProperties": false,
          "required": [ "amount"],
          "properties": {
            "amount": {
              "$ref" : "#/definitions/moneyPositive"
            },
            "foreignTaxPaid": {
              "$ref" : "#/definitions/moneyPositive"
            }
          }
        },
        "noSurcharge": {
          "type": "object",
          "additionalProperties": false,
          "required": [ "amount"],
          "properties": {
            "amount": {
              "$ref" : "#/definitions/moneyPositive"
            },
            "foreignTaxPaid": {
              "$ref" : "#/definitions/moneyPositive"
            }
          }
        }
      }
    },
    "pensionContributionsType": {
      "type": "object",
      "additionalProperties": false,
      "required": ["pensionSchemeTaxReference","inExcessOfTheAnnualAllowance"],
      "properties": {
        "pensionSchemeTaxReference": {
          "$ref" : "#/definitions/pensionSchemeTaxReference"
        },
        "inExcessOfTheAnnualAllowance": {
          "$ref": "#/definitions/moneyPositive"
        },
        "annualAllowanceTaxPaid": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "overseasPensionContributionsType": {
      "type": "object",
      "additionalProperties": false,
      "required": ["overseasSchemeProvider", "shortServiceRefund"],
      "properties": {
        "overseasSchemeProvider": {
          "$ref": "#/definitions/overseasSchemeProvider"
        },
        "shortServiceRefund": {
          "$ref": "#/definitions/moneyPositive"
        },
        "shortServiceRefundTaxPaid": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "pensionSchemeTaxReference": {
      "type": "array",
      "items" : {
        "type": "string",
        "pattern": "^[0-9]{8}[A-Z]{2}$"
      },
      "additionalItems": false,
      "minItems": 1
    },
    "schemeProvider": {
      "type": "object",
      "properties": {
        "providerName": {
          "type": "string",
          "maxLength": 105,
          "minLength": 1
        },
        "providerAddress": {
          "type": "string",
          "maxLength": 250,
          "minLength": 1
        },
        "providerCountryCode": {
          "$ref": "#/definitions/countryCodes"
        }
      },
      "additionalProperties": false,
      "required": ["providerName","providerAddress","providerCountryCode"]
    },
    "overseasSchemeProvider": {
      "type": "array",
      "additionalItems": false,
      "minItems": 1,
      "items": {
        "$ref": "#/definitions/schemeProvider"
      }
    },
    "moneyPositive": {
      "$id": "#moneyPositive",
      "type": "number",
      "minimum": 0.00,
      "maximum": 99999999999.99,
      "multipleOf": 0.01
    },
    "countryCodes": {
      "type": "string",
      "enum": [
        "ABW",
        "AFG",
        "AGO",
        "AIA",
        "ALA",
        "ALB",
        "AND",
        "ANT",
        "ARE",
        "ARG",
        "ARM",
        "ASM",
        "ATA",
        "ATF",
        "ATG",
        "AUS",
        "AUT",
        "AZE",
        "BDI",
        "BEL",
        "BEN",
        "BFA",
        "BGD",
        "BGR",
        "BHR",
        "BHS",
        "BIH",
        "BLM",
        "BLR",
        "BLZ",
        "BMU",
        "BOL",
        "BRA",
        "BRB",
        "BRN",
        "BTN",
        "BVT",
        "BWA",
        "CAF",
        "CAN",
        "CCK",
        "CHE",
        "CHL",
        "CHN",
        "CIV",
        "CMR",
        "COD",
        "COG",
        "COK",
        "COL",
        "COM",
        "CPV",
        "CRI",
        "CUB",
        "CXR",
        "CYM",
        "CYP",
        "CZE",
        "DEU",
        "DJI",
        "DMA",
        "DNK",
        "DOM",
        "DZA",
        "ECU",
        "EGY",
        "ERI",
        "ESH",
        "ESP",
        "EST",
        "ETH",
        "FIN",
        "FJI",
        "FLK",
        "FRA",
        "FRO",
        "FSM",
        "GAB",
        "GBR",
        "GEO",
        "GGY",
        "GHA",
        "GIB",
        "GIN",
        "GLP",
        "GMB",
        "GNB",
        "GNQ",
        "GRC",
        "GRD",
        "GRL",
        "GTM",
        "GUF",
        "GUM",
        "GUY",
        "HKG",
        "HMD",
        "HND",
        "HRV",
        "HTI",
        "HUN",
        "IDN",
        "IMN",
        "IND",
        "IOT",
        "IRL",
        "IRN",
        "IRQ",
        "ISL",
        "ISR",
        "ITA",
        "JAM",
        "JEY",
        "JOR",
        "JPN",
        "KAZ",
        "KEN",
        "KGZ",
        "KHM",
        "KIR",
        "KNA",
        "KOR",
        "KWT",
        "LAO",
        "LBN",
        "LBR",
        "LBY",
        "LCA",
        "LIE",
        "LKA",
        "LSO",
        "LTU",
        "LUX",
        "LVA",
        "MAC",
        "MAF",
        "MAR",
        "MCO",
        "MDA",
        "MDG",
        "MDV",
        "MEX",
        "MHL",
        "MKD",
        "MLI",
        "MLT",
        "MMR",
        "MNE",
        "MNG",
        "MNP",
        "MOZ",
        "MRT",
        "MSR",
        "MTQ",
        "MUS",
        "MWI",
        "MYS",
        "MYT",
        "NAM",
        "NCL",
        "NER",
        "NFK",
        "NGA",
        "NIC",
        "NIU",
        "NLD",
        "NOR",
        "NPL",
        "NRU",
        "NZL",
        "OMN",
        "PAK",
        "PAN",
        "PCN",
        "PER",
        "PHL",
        "PLW",
        "PNG",
        "POL",
        "PRI",
        "PRK",
        "PRT",
        "PRY",
        "PSE",
        "PYF",
        "QAT",
        "REU",
        "ROU",
        "RUS",
        "RWA",
        "SAU",
        "SDN",
        "SEN",
        "SGP",
        "SGS",
        "SHN",
        "SJM",
        "SLB",
        "SLE",
        "SLV",
        "SMR",
        "SOM",
        "SPM",
        "SRB",
        "STP",
        "SUR",
        "SVK",
        "SVN",
        "SWE",
        "SWZ",
        "SYC",
        "SYR",
        "TCA",
        "TCD",
        "TGO",
        "THA",
        "TJK",
        "TKL",
        "TKM",
        "TLS",
        "TON",
        "TTO",
        "TUN",
        "TUR",
        "TUV",
        "TWN",
        "TZA",
        "UGA",
        "UKR",
        "UMI",
        "URY",
        "USA",
        "UZB",
        "VAT",
        "VCT",
        "VEN",
        "VGB",
        "VIR",
        "VNM",
        "VUT",
        "WLF",
        "WSM",
        "YEM",
        "ZAF",
        "ZMB",
        "ZWE"
      ]
    }
  }
}
```



#### 6.2.6 Request Examples

```json
{
  "pensionSavingsTaxCharges": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "lumpSumBenefitTakenInExcessOfLifetimeAllowance": {
      "amount": 1213.0,
      "taxPaid": 123.0
    },
    "benefitInExcessOfLifetimeAllowance": {
      "amount": 1213.0,
      "taxPaid": 123.0
    }
  },
  "pensionSchemeOverseasTransfers": {
    "overseasSchemeProvider": [
      {
        "providerName": "Overseas Pensions Plc",
        "providerAddress": "111 Main Street, George Town, Grand Cayman",
        "countryCode": "CYM" //CHANGED 
      }
    ],
    "transferCharge": 123.0,
    "transferChargeTaxPaid": 123.0
  },
  "pensionSchemeUnauthorisedPayments": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "surcharge": {
      "amount": 123.0,
      "foreignTaxPaid": 123.0
    }
  },
  "pensionContributions": {
    "pensionSchemeTaxReference": [
      "00123456RA",
      "00654321RA"
    ],
    "inExcessOfTheAnnualAllowance": 123.0,
    "annualAllowanceTaxPaid": 123.0
  },
  "overseasPensionContributions": {
    "overseasSchemeProvider": [
      {
        "providerName": "Overseas Pensions Plc",
        "providerAddress": "111 Main Street, George Town, Grand Cayman",
        "countryCode": "CYM" //CHANGED NAME
      }
    ],
    "shortServiceRefund": 123.0,
    "shortServiceRefundTaxPaid": 123.0
  }
}
```



#### 6.2.7 Response Status Code

| Response Code | Description            |
| :------------ | :--------------------- |
| 204           | Success                |
| 400           | Parameter error        |
| 401           | Unauthorised           |
| 422           | validation / bvr error |
| 404           | No data found          |
| 502           | Glitch in the matrix   |

#### 6.2.8 Response Schema

N/A

#### 6.2.9 Response Examples

N/A

#### 6.2.10 Response Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 6.2.11 ITSD Components Impacted

- IBD

### 6.3 Delete Pension Related Charges

#### 6.3.1 URI

**DELETE** */charges/pensions/{taxableEntityId}/{taxYear}* 

#### 6.3.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 6.3.3 Query Parameters

N/A

#### 6.3.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 6.3.5 Request Schema

N/A

#### 6.3.6 Request Examples

N/A

#### 6.3.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 204           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 6.3.8 Response Schema

N/A

#### 6.3.9 Response Examples

N/A

#### 6.3.10 Response Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 6.3.11 ITSD Components Impacted

* IBD

## 7. Pension Related Reliefs

### 7.1 Retrieve Pension Related Reliefs

#### 7.1.1 URI

**GET** */reliefs/pensions/{taxableEntityId}/{taxYear}*

#### 7.1.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 7.1.3 Query Parameters

| Parameter | Description                                                  | Optionality | Type    | Example / Values | Default Value |
| --------- | ------------------------------------------------------------ | ----------- | ------- | ---------------- | ------------- |
| internal  | Query parameter specifying that view should include historic data | Optional    | Boolean | true/false       | False         |

#### 7.1.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 7.1.5 Request Schema

N/A

#### 7.1.6 Request Examples

N/A

#### 7.1.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 200           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 7.1.8 Response Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Get_Pension_Reliefs",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Get Pension Reliefs",
  "description": "A view of pensions reliefs",
  "type": "object",
  "oneOf": [
    {"$ref": "#/definitions/submission"},
    {"$ref": "#/definitions/submissionWithHistory"}
  ],
  "definitions": {
    "submission": {
      "type": "object",
      "additionalProperties": false,
      "required": ["pensionReliefs","submittedOn"],
      "properties": {
        "submittedOn": {
          "type": "string",
          "format": "date-time"
        },
        "deletedOn": {
          "type": "string",
          "format": "date-time"
        },
        "pensionReliefs": {
          "type": "object",
          "additionalProperties": false,
          "minProperties": 1,
          "properties": {
            "regularPensionContributions": {
              "$ref": "#/definitions/moneyPositive"
            },
            "oneOffPensionContributionsPaid": {
              "$ref": "#/definitions/moneyPositive"
            },
            "retirementAnnuityPayments": {
              "$ref": "#/definitions/moneyPositive"
            },
            "paymentToEmployersSchemeNoTaxRelief": {
              "$ref": "#/definitions/moneyPositive"
            },
            "overseasPensionSchemeContributions": {
              "$ref": "#/definitions/moneyPositive"
            }
          }
        }
      }
    },
    "submissionWithHistory": {
      "type": "object",
      "additionalProperties": false,
      "required": ["pensionReliefs","submittedOn", "history"],

      "properties": {
        "submittedOn": {
          "type": "string",
          "format": "date-time"
        },
        "deletedOn": {
          "type": "string",
          "format": "date-time"
        },
        "pensionReliefs": {
          "type": "object",
          "additionalProperties": false,
          "minProperties": 1,
          "properties": {
            "regularPensionContributions": {
              "$ref": "#/definitions/moneyPositive"
            },
            "oneOffPensionContributionsPaid": {
              "$ref": "#/definitions/moneyPositive"
            },
            "retirementAnnuityPayments": {
              "$ref": "#/definitions/moneyPositive"
            },
            "paymentToEmployersSchemeNoTaxRelief": {
              "$ref": "#/definitions/moneyPositive"
            },
            "overseasPensionSchemeContributions": {
              "$ref": "#/definitions/moneyPositive"
            }
          }
        },
        "history": {
          "type": "array",
          "additionalItems": false,
          "items": {
            "$ref": "#/definitions/submission"
          }
        }
      }
    },
    "moneyPositive": {
      "$id": "#moneyPositive",
      "type": "number",
      "minimum": 0.00,
      "maximum": 99999999999.99,
      "multipleOf": 0.01
    }
  }
}
```

#### 7.1.9 Response Examples

##### 7.1.9.1 No History

```json
{
  "submittedOn":"timestamp",
	"pensionReliefs": { //Mandatory at least 1 child node
    "regularPensionContributions:": 123.00, //99999999999.99
    "oneOffPensionContributionsPaid": 123.00,
    "retirementAnnuityPayments": 123.00,
    "paymentToEmployersSchemeNoTaxRelief": 123.00,
    "overseasPensionSchemeContributions": 123.00
   }  
}
```

##### 7.1.9.2 With Empty History

```json
{
  "submittedOn":"timestamp",
  "deletedOn":"timestamp",//optional
	"pensionReliefs": { //Mandatory at least 1 child node
    "regularPensionContributions:": 123.00, //99999999999.99
    "oneOffPensionContributionsPaid": 123.00,
    "retirementAnnuityPayments": 123.00,
    "paymentToEmployersSchemeNoTaxRelief": 123.00,
    "overseasPensionSchemeContributions": 123.00
   },
  "history":[]
}
```

##### 7.1.9.3 With History

```json
{
  "submittedOn":"timestamp",
  "deletedOn":"timestamp",//optional
	"pensionReliefs": { //Mandatory at least 1 child node
    "regularPensionContributions": 123.00, //99999999999.99
    "oneOffPensionContributionsPaid": 123.00,
    "retirementAnnuityPayments": 123.00,
    "paymentToEmployersSchemeNoTaxRelief": 123.00,
    "overseasPensionSchemeContributions": 123.00
   },
  "history":[
    {
      "submittedOn":"timestamp",
      "pensionReliefs": { //Mandatory at least 1 child node
        "regularPensionContributions:": 123.00, //99999999999.99
        "oneOffPensionContributionsPaid": 123.00,
        "retirementAnnuityPayments": 123.00,
        "paymentToEmployersSchemeNoTaxRelief": 123.00,
        "overseasPensionSchemeContributions": 123.00
   }     
    }
  ]
}
```



#### 7.1.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 7.1.11 ITSD Components Impacted

- IBD

### 7.2 Declare Pensions Reliefs

#### 7.2.1 URI

**PUT** */reliefs/{taxableEntityId}/{taxYear}

#### 7.2.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 7.2.3 Query Parameters

N/A

#### 7.2.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 7.2.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/Submit_Pension_Reliefs",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Submit Pension Reliefs",
  "description": "Submit pensions reliefs",
  "type": "object",
  "additionalProperties": false,
  "required": [
    "pensionReliefs"
  ],
  "properties": {
    "pensionReliefs": {
      "type": "object",
      "additionalProperties": false,
      "minProperties": 1,
      "properties": {
        "regularPensionContributions": {
          "$ref": "#/definitions/moneyPositive"
        },
        "oneOffPensionContributionsPaid": {
          "$ref": "#/definitions/moneyPositive"
        },
        "retirementAnnuityPayments": {
          "$ref": "#/definitions/moneyPositive"
        },
        "paymentToEmployersSchemeNoTaxRelief": {
          "$ref": "#/definitions/moneyPositive"
        },
        "overseasPensionSchemeContributions": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    }
  },
  "definitions": {
    "moneyPositive": {
      "$id": "#moneyPositive",
      "type": "number",
      "minimum": 0.0,
      "maximum": 99999999999.99,
      "multipleOf": 0.01
    }
  }
}
```

#### 7.2.6 Request Examples

```json
{
  "pensionReliefs": {
    "regularPensionContributions": 123.00, 
    "oneOffPensionContributionsPaid": 123.00,
    "retirementAnnuityPayments": 123.00,
    "paymentToEmployersSchemeNoTaxRelief": 123.00,
    "overseasPensionSchemeContributions": 123.00,
   }
}
```

#### 7.2.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 204           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 7.2.8 Response Schema

N/A

#### 7.2.9 Response Examples

N/A

#### 7.2.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 7.2.11 ITSD Components Impacted

- IBD

### 7.3 Delete Pensions Reliefs

#### 7.3.1 URI

**DELETE** */reliefs/pensions/{taxableEntityId}/{taxYear}*

#### 7.3.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 7.3.3 Query Parameters

N/A

#### 7.3.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 7.3.5 Request Schema

N/A

#### 7.3.6 Request Examples

N/A

#### 7.3.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 204           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 7.3.8 Response Schema

N/A

#### 7.3.9 Response Examples

N/A

#### 7.3.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 7.3.11 ITSD Components Impacted

- IBD



## 8 State Benefits

### 8.1 View State Benefits - Note need to include 3 views (HMRC, CUSTOMER, LATEST)

This operation allows a customer to list their state benefits

#### 8.1.1 URI

**GET** */income/state-benefits/{taxableEntityId}/{taxYear}*/

#### 8.1.2 Path Parameters

| Parameter       | Description                               | Example  |
| --------------- | ----------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer         | AB123456 |
| taxYear         | The tax year to which the benefit applies | 2019-20  |

#### 8.1.3 Query Parameters

| Parameter | Description                                                  | Optionality | Type    | Example / Values | Default Value |
| --------- | ------------------------------------------------------------ | ----------- | ------- | ---------------- | ------------- |
| internal  | Query parameter specifying that view should include historic data | Optional    | Boolean | true/false       | False         |

#### 8.1.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 8.1.5 Request Schema

N/A

#### 8.1.6 Request Examples

N/A

#### 8.1.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 200           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 8.1.8 Response Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/View_State_Benefits",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Get State Benefits",
  "description": "View a list of State Benefits & Pensions associated with the customer, the list may contain Benefits that the customer has added via their third party software, these are clearly marked.",
  "type": "object",
  "minItems": 1,
  "properties": {
    "stateBenefits": {
      "$ref": "#/definitions/stateBenefits"
    },
    "customerAddedStateBenefits": {
      "$ref": "#/definitions/customerAddedStateBenefits"
    }
  },
  "definitions": {
    "benefitId": {
      "description": "Unique identifier of the benrfit",
      "type": "string",
      "pattern": "^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$",
      "format": "uuid"
    },
    "startDate": {
      "type": "string",
      "format": "date"
    },
    "endDate": {
      "type": "string",
      "format": "date"
    },
    "dateIgnored": {
      "type": "string",
      "format": "date-time",
      "description": "An ISO-8601 compliant date-time representing when the customer requested the data set was ignored."
    },
    "submittedOn": {
      "type": "string",
      "format": "date-time",
      "description": "An ISO-8601 compliant date-time representing when the customer requested the data set was ignored."
    },
    "moneyZeroToPositive": {
      "description": "Definition of zero to positive money value",
      "type": "number",
      "multipleOf": 0.01,
      "minimum": 0,
      "maximum": 99999999.99
    },
    "moneyPositive": {
      "description": "Definition of a positive money value",
      "type": "number",
      "multipleOf": 0.01,
      "minimum": 0.01,
      "maximum": 99999999.99
    },
    "incapacityBenefit": {
      "type": "array",
      "additionalProperties": false,
      "required": [
        "benefitId",
        "startDate",
        "amount",
        "taxPaid"
      ],
      "properties": {
        "dateIgnored": {
          "$ref": "#/definitions/dateIgnored"
        },
        "submittedOn": {
          "$ref": "#/definitions/submittedOn"
        },
        "benefitId": {
          "$ref": "#/definitions/benefitId"
        },
        "startDate": {
          "$ref": "#/definitions/startDate"
        },
        "endDate": {
          "$ref": "#/definitions/endDate"
        },
        "amount": {
          "$ref": "#/definitions/moneyPositive"
        },
        "taxPaid": {
          "$ref": "#/definitions/moneyZeroToPositive"
        }
      }
    },
    "statePension": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "benefitId",
        "startDate",
        "amount"
      ],
      "properties": {
        "dateIgnored": {
          "$ref": "#/definitions/dateIgnored"
        },
        "submittedOn": {
          "$ref": "#/definitions/submittedOn"
        },
        "benefitId": {
          "$ref": "#/definitions/benefitId"
        },
        "startDate": {
          "$ref": "#/definitions/startDate"
        },
        "endDate": {
          "$ref": "#/definitions/endDate"
        },
        "amount": {
          "$ref": "#/definitions/moneyPositive"
        },
        "taxPaid": {
          "$ref": "#/definitions/moneyZeroToPositive"
        }
      }
    },
    "statePensionLumpSum": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "benefitId",
        "startDate",
        "amount",
        "taxPaid"
      ],
      "properties": {
        "dateIgnored": {
          "$ref": "#/definitions/dateIgnored"
        },
        "submittedOn": {
          "$ref": "#/definitions/submittedOn"
        },
        "benefitId": {
          "$ref": "#/definitions/benefitId"
        },
        "startDate": {
          "$ref": "#/definitions/startDate"
        },
        "endDate": {
          "$ref": "#/definitions/endDate"
        },
        "amount": {
          "$ref": "#/definitions/moneyPositive"
        },
        "taxPaid": {
          "$ref": "#/definitions/moneyZeroToPositive"
        }
      }
    },
    "employmentSupportAllowance": {
      "type": "array",
      "additionalProperties": false,
      "required": [
        "benefitId",
        "startDate",
        "amount",
        "taxPaid"
      ],
      "properties": {
        "dateIgnored": {
          "$ref": "#/definitions/dateIgnored"
        },
        "submittedOn": {
          "$ref": "#/definitions/submittedOn"
        },
        "benefitId": {
          "$ref": "#/definitions/benefitId"
        },
        "startDate": {
          "$ref": "#/definitions/startDate"
        },
        "endDate": {
          "$ref": "#/definitions/endDate"
        },
        "amount": {
          "$ref": "#/definitions/moneyPositive"
        },
        "taxPaid": {
          "$ref": "#/definitions/moneyZeroToPositive"
        }
      }
    },
    "jobSeekersAllowance": {
      "type": "array",
      "additionalProperties": false,
      "required": [
        "benefitId",
        "startDate",
        "amount",
        "taxPaid"
      ],
      "properties": {
        "dateIgnored": {
          "$ref": "#/definitions/dateIgnored"
        },
        "submittedOn": {
          "$ref": "#/definitions/submittedOn"
        },
        "benefitId": {
          "$ref": "#/definitions/benefitId"
        },
        "startDate": {
          "$ref": "#/definitions/startDate"
        },
        "endDate": {
          "$ref": "#/definitions/endDate"
        },
        "amount": {
          "$ref": "#/definitions/moneyPositive"
        },
        "taxPaid": {
          "$ref": "#/definitions/moneyZeroToPositive"
        }
      }
    },
    "bereavementAllowance": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "benefitId",
        "startDate",
        "amount"
      ],
      "properties": {
        "dateIgnored": {
          "$ref": "#/definitions/dateIgnored"
        },
        "submittedOn": {
          "$ref": "#/definitions/submittedOn"
        },
        "benefitId": {
          "$ref": "#/definitions/benefitId"
        },
        "startDate": {
          "$ref": "#/definitions/startDate"
        },
        "endDate": {
          "$ref": "#/definitions/endDate"
        },
        "amount": {
          "$ref": "#/definitions/moneyPositive"
        },
        "taxPaid": {
          "$ref": "#/definitions/moneyZeroToPositive"
        }
      }
    },
    "otherStateBenefits": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "benefitId",
        "startDate",
        "amount",
        "taxPaid"
      ],
      "properties": {
        "dateIgnored": {
          "$ref": "#/definitions/dateIgnored"
        },
        "submittedOn": {
          "$ref": "#/definitions/submittedOn"
        },
        "benefitId": {
          "$ref": "#/definitions/benefitId"
        },
        "startDate": {
          "$ref": "#/definitions/startDate"
        },
        "endDate": {
          "$ref": "#/definitions/endDate"
        },
        "amount": {
          "$ref": "#/definitions/moneyPositive"
        },
        "taxPaid": {
          "$ref": "#/definitions/moneyZeroToPositive"
        }
      }
    },
    "stateBenefits": {
      "type": "object",
      "additionalProperties": false,
      "minItems": 1,
      "properties": {
        "incapacityBenefit":  {
          "$ref": "#/definitions/incapacityBenefit"
        },
        "statePension":  {
          "$ref": "#/definitions/statePension"
        },
        "statePensionLumpSum":  {
          "$ref": "#/definitions/statePensionLumpSum"
        },
        "employmentSupportAllowance":  {
          "$ref": "#/definitions/employmentSupportAllowance"
        },
        "jobSeekersAllowance":  {
          "$ref": "#/definitions/jobSeekersAllowance"
        },
        "bereavementAllowance":  {
          "$ref": "#/definitions/bereavementAllowance"
        },
        "otherStateBenefits":  {
          "$ref": "#/definitions/bereavementAllowance"
        }
      }
    },
    "customerAddedStateBenefits": {
      "type": "object",
      "additionalProperties": false,
      "minItems": 1,
      "properties": {
        "incapacityBenefit":  {
          "$ref": "#/definitions/incapacityBenefit"
        },
        "statePension":  {
          "$ref": "#/definitions/statePension"
        },
        "statePensionLumpSum":  {
          "$ref": "#/definitions/statePensionLumpSum"
        },
        "employmentSupportAllowance":  {
          "$ref": "#/definitions/employmentSupportAllowance"
        },
        "jobSeekersAllowance":  {
          "$ref": "#/definitions/jobSeekersAllowance"
        },
        "bereavementAllowance":  {
          "$ref": "#/definitions/bereavementAllowance"
        },
        "otherStateBenefits":  {
          "$ref": "#/definitions/bereavementAllowance"
        }
      }
    }
  }
}
```



#### 8.1.9 Response Examples

##### 8.1.9.1 Full State Benefits

```json
{
  "stateBenefits": {
    "incapacityBenefit": {
        "dateIgnored": "2019-04-04T01:01:01Z",
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "amount": 2000.00,
        "taxPaid": 2132.22
     },
    "statePension": {
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2019-01-01",
      "amount": 2000.00
    },
    "statePensionLumpSum": { 
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2019-01-01",
     	"endDate"  : "2019-01-01",
        "amount": 2000.00,
        "taxPaid": 2132.22
    },
    "employmentSupportAllowance": [
      {
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "amount": 2000.00,
        "taxPaid": 2132.22        
      }
    ],
    "jobSeekersAllowance": [
      {
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "amount": 2000.00,
        "taxPaid": 2132.22        
      }
    ],
    "bereavementAllowance": {
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "amount": 2000.00
    },
    "otherStateBenefits": {
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "amount": 2000.00
    }
  },
  "customerAddedStateBenefits": {
    "incapacityBenefit": [
      {
        "submittedOn": "2019-04-04T01:01:01Z",
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "amount": 2000.00,
        "taxPaid": 2132.22        
      }
    ],
    "statePension": {
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2019-01-01",
      "amount": 2000.00      
    },
    "statePensionLumpSum": { 
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2019-01-01",
      "endDate" : "2019-01-01",
        "amount": 2000.00,
        "taxPaid": 2132.22       
    },
    "employmentSupportAllowance": [
      {
        "submittedOn": "2019-04-04T01:01:01Z",
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "amount": 2000.00,
        "taxPaid": 2132.22  
      }
    ],
    "jobSeekersAllowance": [
      {
        "submittedOn": "2019-04-04T01:01:01Z",
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "amount": 2000.00,
        "taxPaid": 2132.22  
      }
    ],
    "bereavementAllowance": {
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "amount": 2000.00      
    },
    "otherStateBenefits": {
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
        "amount": 2000.00      
    }
  }
}
```

##### 8.1.9.2 Minimal Response Example

```json
{
    "otherStatutoryBenefits": { 
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate" : "2020-01-01",
        "endDate" : "2020-04-01"
    }    
}
```

##### 8.1.9.3 Response With History

```json
{
  "stateBenefits": {
    "incapacityBenefit": [
      {
        "dateIgnored": "2019-04-04T01:01:01Z",
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "history": [ 
          {
            "action" : "ignored",
            "submittedOn" : "2019-04-04T01:01:01Z"
          }
        ]
      }
    ],
    "statePension": {
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2019-01-01",
      "history": []
    },
    "employmentSupportAllowance": [
      {
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "history": []
      }
    ],
    "jobSeekersAllowance": [
      {
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "history": []
      }
    ],
    "bereavementAllowance": {
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    },
    "widowedParentsAllowance": {
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    },
    "industrialDeathBenefit": {
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    },
    "carersAllowance": {
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    },
    "otherStatutoryBenefits": {
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    }
  },
  "customerAddedStateBenefits": {
    "incapacityBenefit": [
      {
        "submittedOn": "2019-04-04T01:01:01Z",
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "history": [
          {
            "submittedOn": "2019-04-04T01:01:01Z",
            "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
            "startDate": "2020-01-01",
            "endDate": "2020-04-01"
          }
        ]
      }
    ],
    "statePension": {
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2019-01-01",
      "history": []
    },
    "employmentSupportAllowance": [
      {
        "submittedOn": "2019-04-04T01:01:01Z",
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "history": []
      }
    ],
    "jobSeekersAllowance": [
      {
        "submittedOn": "2019-04-04T01:01:01Z",
        "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
        "startDate": "2020-01-01",
        "endDate": "2020-04-01",
        "history": []
      }
    ],
    "bereavementAllowance": {
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    },
    "widowedParentsAllowance": {
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    },
    "industrialDeathBenefit": {
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    },
    "carersAllowance": {
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    },
    "otherStatutoryBenefits": {
      "submittedOn": "2019-04-04T01:01:01Z",
      "benefitId": "f0d83ac0-a10a-4d57-9e41-6d033832779f",
      "startDate": "2020-01-01",
      "endDate": "2020-04-01",
      "history": []
    }
  }
}
```



#### 8.1.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 8.1.11 ITSD Components Impacted

- ISS
- IBD Store
- View Service

### 8.2 Add State Benefit

This operation allows a customer to add any state benefits they believe are missing

#### 8.2.1 URI

**POST** */income/state-benefits/{taxableEntityId}/{taxYear}/custom*

#### 8.1.2 Path Parameters

| Parameter       | Description                               | Example  |
| --------------- | ----------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer         | AB123456 |
| taxYear         | The tax year to which the benefit applies | 2019-20  |

#### 8.2.3 Query Parameters

N/A

#### 8.2.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 8.2.5 Request Schema

N/A

#### 8.2.6 Request Examples

##### 8.2.6.1 Minimum Request Payload

```json
{
    "benefitType": "JOB SEEKERS ALLOWANCE",
    "startDate" : "2020-01-01"
}
```

##### 8.2.6.2 Full Request Payload

```json
{
    "benefitType": "JOB SEEKERS ALLOWANCE",
    "startDate" : "2020-01-01",
    "endDate" : "2020-01-01"
}
```

#### 8.2.7 Response Status Code

| Response Code | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| 201           | Success the benefit has been created.                        |
| 400           | Invalid Request - the request body or parameters are invalid |
| 401           | The request cannot be authorised                             |
| 422           | Invalid Request - validation / BVR failure                   |
| 502           | Internal Error                                               |

#### 8.2.8 Response Schema

N/A

#### 8.2.9 Response Examples

N/A

#### 8.2.10 Response Headers

| Header        | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| CorrelationId | Unique transaction Id                                        |
| Location      | Location Header containing the unique id of the state benefit |

#### 8.2.11 ITSD Components Impacted

- ISS

### 8.3 Update Custom State Benefit

A customer may update a previously created customer employment, if the customer attempts to update a pre-populated employment then this operation will fail with a forbidden response code. 

This operation will replace the previously created resource completely. 

#### 8.3.1 URI

**PUT** */income/state-benefits/{taxableEntityId}/{taxYear}/custom/{benefitId}*

#### 8.3.2 Path Parameters

| Parameter       | Description                               | Example                              |
| --------------- | ----------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer         | AB123456                             |
| taxYear         | The tax year to which the benefit applies | 2019-20                              |
| benefitId       | Unique identifier of the benefit          | 123e4567-e89b-12d3-a456-426614174000 |

#### 8.3.3 Query Parameters

N/A

#### 8.3.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 8.3.5 Request Schema

```json

```

#### 8.3.6 Request Examples

##### 8.3.6.1 Full Request

```json
{ 
    "startDate"   : "2020-01-01",
    "endDate"     : "2020-03-01"
}
```

##### 8.3.6.1 Minimum Request

```json
{ 
    "startDate"   : "2020-01-01",
}
```

#### 8.3.7 Response Status Codes

| Response Code | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| 201           | Success the benefit has been updated                         |
| 400           | Invalid Request - the request body or parameters are invalid |
| 401           | The request cannot be authorised                             |
| 403           | Forbidden - this response is returned if the benefit id supplied does not relate to a customer added benefit. |
| 404           | If the benefit does not exist.                               |
| 422           | Invalid Request - validation / BVR failure                   |
| 502           | Internal Error                                               |

#### 8.3.8 Response Schema

N/A

#### 8.3.9 Response Examples

N/A

#### 8.3.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 8.3.11 ITSD Components Impacted

- ISS

### 8.4 Delete Custom Benefit

A customer can (logically) delete a previously added benefit if they so choose, this will also (logically) delete any financial information related to the benefit

If the customer attempts to delete a pre-populated benefit then the operation will fail with a forbidden response. 

#### 8.4.1 URI

**DELETE** */income/state-benefits/{taxableEntityId}/{taxYear}/custom/{benefitId}*

#### 8.4.2 Path Parameters

| Parameter       | Description                                  | Example                              |
| --------------- | -------------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer            | AB123456                             |
| taxYear         | The tax year to which the employment applies | 2019-20                              |
| benefitId       | Unique identifier of the benefit             | 123e4567-e89b-12d3-a456-426614174000 |

#### 8.4.3 Query Parameters

N/A

#### 8.4.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 8.4.5 Request Schema

N/A

#### 8.4.6 Request Examples

N/A

#### 8.4.7 Response Status Codes

| Response Code | Description                                                  |
| :------------ | :----------------------------------------------------------- |
| 204           | Success                                                      |
| 400           | Parameter error                                              |
| 401           | Unauthorised                                                 |
| 403           | Forbidden - returned if the customer tries to delete a pre-populated benefit |
| 404           | No data found                                                |
| 502           | Glitch in the matrix                                         |

#### 8.4.8 Response Schema

N/A

#### 8.4.9 Response Examples

N/A

#### 8.4.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 8.4.11 ITSD Components Impacted

- ISS

 customer can opt to ignore an employment, this should be consider as an instruction to the the calculator

### 8.5 Ignore State Benefit Toggle

#### 8.5.1 URI

**PUT** */income/state-benefits/{taxableEntityId}/{taxYear}/{benefitId}/ignore*

#### 8.5.2 Path Parameters

| Parameter       | Description                               | Example  |
| --------------- | ----------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer         | AB123456 |
| taxYear         | The tax year to which the benefit applies | 2019-20  |
| benefitId       | Unique id of the benefit.                 |          |

#### 8.5.3 Query Parameters

N/A

#### 8.5.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 8.5.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/ignore_benefit_schema.json",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Ignore Benefit",
  "description": "This schema allows a customer to mark an benefit as ignored.",
  "type": "object",
  "additionalProperties": false,
  "required": ["ignoreBenefit"],
  "properties":{
    "ignoreBenefit":{
      "type","boolean"
    }
  }
}
```



#### 8.5.6 Request Examples

##### 8.5.6.1 Mark Benefit Ignored

```json
{
  "ignoreBenefit": true
}
```

##### 8.5.6.2 Mark Benefit not ignored

```json
{
  "ignoreBenefit": false
}
```



#### 8.5.7 Response Status Codes

| Response Code | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| 201           | Success the benefit has been updated.                        |
| 400           | Invalid Request - the request body or parameters are invalid |
| 401           | The request cannot be authorised                             |
| 403           | Forbidden - this response is returned if the benefit id supplied does not relate to a customer added benefit. |
| 422           | Invalid Request - validation / BVR failure                   |
| 502           | Internal Error                                               |

#### 8.5.8 Response Schema

N/A

#### 8.5.9 Response Examples

N/A

#### 8.5.10 Response Headers

| Header        | Description                                              |
| ------------- | -------------------------------------------------------- |
| CorrelationId | Unique transaction reference (supplied with the request) |

#### 8.5.11 ITSD Impact Components

* ISS

---

### 8.6 Get State Benefit Details // REMOVE THIS IS NOW PART OF THE GET BENEFITS API

#### 8.6.1 URI

**GET** */income/state-benefits/{taxableEntityId}/{taxYear}*/*{stateBenefitId}*

#### 8.6.2 Path Parameters

| Parameter       | Description                                  | Example                              |
| --------------- | -------------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer            | AB123456                             |
| taxYear         | The tax year to which the employment applies | 2019-20                              |
| stateBenefitId  | Unique identifier of the state benefit       | 960b4a0f-05f2-4b6f-9b87-c3e001a84472 |

#### 8.6.3 Query Parameters

3 views hmrc held, customer, latest

#### 8.6.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 8.6.5 Request Schema

N/A

#### 8.6.6 Request Examples

N/A

#### 8.6.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 200           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 8.6.8 Response Schema

N/A

#### 8.6.9 Response Example

##### 8.6.9.1 Customer View

```json
{
    "submittedOn" : "2020-03-03T01:01:01Z",
  	"benefitType": "JOB SEEKERS ALLOWANCE",
		"amount": 2200.00
}
```

##### 8.6.9.2 HMRC Held View

```json
{
    "submittedOn" : "2020-03-03T01:01:01Z",
  	"benefitType": "JOB SEEKERS ALLOWANCE",  
		"amount": 2200.00
}
```

##### 8.6.9.3 Latest View

```json
{
    "submittedOn" : "2020-03-03T01:01:01Z",
    "benefitType": "JOB SEEKERS ALLOWANCE",
    "amount": 2200.00
}
```

##### 8.6.9.4 Ignored Allowance

```json
{
    "submittedOn" : "2020-03-03T01:01:01Z",
    "dateIgnored" : "2020-03-03T01:01:01Z",
    "jobSeekersAllowance": { 
        "amount": 2200.00
    }    
}
```

#### 8.6.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 8.6.11 ITSD Components Impacted

- View Service
- IBD Store

### 8.7 Override State Benefits

#### 8.7.1 URI

**PUT** */income/state-benefits/{taxableEntityId}/{taxYear}/{stateBenefitId}*

#### 8.7.2 Path Parameters

| Parameter       | Description                                     | Example                              |
| --------------- | ----------------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer               | AB123456                             |
| taxYear         | The tax year to which the state benefit applies | 2019-20                              |
| stateBenefitId  | Unique identifier of the state benefit          | 960b4a0f-05f2-4b6f-9b87-c3e001a84472 |

#### 8.7.3 Query Parameters

N/A

#### 8.7.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 8.7.5 Request Schema

N/A

#### 8.7.6 Request Examples



Need to capture a bvr that enforces tax paid depending upon the type of benefit (e.g. state pension ls). 

```json
{
  "amount": 200.00,
  "taxPaid": 200.00 //optional 
} 
```



#### 8.7.7 Response Status Code

| Response Code | Description            |
| :------------ | :--------------------- |
| 204           | Success                |
| 400           | Parameter error        |
| 401           | Unauthorised           |
| 422           | validation / bvr error |
| 404           | No data found          |
| 502           | Glitch in the matrix   |

#### 8.7.8 Response Schema

N/A

#### 8.7.9 Response Examples

N/A

#### 8.7.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 8.7.11 ITSD Components Impacted

- IBD Store

### 8.8 Delete State Benefit financial 

#### 8.8.1 URI

**DELETE** */income/state-benefits/{taxableEntityId}/{taxYear}/{stateBenefitId}*

#### 8.8.2 Path Parameters

| Parameter       | Description                               | Example                              |
| --------------- | ----------------------------------------- | ------------------------------------ |
| taxableEntityId | Unique identifier of the customer         | AB123456                             |
| taxYear         | The tax year to which the benefit applies | 2019-20                              |
| stateBenefitId  | Unique identifier of the state benefit    | 960b4a0f-05f2-4b6f-9b87-c3e001a84472 |

#### 8.8.3 Query Parameters

N/A

#### 8.8.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 8.8.5 Request Schema

N/A

#### 8.8.6 Request Examples

N/A

#### 8.8.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 204           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 8.8.8 Response Schema

N/A

#### 8.8.9 Response Examples

N/A

#### 8.8.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 8.8.11 ITSD Components Impacted

- IBD Store
---

#### WiP

```json
{
  "submittedOn": "timestamp",
  
  "statePension": { //Optional
      "annualAmount": 123.00, //Mandatory
    
  },
  "statePensionLumpSum":{  //behaves like an employment only 1 allowed ever
      "empRef": "123/av123421C", //not editable
    	"startDate": "date", //??
    	"endDate" : "date", //??
      "lumpSumAmount": 123.00, //Optional
      "lumpSumTaxPaid": 123.00 //Optional //Check if mandatory when lump sum amount is present. 
  },
  "incapacityBenefit": {  //Is this still required ? 
    "id":"231232",
      "amountYTD": 123.00, 
      "taxPaid": 123.00
  },
  
   "incapacityBenefit": {  //Is this still required ? 
     "id": "12321231231",
      "amountYTD": 153.00, 
      "taxPaid": 123.00
  }, 
   "employmentSupportAllowance": {  //Move to the employments model - need to consider how this is "viewed"
     																//has an emp ref, will need to be in ISS as an employment and follow the rest of the employment pattern, including ignoring the esa. 
     	 "empRef": "123/av123421C", //not editable
     	 "startDate": "date",       //not editable
     	"endDate": "date", //optional //not editable
        "amount": 123.00 
  },
   "jobseekersAllowance": { //Same as ESA 
     	 "empRef": "123/av123421C", //not editable
     	 "startDate": "date",       //not editable
     	  "endDate": "date", //optional //not editable
        "amount": 123.00      

  },
    "bereavementAllowance": { //Prepop
        "amount":  123.00
  },
    "widowedParentsAllowance": { //Prepop
      "amount":  123.00
  },
    "industrialDeathBenefit": { //Prepop
      "amount":  123.00
  },
    "carersAllowance": { //Prepop
      "amount":  123.00
  },
    "otherStatutoryBenefits": { //Prepop
      "amount": 123.00 //dwp
  }          
}
```

---



HMRC HELD is always used when present ? 



Where data is pre-populated it cannot be overriden until the tax year has ended, 

Where data is not pre-populated you can provide a figure however this will be dropped in preference to the DWP figure and you will have to override again at the end of the tax year. 



## 9. Other Employment Income

Other employment income relates to income supplied by a customer relating to to their employment which cannot be pre-populated by HMRC.

### 9.1 Create Other Employment Income

#### 9.1.1 URI

**PUT** */income/other/employment/{taxableEntityId}/{taxYear}*

#### 9.1.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 9.1.3 Query Parameters

N/A

#### 9.1.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 9.1.5 Request Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/PUT_other_employment_income.json",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "PUT other employment income",
  "description": "This structure describes other employment income that can be submitted by the customer.",
  "type": "object",
  "additionalProperties": false,
  "minProperties" : 1,   
  "properties": {
    "shareOption": {
      "#ref": "#/definitions/shareOptions"
  	},
    "sharesAwardedOrReceived":{
		"#ref": "#/definitions/sharesAwardedOrReceived"      
    },
    "disability":{
      "#ref": "#/definitions/disability"
    },
    "foreignService":{ 
      "#ref": "/definitions/foreignService"
    },
    "lumpSums":{
      "$ref": "#/definitions/lumpSums"
    }
  },
  "definitions": {
    "moneyPositive": {
      "$id": "#moneyPositive",
      "type": "number",
      "minimum": 0.00,
      "maximum": 99999999999.99,
      "multipleOf": 0.01
    },
    "employerRef": {
      "type": "string",
      "pattern": "^([0-9]{3})/([^ ].{0,10})$"
    },
    "employerName": {
      "type": "string",
      "pattern": "^.{0,74}$"
    },
    "classOfShare": {
      "type": "string",
      "enum": [
        "FIRST"
      ]
    },
    "shareOptions": {
      "type": "array",
      "additionalItems": false,
      "minItems": 1,
      "items": {
        "$ref": "#/definitions/shareOption"
      }
    },
    "shareOption": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "employerName"
      ],
      "properties": {
        "employerName": {
          "$ref": "#/definitions/employerName"
        },
        "employerRef": {
          "$ref": "#/definitions/employerRef"
        },
        "dateOfOptionGrant": {
          "type": "string",
          "format": "date"
        },
        "dateOfEvent": {
          "type": "string",
          "format": "date"
        },
        "optionNotExercisedButConsiderationReceived": {
          "type": "string"
        },
        "amountOfConsiderationReceived": {
          "$ref": "#/definitions/moneyPositive"
        },
        "noOfSharesAcquired": {
          "type": "number",
          "minimum": 1
        },
        "classOfSharesAcquired": {
          "$ref": "#/definitions/classOfShare"
        },
        "exercisePrice": {
          "$ref": "#/definitions/moneyPositive"
        },
        "amountPaidForOption": {
          "$ref": "#/definitions/moneyPositive"
        },
        "marketValueOfSharesOnExcise": {
          "$ref": "#/definitions/moneyPositive"
        },
        "profitOnOptionExercised": {
          "$ref": "#/definitions/moneyPositive"
        },
        "employersNicPaid": {
          "$ref": "#/definitions/moneyPositive"
        },
        "taxableAmount": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "sharesAwardedOrReceived:": {
      "type": "array",
      "additionalItems": false,
      "minItems": 1,
      "items": {
        "$ref": "#/definitions/shareAwardedOrReceived"
      }
    },
    "shareAwardedOrReceived": {
      "type": "object",
      "additionalProperties": false,
      "minProperties": 1,
      "required": [
        "employerName"
      ],
      "properties": {},
      "employerName": {
        "$ref": "#/definitions/employerName"
      },
      "employerRef": {
        "$ref": "#/definitions/employerRef"
      },
      "schemePlanType": {
        "type": "string"
      },
      "dateSharesCeasedToBeSubjectToPlan": {
        "type": "string",
        "format": "date"
      },
      "noOfShareSecuritiesAwarded": {
        "type": "number",
        "minimum": 1
      },
      "classOfShareAwarded": {
        "$ref": "#/definitions/classOfShare"
      },
      "dateSharesAwarded": {
        "type": "string",
        "format": "date"
      },
      "sharesSubjectToRestrictions": {
        "type": "boolean"
      },
      "electionEnteredIgnoreRestrictions": {
        "type": "boolean"
      },
      "actualMarketValueOfSharesOnAward": {
        "$ref": "#/definitions/moneyPositive"
      },
      "unrestrictedMarketValueOfSharesOnAward": {
        "$ref": "#/definitions/moneyPositive"
      },
      "amountPaidForSharesOnAward": {
        "$ref": "#/definitions/moneyPositive"
      },
      "marketValueAfterRestrictionsLifted": {
        "$ref": "#/definitions/moneyPositive"
      },
      "taxableAmount": {
        "$ref": "#/definitions/moneyPositive"
      }
    },
    "disability": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "customerReference": {
          "type": "string"
        },
        "amountDeducted": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "foreignService": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "customerReference": {
          "type": "string"
        },
        "amountDeducted": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "lumpSums" : { 
      "type": "array",
      "additionalItems": false,
      "minItems": 1,
      "items": {
        "$ref": "#/definitions/lumpSum"
      }      
    },
    "lumpSum": {
      "type": "object",
      "additionalProperties": false,
      "minProperties": 3,
      "required":[ "employerName", "employerRef"],
      "properties": {
        "employerName": {
          "$ref": "#/definitions/employerName"
        },
        "employerRef": {
          "$ref": "#/definitions/employerRef"
        },
        "taxableLumpSumsAndCertainIncome": {
          "type": "object",
          "properties": {
            "amount": {
              "$ref": "#moneyPositive"
            },
            "taxPaid": {
              "$ref": "#moneyPositive"
            },
            "taxTakenOffInEmployment": {
              "type": "boolean"
            }
          },
          "additionalProperties": false,
          "minProperties": 1,
          "required": []
        },
        "benefitFromEmployerFinancedRetirementScheme": {
          "type": "object",
          "properties": {
            "amount": {
              "$ref": "#moneyPositive"
            },
            "exemptAmount": {
              "$ref": "#moneyPositive"
            },
            "taxPaid": {
              "$ref": "#moneyPositive"
            },
            "taxTakenOffInEmployment": {
              "type": "boolean"
            }
          },
          "additionalProperties": false,
          "minProperties": 1
        },
        "redundancyCompensationPaymentsOverExemption": {
          "type": "object",
          "properties": {
            "amount": {
              "$ref": "#moneyPositive"
            },
            "taxPaid": {
              "$ref": "#moneyPositive"
            },
            "taxTakenOffInEmployment": {
              "type": "boolean"
            }
          },
          "additionalProperties": false,
          "minProperties": 1
        },
        "redundancyCompensationPaymentsUnderExemption": {
          "type": "object",
          "properties": {
            "amount": {
              "$ref": "#moneyPositive"
            }
          },
          "additionalProperties": false,
          "minProperties": 1
        }
      }
    }
  },
  "examples": [
    {
      "shareOption": [
        {
          "employerName": "wibble",
          "empRef": "AB1321/123",
          "schemePlanType": "Wibble",
          "dateOfOptionGrant": "20-11-2019",
          "dateOfEvent": "20-11-2019",
          "optionNotExercisedButConsiderationReceived": "??",
          "amountOfConsiderationReceived": 23122.22,
          "noOfSharesAcquired": 1,
          "classOfSharesAcquired": "FIRST",
          "exercisePrice": 12.22,
          "amountPaidForOption": 123.22,
          "marketValueOfSharesOnExcise": 1232.22,
          "profitOnOptionExercised": 1232.33,
          "employersNicPaid": 2312.22,
          "taxableAmount": 2132.22
        }
      ],
      "sharesAwardedOrReceived": [
        {
          "employerName": "Wibble",
          "empRef": "AB1321/123",
          "schemePlanType": "Wibble",
          "dateSharesCeasedToBeSubjectToPlan": "10-11-2019",
          "noOfShareSecuritiesAwarded": 11,
          "classOfShareAwarded": "FIRST",
          "dateSharesAwarded": "20-11-2019",
          "sharesSubjectToRestrictions": true,
          "electionEnteredIgnoreRestrictions": true,
          "actualMarketValueOfSharesOnAward": 2123.22,
          "unrestrictedMarketValueOfSharesOnAward": 123.22,
          "amountPaidForSharesOnAward": 123.22,
          "marketValueAfterRestrictionsLifted": 1232.22,
          "taxableAmount": 12321.22
        }
      ],
      "disability": {
        "customerReference": "wibble",
        "amountDeducted": 1223.22
      },
      "foreignService": {
        "customerReference": "wibble",
        "amountDeducted": 1223.22
      },
      "lumpSums": [
        {
          "employerName": "WibbleInc",
          "employerRef": "123/AB12312",
          "taxableLumpSumsAndCertainIncome": {
            "amount": 123.00,
            "taxPaid": 123.00,
            "taxTakenOffInEmployment": true
          },
          "benefitFromEmployerFinancedRetirementScheme": {
            "amount": 123.00,
            "exemptAmount": 123.00,
            "taxPaid": 123.00,
            "taxTakenOffInEmployment": true
          },
          "redundancyCompensationPaymentsOverExemption": {
            "amount": 123.00,
            "taxPaid": 123.00,
            "taxTakenOffInEmployment": true
          },
          "redundancyCompensationPaymentsUnderExemption": {
            "amount": 123.00
          }
        }
    	]
    }
  ]
}
```



#### 9.1.6 Request Examples

##### 9.1.6.1 All Data Items

```json
{
  "shareOption": [
    {
      "employerName": "wibble",
      "empRef": "AB1321/123",
      "schemePlanType": "Wibble",
      "dateOfOptionGrant": "20-11-2019",
      "dateOfEvent": "20-11-2019",
      "optionNotExercisedButConsiderationReceived": "??",
      "amountOfConsiderationReceived": 23122.22,
      "noOfSharesAcquired": 1,
      "classOfSharesAcquired": "FIRST",
      "exercisePrice": 12.22,
      "amountPaidForOption": 123.22,
      "marketValueOfSharesOnExcise": 1232.22,
      "profitOnOptionExercised": 1232.33,
      "employersNicPaid": 2312.22,
      "taxableAmount": 2132.22
    }
  ],
  "sharesAwardedOrReceived": [
    {
      "employerName": "Wibble",
      "empRef": "AB1321/123",
      "schemePlanType": "Wibble",
      "dateSharesCeasedToBeSubjectToPlan": "10-11-2019",
      "noOfShareSecuritiesAwarded": 11,
      "classOfShareAwarded": "FIRST",
      "dateSharesAwarded": "20-11-2019",
      "sharesSubjectToRestrictions": true,
      "electionEnteredIgnoreRestrictions": true,
      "actualMarketValueOfSharesOnAward": 2123.22,
      "unrestrictedMarketValueOfSharesOnAward": 123.22,
      "amountPaidForSharesOnAward": 123.22,
      "marketValueAfterRestrictionsLifted": 1232.22,
      "taxableAmount": 12321.22
    }
  ],
  "disability": {
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  },
  "foreignService": {
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  },
  "lumpSums": [
    {
      "employerName": "WibbleInc",
      "employerRef": "123/AB12312",
      "taxableLumpSumsAndCertainIncome": {
        "amount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "benefitFromEmployerFinancedRetirementScheme": {
        "amount": 123.00,
        "exemptAmount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "redundancyCompensationPaymentsOverExemption": {
        "amount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "redundancyCompensationPaymentsUnderExemption": {
        "amount": 123.00
      }
    }
  ]
}
```

##### 9.1.6.2 Minimum Data Items

```json
{
  "shareOption": [
    {
      "employerName": "wibble",
      "empRef": "AB1321/123",
      "schemePlanType": "Wibble",
      "dateOfOptionGrant": "20-11-2019",
      "dateOfEvent": "20-11-2019",
      "optionNotExercisedButConsiderationReceived": "??",
      "amountOfConsiderationReceived": 23122.22,
      "noOfSharesAcquired": 1,
      "classOfSharesAcquired": "FIRST",
      "exercisePrice": 12.22,
      "amountPaidForOption": 123.22,
      "marketValueOfSharesOnExcise": 1232.22,
      "profitOnOptionExercised": 1232.33,
      "employersNicPaid": 2312.22,
      "taxableAmount": 2132.22
    }
  ]
}
```

#### 9.1.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 204           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 9.1.8 Response Schema

N/A

#### 9.1.9 Response Examples

N/A

#### 9.1.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 9.1.11 ITSD Components Impacted

- IBD Store

### 9.2 Retrieve Other Employment Income

#### 9.2.1 URI

**GET** */income/other/employment/{taxableEntityId}/{taxYear}*

#### 9.2.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 9.2.3 Query Parameters

| Parameter | Description                                                  | Optionality | Type    | Example / Values | Default Value |
| --------- | ------------------------------------------------------------ | ----------- | ------- | ---------------- | ------------- |
| internal  | Query parameter specifying that view should include historic data | Optional    | Boolean | true/false       | False         |

#### 9.2.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 9.2.5 Request Schema

N/A

#### 9.2.6 Request Examples

N/A

#### 9.2.7 Response Status Code

| Response Code | Description          |
| :------------ | :------------------- |
| 200           | Success              |
| 400           | Parameter error      |
| 401           | Unauthorised         |
| 404           | No data found        |
| 502           | Glitch in the matrix |

#### 9.2.8 Response Schema

```json
{
  "$id": "https://www.gov.uk/government/organisations/hm-revenue-customs/schema/itsa/GET_other_employment_income.json",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "GET other employment income",
  "description": "This structure describes other employment income that can be retrieved including history.",
  "type": "object",
  "oneOf": [],
  "definitions": {
    "submission": {
      "type": "object",
      "additionalProperties": false,
      "minProperties": 2,
      "required": [
        "submittedOn"
      ],
      "properties": {
        "submittedOn": {
          "type": "string",
          "format": "date-time"
        },
        "deletedOn": {
          "type": "string",
          "format": "date-time"
        },
        "shareOption": {
          "#ref": "#/definitions/shareOptions"
        },
        "sharesAwardedOrReceived": {
          "#ref": "#/definitions/sharesAwardedOrReceived"
        },
        "disability": {
          "#ref": "#/definitions/disability"
        },
        "foreignService": {
          "#ref": "/definitions/foreignService"
        },
        "lumpSums": {
          "$ref": "#/definitions/lumpSums"
        }
      }
    },
    "submissionWithHistory": {
      "type": "object",
      "additionalProperties": false,
      "minProperties": 2,
      "required": [
        "history"
      ],
      "properties": {
        "submittedOn": {
          "type": "string",
          "format": "date-time"
        },
        "deletedOn": {
          "type": "string",
          "format": "date-time"
        },
        "shareOption": {
          "#ref": "#/definitions/shareOptions"
        },
        "sharesAwardedOrReceived": {
          "#ref": "#/definitions/sharesAwardedOrReceived"
        },
        "disability": {
          "#ref": "#/definitions/disability"
        },
        "foreignService": {
          "#ref": "/definitions/foreignService"
        },
        "lumpSums": {
          "$ref": "#/definitions/lumpSums"
        },
        "history": {
          "type": "array",
          "additionalItems": false,
          "items": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
              "submittedOn": {
                "type": "string",
                "format": "date-time"
              },
              "deletedOn": {
                "type": "string",
                "format": "date-time"
              },
              "shareOption": {
                "#ref": "#/definitions/shareOptions"
              },
              "sharesAwardedOrReceived": {
                "#ref": "#/definitions/sharesAwardedOrReceived"
              },
              "disability": {
                "#ref": "#/definitions/disability"
              },
              "foreignService": {
                "#ref": "/definitions/foreignService"
              },
              "lumpSums": {
                "$ref": "#/definitions/lumpSums"
              },
            }
          }
        }
      }
    },
    "moneyPositive": {
      "$id": "#moneyPositive",
      "type": "number",
      "minimum": 0.00,
      "maximum": 99999999999.99,
      "multipleOf": 0.01
    },
    "employerRef": {
      "type": "string",
      "pattern": "^([0-9]{3})/([^ ].{0,10})$"
    },
    "employerName": {
      "type": "string",
      "pattern": "^.{0,74}$"
    },
    "classOfShare": {
      "type": "string",
      "enum": [
        "FIRST"
      ]
    },
    "shareOptions": {
      "type": "array",
      "additionalItems": false,
      "minItems": 1,
      "items": {
        "$ref": "#/definitions/shareOption"
      }
    },
    "shareOption": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "employerName"
      ],
      "properties": {
        "employerName": {
          "$ref": "#/definitions/employerName"
        },
        "employerRef": {
          "$ref": "#/definitions/employerRef"
        },
        "dateOfOptionGrant": {
          "type": "string",
          "format": "date"
        },
        "dateOfEvent": {
          "type": "string",
          "format": "date"
        },
        "optionNotExercisedButConsiderationReceived": {
          "type": "string"
        },
        "amountOfConsiderationReceived": {
          "$ref": "#/definitions/moneyPositive"
        },
        "noOfSharesAcquired": {
          "type": "number",
          "minimum": 1
        },
        "classOfSharesAcquired": {
          "$ref": "#/definitions/classOfShare"
        },
        "exercisePrice": {
          "$ref": "#/definitions/moneyPositive"
        },
        "amountPaidForOption": {
          "$ref": "#/definitions/moneyPositive"
        },
        "marketValueOfSharesOnExcise": {
          "$ref": "#/definitions/moneyPositive"
        },
        "profitOnOptionExercised": {
          "$ref": "#/definitions/moneyPositive"
        },
        "employersNicPaid": {
          "$ref": "#/definitions/moneyPositive"
        },
        "taxableAmount": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "sharesAwardedOrReceived:": {
      "type": "array",
      "additionalItems": false,
      "minItems": 1,
      "items": {
        "$ref": "#/definitions/shareAwardedOrReceived"
      }
    },
    "shareAwardedOrReceived": {
      "type": "object",
      "additionalProperties": false,
      "minProperties": 1,
      "required": [
        "employerName"
      ],
      "properties": {},
      "employerName": {
        "$ref": "#/definitions/employerName"
      },
      "employerRef": {
        "$ref": "#/definitions/employerRef"
      },
      "schemePlanType": {
        "type": "string"
      },
      "dateSharesCeasedToBeSubjectToPlan": {
        "type": "string",
        "format": "date"
      },
      "noOfShareSecuritiesAwarded": {
        "type": "number",
        "minimum": 1
      },
      "classOfShareAwarded": {
        "$ref": "#/definitions/classOfShare"
      },
      "dateSharesAwarded": {
        "type": "string",
        "format": "date"
      },
      "sharesSubjectToRestrictions": {
        "type": "boolean"
      },
      "electionEnteredIgnoreRestrictions": {
        "type": "boolean"
      },
      "actualMarketValueOfSharesOnAward": {
        "$ref": "#/definitions/moneyPositive"
      },
      "unrestrictedMarketValueOfSharesOnAward": {
        "$ref": "#/definitions/moneyPositive"
      },
      "amountPaidForSharesOnAward": {
        "$ref": "#/definitions/moneyPositive"
      },
      "marketValueAfterRestrictionsLifted": {
        "$ref": "#/definitions/moneyPositive"
      },
      "taxableAmount": {
        "$ref": "#/definitions/moneyPositive"
      }
    },
    "disability": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "customerReference": {
          "type": "string"
        },
        "amountDeducted": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "foreignService": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "customerReference": {
          "type": "string"
        },
        "amountDeducted": {
          "$ref": "#/definitions/moneyPositive"
        }
      }
    },
    "lumpSums":{ 
      "type": "array",
      "additionalItems": false,
      "minItems": 1,
      "items": {
        "$ref": "#/definitions/lumpSum"
      }            
    },
    "lumpSum": {
      "type": "object",
      "additionalProperties": false,
      "minProperties": 1,
      "properties": {
        "employerName": {
          "$ref": "#/definitions/employerName"
        },
        "employerRef": {
          "$ref": "#/definitions/employerRef"
        },
        "taxableLumpSumsAndCertainIncome": {
          "type": "object",
          "properties": {
            "amount": {
              "$ref": "#moneyPositive"
            },
            "taxPaid": {
              "$ref": "#moneyPositive"
            },
            "taxTakenOffInEmployment": {
              "type": "boolean"
            }
          },
          "additionalProperties": false,
          "minProperties": 1,
          "required": []
        },
        "benefitFromEmployerFinancedRetirementScheme": {
          "type": "object",
          "properties": {
            "amount": {
              "$ref": "#moneyPositive"
            },
            "exemptAmount": {
              "$ref": "#moneyPositive"
            },
            "taxPaid": {
              "$ref": "#moneyPositive"
            },
            "taxTakenOffInEmployment": {
              "type": "boolean"
            }
          },
          "additionalProperties": false,
          "minProperties": 1
        },
        "redundancyCompensationPaymentsOverExemption": {
          "type": "object",
          "properties": {
            "amount": {
              "$ref": "#moneyPositive"
            },
            "taxPaid": {
              "$ref": "#moneyPositive"
            },
            "taxTakenOffInEmployment": {
              "type": "boolean"
            }
          },
          "additionalProperties": false,
          "minProperties": 1
        },
        "redundancyCompensationPaymentsUnderExemption": {
          "type": "object",
          "properties": {
            "amount": {
              "$ref": "#moneyPositive"
            }
          },
          "additionalProperties": false,
          "minProperties": 1
        }
      }
    }
  },
  "examples": [
    {
      "submittedOn": "2020-03-03T01:01:01Z",
      "shareOption": [
        {
          "employerName": "wibble",
          "empRef": "AB1321/123",
          "schemePlanType": "Wibble",
          "dateOfOptionGrant": "20-11-2019",
          "dateOfEvent": "20-11-2019",
          "optionNotExercisedButConsiderationReceived": "??",
          "amountOfConsiderationReceived": 23122.22,
          "noOfSharesAcquired": 1,
          "classOfSharesAcquired": "FIRST",
          "exercisePrice": 12.22,
          "amountPaidForOption": 123.22,
          "marketValueOfSharesOnExcise": 1232.22,
          "profitOnOptionExercised": 1232.33,
          "employersNicPaid": 2312.22,
          "taxableAmount": 2132.22
        }
      ],
      "sharesAwardedOrReceived": [
        {
          "employerName": "Wibble",
          "empRef": "AB1321/123",
          "schemePlanType": "Wibble",
          "dateSharesCeasedToBeSubjectToPlan": "10-11-2019",
          "noOfShareSecuritiesAwarded": 11,
          "classOfShareAwarded": "FIRST",
          "dateSharesAwarded": "20-11-2019",
          "sharesSubjectToRestrictions": true,
          "electionEnteredIgnoreRestrictions": true,
          "actualMarketValueOfSharesOnAward": 2123.22,
          "unrestrictedMarketValueOfSharesOnAward": 123.22,
          "amountPaidForSharesOnAward": 123.22,
          "marketValueAfterRestrictionsLifted": 1232.22,
          "taxableAmount": 12321.22
        }
      ],
      "disability": {
        "customerReference": "wibble",
        "amountDeducted": 1223.22
      },
      "foreignService": {
        "customerReference": "wibble",
        "amountDeducted": 1223.22
      },
      "lumpSums": [
        {
          "employerName": "WibbleInc",
          "employerRef": "123/AB12312",
          "taxableLumpSumsAndCertainIncome": {
            "amount": 123.00,
            "taxPaid": 123.00,
            "taxTakenOffInEmployment": true
          },
          "benefitFromEmployerFinancedRetirementScheme": {
            "amount": 123.00,
            "exemptAmount": 123.00,
            "taxPaid": 123.00,
            "taxTakenOffInEmployment": true
          },
          "redundancyCompensationPaymentsOverExemption": {
            "amount": 123.00,
            "taxPaid": 123.00,
            "taxTakenOffInEmployment": true
          },
          "redundancyCompensationPaymentsUnderExemption": {
            "amount": 123.00
          }
        }
      ],
      "history":[]
    }
  ]
}
```



#### 9.2.9 Response Examples

##### 9.2.9.1 Response Without History

```json
{
  "submittedOn": "2020-03-03T01:01:01Z",
  "deletedOn": "2020-03-03T01:01:01Z",
  "shareOption": [
    {
      "employerName": "wibble",
      "empRef": "AB1321/123",
      "schemePlanType": "Wibble",
      "dateOfOptionGrant": "20-11-2019",
      "dateOfEvent": "20-11-2019",
      "optionNotExercisedButConsiderationReceived": "??",
      "amountOfConsiderationReceived": 23122.22,
      "noOfSharesAcquired": 1,
      "classOfSharesAcquired": "FIRST",
      "exercisePrice": 12.22,
      "amountPaidForOption": 123.22,
      "marketValueOfSharesOnExcise": 1232.22,
      "profitOnOptionExercised": 1232.33,
      "employersNicPaid": 2312.22,
      "taxableAmount": 2132.22
    }
  ],
  "sharesAwardedOrReceived": [
    {
      "employerName": "Wibble",
      "empRef": "AB1321/123",
      "schemePlanType": "Wibble",
      "dateSharesCeasedToBeSubjectToPlan": "10-11-2019",
      "noOfShareSecuritiesAwarded": 11,
      "classOfShareAwarded": "FIRST",
      "dateSharesAwarded": "20-11-2019",
      "sharesSubjectToRestrictions": true,
      "electionEnteredIgnoreRestrictions": true,
      "actualMarketValueOfSharesOnAward": 2123.22,
      "unrestrictedMarketValueOfSharesOnAward": 123.22,
      "amountPaidForSharesOnAward": 123.22,
      "marketValueAfterRestrictionsLifted": 1232.22,
      "taxableAmount": 12321.22
    }
  ],
  "disability": {
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  },
  "foreignService": {
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  },
  "lumpSums": [
    {
      "employerName": "WibbleInc",
      "employerRef": "123/AB12312",
      "taxableLumpSumsAndCertainIncome": {
        "amount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "benefitFromEmployerFinancedRetirementScheme": {
        "amount": 123.00,
        "exemptAmount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "redundancyCompensationPaymentsOverExemption": {
        "amount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "redundancyCompensationPaymentsUnderExemption": {
        "amount": 123.00
      }
    }
  ]
}
```

##### 9.2.9.2 Response With Empty History

```json
{
  "submittedOn": "2020-03-03T01:01:01Z",
  "shareOption": [
    {
      "employerName": "wibble",
      "empRef": "AB1321/123",
      "schemePlanType": "Wibble",
      "dateOfOptionGrant": "20-11-2019",
      "dateOfEvent": "20-11-2019",
      "optionNotExercisedButConsiderationReceived": "??",
      "amountOfConsiderationReceived": 23122.22,
      "noOfSharesAcquired": 1,
      "classOfSharesAcquired": "FIRST",
      "exercisePrice": 12.22,
      "amountPaidForOption": 123.22,
      "marketValueOfSharesOnExcise": 1232.22,
      "profitOnOptionExercised": 1232.33,
      "employersNicPaid": 2312.22,
      "taxableAmount": 2132.22
    }
  ],
  "sharesAwardedOrReceived": [
    {
      "employerName": "Wibble",
      "empRef": "AB1321/123",
      "schemePlanType": "Wibble",
      "dateSharesCeasedToBeSubjectToPlan": "10-11-2019",
      "noOfShareSecuritiesAwarded": 11,
      "classOfShareAwarded": "FIRST",
      "dateSharesAwarded": "20-11-2019",
      "sharesSubjectToRestrictions": true,
      "electionEnteredIgnoreRestrictions": true,
      "actualMarketValueOfSharesOnAward": 2123.22,
      "unrestrictedMarketValueOfSharesOnAward": 123.22,
      "amountPaidForSharesOnAward": 123.22,
      "marketValueAfterRestrictionsLifted": 1232.22,
      "taxableAmount": 12321.22
    }
  ],
  "disability": {
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  },
  "foreignService": {
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  },
  "lumpSums": [
    {
      "employerName": "WibbleInc",
      "employerRef": "123/AB12312",
      "taxableLumpSumsAndCertainIncome": {
        "amount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "benefitFromEmployerFinancedRetirementScheme": {
        "amount": 123.00,
        "exemptAmount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "redundancyCompensationPaymentsOverExemption": {
        "amount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "redundancyCompensationPaymentsUnderExemption": {
        "amount": 123.00
      }
    }
  ],
  "history": []
}
```

##### 9.2.9.3 Response With History

```json
{
  "submittedOn": "2020-03-03T01:01:01Z",
  "deletedOn": "2020-03-03T01:01:01Z",    
  "shareOption": [
    {
      "employerName": "wibble",
      "empRef": "AB1321/123",
      "schemePlanType": "Wibble",
      "dateOfOptionGrant": "20-11-2019",
      "dateOfEvent": "20-11-2019",
      "optionNotExercisedButConsiderationReceived": "??",
      "amountOfConsiderationReceived": 23122.22,
      "noOfSharesAcquired": 1,
      "classOfSharesAcquired": "FIRST",
      "exercisePrice": 12.22,
      "amountPaidForOption": 123.22,
      "marketValueOfSharesOnExcise": 1232.22,
      "profitOnOptionExercised": 1232.33,
      "employersNicPaid": 2312.22,
      "taxableAmount": 2132.22
    }
  ],
  "sharesAwardedOrReceived": [
    {
      "employerName": "Wibble",
      "empRef": "AB1321/123",
      "schemePlanType": "Wibble",
      "dateSharesCeasedToBeSubjectToPlan": "10-11-2019",
      "noOfShareSecuritiesAwarded": 11,
      "classOfShareAwarded": "FIRST",
      "dateSharesAwarded": "20-11-2019",
      "sharesSubjectToRestrictions": true,
      "electionEnteredIgnoreRestrictions": true,
      "actualMarketValueOfSharesOnAward": 2123.22,
      "unrestrictedMarketValueOfSharesOnAward": 123.22,
      "amountPaidForSharesOnAward": 123.22,
      "marketValueAfterRestrictionsLifted": 1232.22,
      "taxableAmount": 12321.22
    }
  ],
  "disability": {
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  },
  "foreignService": {
    "customerReference": "wibble",
    "amountDeducted": 1223.22
  },
  "lumpSums": [
    {
      "employerName": "WibbleInc",
      "employerRef": "123/AB12312",
      "taxableLumpSumsAndCertainIncome": {
        "amount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "benefitFromEmployerFinancedRetirementScheme": {
        "amount": 123.00,
        "exemptAmount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "redundancyCompensationPaymentsOverExemption": {
        "amount": 123.00,
        "taxPaid": 123.00,
        "taxTakenOffInEmployment": true
      },
      "redundancyCompensationPaymentsUnderExemption": {
        "amount": 123.00
      }
    }
  ],
  "history": [
    {
      "submittedOn": "2020-03-03T01:01:01Z",
      "deletedOn": "2020-03-03T01:01:01Z",        
      "shareOption": [
        {
          "employerName": "wibble",
          "empRef": "AB1321/123",
          "schemePlanType": "Wibble",
          "dateOfOptionGrant": "20-11-2019",
          "dateOfEvent": "20-11-2019",
          "optionNotExercisedButConsiderationReceived": "??",
          "amountOfConsiderationReceived": 23122.22,
          "noOfSharesAcquired": 1,
          "classOfSharesAcquired": "FIRST",
          "exercisePrice": 12.22,
          "amountPaidForOption": 123.22,
          "marketValueOfSharesOnExcise": 1232.22,
          "profitOnOptionExercised": 1232.33,
          "employersNicPaid": 2312.22,
          "taxableAmount": 2132.22
        }
      ],
      "sharesAwardedOrReceived": [
        {
          "employerName": "Wibble",
          "empRef": "AB1321/123",
          "schemePlanType": "Wibble",
          "dateSharesCeasedToBeSubjectToPlan": "10-11-2019",
          "noOfShareSecuritiesAwarded": 11,
          "classOfShareAwarded": "FIRST",
          "dateSharesAwarded": "20-11-2019",
          "sharesSubjectToRestrictions": true,
          "electionEnteredIgnoreRestrictions": true,
          "actualMarketValueOfSharesOnAward": 2123.22,
          "unrestrictedMarketValueOfSharesOnAward": 123.22,
          "amountPaidForSharesOnAward": 123.22,
          "marketValueAfterRestrictionsLifted": 1232.22,
          "taxableAmount": 12321.22
        }
      ],
      "disability": {
        "customerReference": "wibble",
        "amountDeducted": 1223.22
      },
      "foreignService": {
        "customerReference": "wibble",
        "amountDeducted": 1223.22
      },
      "lumpSums": [
        {
          "employerName": "WibbleInc",
          "employerRef": "123/AB12312",
          "taxableLumpSumsAndCertainIncome": {
            "amount": 123.00,
            "taxPaid": 123.00,
            "taxTakenOffInEmployment": true
          },
          "benefitFromEmployerFinancedRetirementScheme": {
            "amount": 123.00,
            "exemptAmount": 123.00,
            "taxPaid": 123.00,
            "taxTakenOffInEmployment": true
          },
          "redundancyCompensationPaymentsOverExemption": {
            "amount": 123.00,
            "taxPaid": 123.00,
            "taxTakenOffInEmployment": true
          },
          "redundancyCompensationPaymentsUnderExemption": {
            "amount": 123.00
          }
        }
      ]
    }
  ]
}
```



#### 9.2.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 9.2.11 ITSD Components Impacted

- IBD Store

### 9.2 Delete Other Employment Income

#### 9.2.1 URI

**DELETE** */income/other/employment/{taxableEntityId}/{taxYear}*

#### 9.2.2 Path Parameters

| Parameter       | Description                                  | Example  |
| --------------- | -------------------------------------------- | -------- |
| taxableEntityId | Unique identifier of the customer            | AB123456 |
| taxYear         | The tax year to which the employment applies | 2019-20  |

#### 9.2.3 Query Parameters

N/A

#### 9.2.4 Request Headers

| Header        | Description                   |
| ------------- | ----------------------------- |
| CorrelationId | Unique transaction reference. |

#### 9.2.5 Request Schema

N/A

#### 9.2.6 Request Examples

N/A

#### 9.2.7 Response Status Code

N/A

#### 9.2.8 Response Schema

N/A

#### 9.2.9 Response Examples

N/A

#### 9.2.10 Response Headers

| Header        | Description |
| ------------- | ----------- |
| CorrelationId |             |

#### 9.2.11 ITSD Components Impacted

- IBD Store

## Appendix A 

### Data Item Traceability

| Employment Data Item                                         | RTI Data Item                                                | NPS Data Item |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------- |
| employment.payrollId                                         | Item 35 (Optional 35 characters)                             |               |
| employment.closeCompanyDirector                              | N/A                                                          |               |
| employment.directorshipCeasedDate                            | N/A                                                          |               |
| employment.startDate                                         | Item 24 (Optional 8 characters)                              |               |
| employment.cessationDate                                     | Item 41 (Optional 8 characters)                              |               |
| employment.occupationalPension                               | Item 145 (Optional)                                          |               |
| employment.disguisedRemuneration                             | N/A                                                          |               |
| employment.employer.employerRef                              | Item 2 (Mandatory 10 characters)                             |               |
| employment.employer.employerName                             | N/A                                                          |               |
| employment.pay.taxablePayToDate                              | Item 41A (Mandatory 11 characters)                           |               |
| employment.pay.totalTaxToDate                                | Item 41B (Mandatory 11 characters)                           |               |
| employment.pay.tipsAndOtherPayments                          | N/A                                                          |               |
| employment.pay.payFrequency                                  | Item 42 (Mandatory represented as a codelist)                |               |
| employment.pay.paymentDate                                   | Item 43 (Mandatory 8 characters)                             |               |
| employment.pay.taxWeekNo                                     | Item 44 (Optional 2 characters (1 - 56 )) is this 01 etc?    |               |
| employment.pay.taxMonthNo                                    | Item 45 (Optional 2 characters (1-12)) is this 01 etc ?      |               |
| employment.lumpSums.taxableLumpSumsAndCertainIncome          | The amount of taxable lump sum and tax paid is not shown separately on RTI, it will be shown in RTI Data Items 41A and 41B (Taxable Pay to Date in this employment and Total tax to date in this employment). Not sure how we would know that these data items relate to a taxable lump sum. |               |
| employment.lumpSums.benefitFromEmployerFinancedRetirementScheme | The amount of benefit from an employer financed retirement scheme income and tax paid is not shown separately on RTI, it will be provided in RTI Data Items 41A and 41B. Not sure how we would know these data items relate to a benefit from employer financed retirement scheme without knowing the EMPREF of the scheme |               |
| employment.lumpSums.benefitFromEmployerFinancedRetirementScheme.exemptAmount | Item 58A                                                     |               |
| employment.lumpSums.redunancyCompensationPaymentsUnderException.amount | Item 58A                                                     |               |
| employment.deductions.studentLoans.uglDeductionAmount        | RTI Data Item 41C Optional but becomes mandatory once an amount has been submitted for the tax year. [Total student loans repayment recovered in year to date in this employment] |               |
| employment.deductions.studentLoans.pglDeductionAmount        | RTI Data Item 194 Optional but becomes mandatory once an amount has been submitted for the tax year. [Total postgraduate loan repayment recovered in year in this employment] |               |



## Appendix B

### Change Log:

| Version | Date       | Author      | Comments                                                     |
| ------- | ---------- | ----------- | ------------------------------------------------------------ |
| 1.0     | 20/05/2020 | Jon Elliott | Initial version looking at Employments retrieval             |
| 1.1     | 21/05/2020 | Jon Elliott | Refined the retrieval of employments by expanding the data fields |
| 1.2     | 22/05/2020 | Jon Elliott | Added new issues from design session, updated schemata for list employments and get employment. Added delete operation. Added dateIgnored to represent the date the customer requested HMRC ignored a customer. |
| 1.3     | 22/05/2020 | Toby Porter | Added Lump Sums, Pensions, Annuities & NICs                  |
| 1.4     | 26/05/2020 | Toby Porter | Subsumed occ pensions & annuities into main objects; removed Lump Sums pending further requirements analysis |
| 1.5     | 28/05/2020 | Toby Porter | Added lump sums that are linked to an employment             |
| 1.6     | 02/06/2020 | Jon Elliott | Support added for block level submission data.               |
| 1.7     | 08/06/2020 | Jon Elliott | Updates to document structure, merged pensions in, added ability to manage customer based employments added in expenses. |
| 1.8     | 10/06/2020 | Jon Elliott | Added API to manage ignoring of employments, updated schemas to represent historical data and aligned to latest field name changes. |
| 1.9     | 12/06/2020 | Jon Elliott | Updated Benefits field to benefits in kind (Product Owner Request), Updated employment schema in line with RTI Data items, Added Appendix to document field mappings (RTI) |
| 1.10    | 12/06/2020 | Jon Elliott | Added employmentId to ignoring an employment                 |
| 1.11    | 17/06/2020 | Jon Elliott | Added Pension Charges and Reliefs concerns, added placeholders for State Benefits. |
| 1.12    | 22/06/2020 | Jon Elliott | Removed Lump Sumps from employment financial details endpoints. Added lump Sumps to other employment income endpoints - update other employment income sources to use history block. |

## Appendix C

### RAID Log

#### Risks:

| Id   | Risk                                                         | Mitigation                                                   |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | API Design is being completed before requirements for the HiB are baselined, this could lead to APIs that do not deliver the views that are needed for the HiB | The HiB view historically has been the same as that of the customer with the addition of being able to see the history of customer based submissions, the APIs being designed here support that approach. |
| 2    | It is possible that if a customers records are updated at the same time by two distinct software packages then a record based lock may occur blocking one of the updates. Currently this will be returned to the customer as an internal service error, however this doesn't convey the need to refresh their view before trying again. | This is a wider issue than A4 and a the proposed solution of returning a 409 does not address the wider issue. As it stands the process of crystallisation should ensure that the customer agrees with their submitted data and they have the opportunity to correct any data they disagree with. HMRC need to determine how helpful they want to be in terms of implementing a proper optimistic locking pattern. |
|      |                                                              |                                                              |

#### Assumptions:

| Ref  | Assumption                                                   | Clarification                                                |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | An "ignored" employment will still be returned a part of the list of employments | this is correct otherwise the customer couldn't unignore it. |
| 2    | An "ignored" employment when retrieved will be clearly marked as ignored but the latest financial data for the employment will also be returned | Can't ignore in year - should get the latest view of the data as the ignore is a calculator instruction. |
| 3    | All views require a date time representing the last HMRC change date and a date time representing the last time the customer provided an override, this addresses issue 14 until further clarification of requirements are confirmed. |                                                              |
|      |                                                              |                                                              |

#### Issues: 

| Ref  | Description                                                  | Assigned To                             | Resolution                                                   |
| ---- | ------------------------------------------------------------ | --------------------------------------- | ------------------------------------------------------------ |
| 1    | If we allow a customer to create an employment via their 3pp do we create an inconsistent view of employments, does the ISS need to be informed etc. | Heidi Griffiths                         |                                                              |
| 2    | How does a customer "delete" a pre-pop employment if they don't believe its valid | Group                                   | Customer will be able to submit an ignore override for the tax year. They cannot delete an RTI employment. |
| 3    | Student Loans can be updated via 3pp and Student Loans service. Student loans service will only provide the updated deduction not the whole employment how is this being managed from a technical perspective | Ashleigh Carr, Jon Elliott, Tim Simpson | See Decision 11                                              |
| 4    | Expenses will not be pre-populated - do these need to be a dedicated endpoint |                                         |                                                              |
| 5    | Row #44 Foreign tax for which tax credit relief not claimed - is this not covered in Reliefs? | Heidi/SME to advise                     |                                                              |
| 6    | Rows #35-36 Class 2 and Class 4 National Insurance Contributions (NICs) - no class 2 details | Heidi/SME to advise                     | (Removed from employment)                                    |
| 7    | Expenses: check for employment before submitting? Include employment expenses in /expenses API? Cumulative/YTD totals? | Group                                   |                                                              |
| 8    | Unable to classify data items for Pensions & Lump sums - further clarity required - | Heidi/SME to advise                     | Classified as Lump Sums in employments moved pensions to a separate API |
| 9    | Locked records - how should these be handled - do HMRC want to protect customers from "dirty writes" | Jon Elliott                             |                                                              |
| 10   | Data primacy for employments needs to be resolved - current assumption is that time is master (i.e. latest submission wins), further discussions have led to concerns regarding where Actor, Channel and time should actually fit in. | Heidi / Julie                           |                                                              |
| 11   | Should we store SL Overrides from SLS in IBD Store - or query it as with other employments data. | Jon Elliott                             | Confirmed with Dave Beeston that we can treat SLS based SL overrides in the same manner as other employment data and pull it as needed (see Decision 11.) |
| 12   | Should the liability calculator use the latest FPS or the latest paid FPS when considering a customers liability | Heidi / Julie                           |                                                              |
| 13   | Once a customer has submitted an override should HMRC consider any subsequent data received via another channel e.g. the employer ? | Heidi / Julie                           |                                                              |
| 14   | There is confusion around the granularity of the date / time required in the views to convey when things were last changed and by which actor. A clarification of requirements is required. | Julie Turner                            | Confirmed that the requirement catalogue does not explicitely require fine grained details of change date times / actors. However the Product owners would like to consider this further and a requirement change may be required. |

#### Decisions: 

| Ref  | Decision                                                     | Rationale                                                    |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | Customers will need to access each employment individually   | Overrides are considered a replacement, this would mean that either the customer would need to submit all fields across all employments even if they were only changing one field this will create a poor customer journey |
| 2    | Each employment will be assigned a ITSD specific (unique) reference | Historic problems with encoding employer references drives us to avoid using it with payroll id as the unique identifier, therefore when an employment is created in the sub domain a unique id will be assigned to it |
| 3    | Customers will need to list their employments first via a GET API | As a consequence of decision 1 we will need to allow customers to retrieve their Ids before they can interact at employment level. |
| 4    | Employments will be retrieved via the _employment id_        | As per decision 3                                            |
| 5    | Customers will need to supply the complete resource when overriding | Consistent with other annual processing, regardless of how many data items within an employment a customer wants to override they will need to supply a complete resource, this moves the burden of delta processing to the 3pp |
| 6    | Customers cannot override the employer details               | This would be akin to creating a new employment and would need to follow a different route |
| 7    | Delete operation only deletes overrides                      | You can't delete RTI employments                             |
| 8    | If a delete operation occurs without an override it will return a 404 | You can only delete an override - In this scenario the override won't be found in IBD hence the 404. |
| 9    | Surface occupationalPension flag in the GET List so incomes from employment pay or pensions can be easily identified without having to drill into the detail | Pensions income and employment income are likely to be presented in separate views by data consumers |
| 10   | Student Loans will included in the Employment API i.e. there will not be a dedicated set of Student Loan endpoints. | Student Loans are intrinsically tied to an employment it makes little sense to strip them out. |
| 11   | Updates to Student Loan deductions provided by SLS will not be stored in IBD Store - rather they will be retrieved from SLS | This makes the pattern consistent with the way other employment data is being retrieved (RTI and NPS) and also means we only have to manage one source of override in IBD Store, that of the customer via 3pp.  (See Issue 11). |
| 12   | A customer added employment cannot be ignored - it must be deleted | Customers have the option to delete custom added employments they should use that approach rather than override with an ignore request. |
| 13   | Customers cannot provide a partial update to an employment, rather they must provide HMRC with a complete employment. | This makes it easier to understand the source of the data, when presenting it to either the HiB or customer i.e. it is either HMRC Held data or Customer provided data (via 3 party software). |
| 14   | The view service will provide a view of HMRC Held data, customer supplied data or the latest data. | This simplifies the provenance of data, it is either data HMRC holds in one of its systems (e.g. RTI), data the customer has provided, or the latest data that will be played into a calculation. |
| 15   | An ignored employment will not stop the customer viewing any data associated with the employment | The customer should be able to see this data, in case the want to check it before deciding to stop ignoring it. |
| 16   | An ignored employment will not block a customer from overriding an employment | The customer should be able to override the employment regardless of whether or not it is employed. |
| 17   | Removing an ignore instruction will mean that any previously submitted overrides will be considered by the calculation if they are still the latest view | Simplifies processing within the sub domain, the ignore instruction is at employment level when revoking the ignore instruction the latest view of the employment will always be used. |
| 18   | Ignored employments will still be presented in the calculation output (inputs section) | The employment will be marked as ignored and the financial details will not be presented however, the employment has still been considered by the calculation, it is simply honouring the customers request to ignore it. |
| 19   | Employment Expenses will present a single submitted on date via the view, that represents the last change date. | The data in NPS is richer than this and we can track changes at individual field level, there is a feeling that this information is valuable to the HiB operator but not perhaps so to the customer, this would necessitate two views or some transformation, as the data is already available in the NPS support tools it has been agreed that a simply view will be built with an eye on changing as needs dictate. |
| 20   | Customer can only amend financial data                       | Stakeholders have stated that all non financial data within the employment should not be amendable via customer software. |



