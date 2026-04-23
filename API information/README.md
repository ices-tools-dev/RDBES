# RDBES API Data Export: User Help Document

## 1. OverviewThe RDBES API uses a single "Request Object" contract to handle multiple data types. This document explains how to configure the payload for each specific data type using the package `RdbesAPIExportClient` in R.

## 2. API EndpointsUsers should choose the `api_url` based on their current task:
*   **Testing (Sandbox):** `https://sboxrdbesapi.ices.dk/api/v1/export-jobs`
*   **Production (Live):** `https://rdbesapi.ices.dk/api/v1/export-jobs`
*   
## 3. Core Security & Permissions (Mandatory)The **Country** field within the filter list is mandatory for permission validation.
*   **Specific Access:** Provide a country code (e.g., `"ZW"`, `"DK"`, `"FR"`).
*   **RCG Access:** Use the value `"All"`. This requests data for all countries within the Regional Coordination Group (RCG) that your account is authorized to download.
*   
## 4. RCG Download Filtering RulesWhen using the `"All"` country keyword for **Commercial Sampling (CS)**, the API automatically restricts data to the specific ICES areas authorized for your RCG. 
*   For Hierarchies **H1, H2, H3, H6, H10, and H13**, these restrictions are applied to the `foArea` field.
*   For Hierarchies **H4, H5, H7, H8, H9, H11, and H12**, they are applied to the `leArea` field. 

**Note:** If you manually provide values for `foArea` or `leArea` during an RCG download, they will be **overridden**, and the request will be strictly limited to the official RCG-authorized areas.

## 5. Mandatory Request Object FieldsEvery request must include these five core components:
1.  **dataType:** `"CS"`, `"CL"`, `"CE"`, `"SL"`, or `"VD"`.
2.  **format:** `"SingleCsvFile"` or `"CsvFilePerTable"`.
3.  **includeDisclaimer:** Must be `TRUE`.4.  **hierarchies:** The specific hierarchy list for the data type.
5.  **Data Type Filters:** The specific filter object for the data type (e.g., `csFilters`).
---## 6. Data Type Configuration Examples### Commercial Sampling (CS)```r
library(RdbesAPIExportClient)

# Use sandbox for testing or production for live data
api_url <- "https://sboxrdbesapi.ices.dk/api/v1/export-jobs" 

my_payload <- list(
  dataType          = "CS",
  format            = "SingleCsvFile",
  includeDisclaimer = TRUE,
  hierarchies       = list("H1", "H5", "H6", "H13"),
  csFilters         = list(
    sdCountry         = list("All"),  # Mandatory for Permissions
    deYear            = list("2024"), # Available Optional Filter
    # deSamplingScheme  = list(),       # Available Optional Filter
    # deStratumName     = list(""),     # Available Optional Filter
    # saSpeciesCode     = list(),       # Available Optional Filter
    # foArea            = list(),       # Available Optional Filter
    # leArea            = list()        # Available Optional Filter
  )
)

rdbes_download_data(url = api_url, payload = my_payload)

## Commercial Landings (CL)

library(RdbesAPIExportClient)

api_url <- "https://sboxrdbesapi.ices.dk/api/v1/export-jobs"

my_payload <- list(
  dataType          = "CL",
  format            = "SingleCsvFile",
  includeDisclaimer = TRUE,
  hierarchies       = list("HCL"),
  clFilters         = list(
    clVesselFlagCountry = list("All"), # Mandatory for Permissions
    clYear              = list("2024")  # Available Optional Filter
    # clArea              = list(),      # Available Optional Filter
    # clSpeciesCode       = list()       # Available Optional Filter
  )
)

rdbes_download_data(url = api_url, payload = my_payload)

## Commercial Effort (CE)

library(RdbesAPIExportClient)

api_url <- "https://sboxrdbesapi.ices.dk/api/v1/export-jobs"

my_payload <- list(
  dataType          = "CE",
  format            = "SingleCsvFile",
  includeDisclaimer = TRUE,
  hierarchies       = list("HCE"),
  ceFilters         = list(
    ceVesselFlagCountry = list("All"), # Mandatory for Permissions
    ceYear              = list("2024")  # Available Optional Filter
    # ceArea              = list()       # Available Optional Filter
  )
)

rdbes_download_data(url = api_url, payload = my_payload)

## Species List (SL)

library(RdbesAPIExportClient)

api_url <- "https://sboxrdbesapi.ices.dk/api/v1/export-jobs"

my_payload <- list(
  dataType          = "SL",
  format            = "SingleCsvFile",
  includeDisclaimer = TRUE,
  hierarchies       = list("HSL"),
  slFilters         = list(
    slCountry         = list("All"),  # Mandatory for Permissions
    slYear            = list("2024")  # Available Optional Filter
    # slSpeciesListName = list(""),     # Available Optional Filter
    # slCatchFraction   = list()        # Available Optional Filter
  )
)

rdbes_download_data(url = api_url, payload = my_payload)

## Vessel Details (VD)

library(RdbesAPIExportClient)

api_url <- "https://sboxrdbesapi.ices.dk/api/v1/export-jobs"

my_payload <- list(
  dataType          = "VD",
  format            = "SingleCsvFile",
  includeDisclaimer = TRUE,
  hierarchies       = list("HVD"),
  vdFilters         = list(
    vdCountry = list("All"),           # Mandatory for Permissions
    vdYear    = list("2024")           # Available Optional Filter
  )
)

rdbes_download_data(url = api_url, payload = my_payload)

------------------------------
## 7. Quick Tips for Users

* Multiple Values: You can filter for multiple values like this: list("2023", "2024").
* Activating Optional Filters: Remove the # from a line to use that specific filter.
* Permission Errors: Double-check that your account has access to the country code or RCG "All".




