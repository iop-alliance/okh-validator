# OKH Validator for Makers

## Introduction

The objective of the [Open Know-How (OKH) specification](https://standards.internetofproduction.org/pub/okh/) is to improve the openness of know-how for making physical goods by improving the discoverability, portability and interactivity of knowledge. The intent is that a maker, designer, or platform can choose to adopt the OKH specification. The mandatory aspects of this specification are kept to a minimum, to lessen the barriers for those who want to make their know-how discoverable. The OKH standard aligns with the [Open Source Hardware Definition](https://www.oshwa.org/definition/) and other efforts to standardise approaches for documenting how to make things. Version 1 of the OKH Specification provides a schema for providing metadata in a consistent format and a mode of information exchange enabling indexing and discovery of open hardware by stakeholders.

The aim is that by using the OKH pecification, makers can publish their creative work across multiple platforms, share their work with wider audiences, easily keep their designs up-to-date, build on each other's work and contributions (no matter what software they use) and secure their livelihoods and work. Specifically concerned by the data and content created by makers (designs and documentation for hardware, together referred to as “works”), the IOPA continues the exploration of tools to re-establish the boundary between makers and service providers hosting this data.

## Proof-of-concept enhanced data validation tool

### Web-Based Validator

This is a proof of concept for a web-based validator that is aimed at makers who require validation of their manifest files to determine if they are valid for extracting the relevant project dats in order to be able to use it for export/import. 

The validator takes as its input the URL of a manifest that is published online and performs the following steps to extract and validate its content:

* Checks that the manifest is a valid YAML file. If the file is not valid YAML then the validation stops and the error is reported to the user
* Checks that the manifest contains the required fields as defined in the Open Know-How Specification v1.0.0. If any of the required fields are not found then an error is raised and the missing field is highlighted to the user
* Each of the fields that are present in the manifest are validated as to whether it is formatted correctly according to the specified field types and schemas in the Open Know-How Specification. A report is generated showing:
    * Any errors for fields that don’t meet the specified validation criteria
    * Any fields that are defined in the Open Know-Specification that are not found in the manifest; this will assist the user in identifying any information that they might want to add to the manifest
    * For fields that are present, the value of the field is shown in the output

The beta version of the manifest validator can be accessed at https://okh-v1-validator.fly.dev 

### REST API
A proof of conceot REST API has also been implemented to enable developers and platforms to validate manifests submitted by users. The API performs the current functions:

* Checks if the manifest is valid according to the Open Know-How Specification: is valid YAML and contains all required fields. It returns a manifest-validation object that contains the manifest validation results
* Validates each of the fields in the manifest against the Open Know-How specifications. It returns a field-validations object that contains validation information for each of the OKH fields according to the schema described in the [Validation Criteria](#validation-criteria)

The API specifications (under development), including descriptions of the returned objects are published at: https://app.swaggerhub.com/apis/iopa/okh-v1-validator/1.0.0 

The endpoint for the REST API is:

https://okh-v1-validator.fly.dev/api/validate?manifest=[manifest_url]    

where [manifest_url] is the URL of a manifest that is published online.

## Open Know-How Validation

Version 1.0.0 of the Open Know-How Specification was developed to help make the knowledge related to the distributed manufacturing of physical products discoverable through the publishing of manifest files that describe the data about how to make a product, as well as the locations of the design and documentation files.

In order to facilitate the portability of the projects that are described in Open Know-How manifests, there needs to be a way of validating their content to ensure that the data in the file is valid, and that the resources that the manifest points to are also valid.

There are two general areas of validation of Open Know-How manifests. One is the validation of the format and required fields, the other is the validation of the content of all present fields

According to the Open Know-How standard, if a manifest satisfies the following requirements, then the manifest is valid:

* It is valid YAML 1.2
* It contains valid data in the four required fields: title; description; license; and one of either documentation-home or project-link is present

However, for the OKH manifest to be used as a basis for the portability of the data for the projects that they describe, the content of each of the fields need to be validated. 

For example, to be able to port the project's design files between platforms, then there needs to be validation not only of whether the field is present in the manifest file, but also that it is in a valid URL which can be successfully accessed (e.g. does not return a not found/404 error).

Therefore, the validation criteria for each of the manifest fields have been analysed to assess how the specification for the current Open Know-How standard (v1.0.0) can be used to validate all of the data for a project.

The following table lists the 41 field names specified in version 1.0.0 of the Open Know-How  Specification along with the type or schema that applies to each field:


| Field name                    | Type or Schema                        |
| ---                           | ---                                   |
| title                         | [String](#string-field)               |
| description	                | [String](#string-field)               |
| intended-use	                | [String](#string-field)               |
| keywords	                    | Array of [Strings](#string-field)     |
| image	                        | [URL](#url-field)                     |
| project-link	                | [URL](#url-field)                     |
| made                          | [Boolean](#boolean-field)             |
| made-independently	        | [Boolean](#boolean-field)             |
| license	                    | License                               |
| licensor	                    | [Person](#person-field)               |
| date-created	                | [Date](#date-field)                   |
| date-updated	                | [Date](#date-field)                   |
| manifest-author	            | [Person](#person-field)               |
| manifest_language	            | [Language](#language-field)           |
| manifest-is-translation	    | [Translation](#translation-field)     |
| contact   	                | [Contact](#contact-field)             |
| contributors	                | Array of [Person](#person-field)      |
| version	                    | [String](#string-field)               |
| development-stage	            | [String](#string-field)               |
| documentation-home	        | [URL](#url-field)                     |
| archive-download	            | [URL](#url-field)                     |
| design-files	                | Array of [Links](#link-field)         |
| documentation_language	    | [Language](#language-field)           |
| documentation-is-translation	| [Translation](#translation-field)     |
| schematics	                | Array of [Links](#link-field)         |
| bom           	            | [URL](#url-field)                     |
| tool-list	                    | [URL](#url-field)                     |
| making-instructions	        | Array of [Links](#link-field)         |
| manufacturing-files	        | Array of [Links](#link-field)         |
| risk-assessment	            | Array of [Links](#link-field)         |
| tool-settings	                | Array of [Links](#link-field)         |
| quality-instructions	        | Array of [Links](#link-field)         |
| operating-instructions	    | Array of [Links](#link-field)         |
| maintenance-instructions	    | Array of [Links](#link-field)         |
| disposal-instructions	        | Array of [Links](#link-field)         |
| software          	        | Array of [Links](#link-field)         |
| health-safety-notice	        | [String](#string-field)               |
| standards-used	            | Array of [Standards](#standard-field) |
| derivative-of	                | Project                               |
| variant-of	                | Project                               |
| sub           	            | Project                               |

_Table 1: Open Know-How manifest field types and schemas_


## Validation Criteria

This section describes the validation criteria for the field types and schemas listed in Table 1).

### String field

Validation: All string fields will be encoded as utf-8 characters

### Date field

Validation: date fields will use ISO 8601 complete date format (YYYY-MM-DD)

### Email field

Validation: format of an email address is local-part@domain

### URL field

Some of the fields listed as URLs in Table 1 are detailed in the Open Know-How specifications as being valid if they are either a relative or an absolute path. For relative paths, the standard's specifications are such that "relative paths shall be relative to the location of the Open Know-How Manifest in the documentation repository". This was written assuming that the file is accessed by a crawler. If the manifest is to be used as a basis for portability, then it should be serve as a stand-alone shareable content object reference model to retrieve all files related to a specific project. As such, relative paths are not useful in this context so the validator does not currently check for them, only absolute URLs.

Validation: URL fields will be valid URLs that return an HTTP status 200.

### Language field

Validation: a field of type language must be a string in a format that complies with the ISO 639 language cods or the ISO 3166 country code as per BCP 47.

### Person field

A field with the Person schema can contain the following fields:

| Field name	| Type or Schema    |
| ---           | ---               | 
| name	        | [String](#string-field)            |
| affiliation   |	[String](#string-field)          |
| email         |	[Email](#email-field)           |

_Table 2: field types for the Person schema_

### Contact field

A field with the Contact schema can contain the following fields:

| Field name	| Type or Schema            |
| ---           | ---                       | 
| name          | [String](#string-field)                    |
| affiliation   | [String](#string-field)                    |
| Email         | [Email](#email-field)                     |
| Social        | Array of [SocialAccount](#socialaccount-field)    |

_Table 3: field types for the Contact schema_

### SocialAccount field

A field with the Platform schema can contain the following fields:

| Field name	| Type or Schema            |
| ---           | ---                       | 
| platform	    | [String](#string-field)                    |
| user-handle	| [String](#string-field)                    |

_Table 4: field types for the Platform schema_

### Boolean field

Validation: Boolean value of true or false

### Standard field
A field with the Standard schema can contain the following fields:

| Field name	    | Type or Schema            |
| ---               | ---                       | 
| standard-title	| [String](#string-field)                    |
| publisher	        | [String](#string-field)                    |
| reference 	    | [String](#string-field)                    |
| certification	    | [Certification](#certification-field)             |

_Table 5: field types for the Standard schema_

### Certification field

A field with the Certification schema can contain the following fields:

| Field name	    | Type or Schema            |
| ---               | ---                       | 
|certifier	        | [String](#string-field)                    |    
|date-awarded	    | [Date](#date-field)                      |
|link	            | [URL](#url-field)                       |

_Table 6: field types for the Certification schema_

### Link field

A field with the Link schema can contain the following fields:

| Field name	    | Type or Schema            |
| ---               | ---                       | 
| path	            | [URL](#url-field)                       |
| title	            | [String](#string-field)                    |    

_Table 7: field types for the Link schema_

### Translation field

A field with the Translation schema can contain the following fields:

| Field name	    | Type or Schema            |
| ---               | ---                       | 
| title	            | [String](#string-field)                    |
| manifest	        | [URL](#url-field)                       |
| web	            | [URL](#url-field)                       |
| lang	            | [Language](#language-field)                  |

_Table 8: field types for the Translation schema_

 
