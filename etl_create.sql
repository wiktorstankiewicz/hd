-- Create a staging table for raw CSV data with only the necessary columns
CREATE TABLE STAGING_PROPERTY (
    pin VARCHAR(255),
    totalsalevalue DOUBLE,
    bldgvalue DOUBLE,
    totalbldgsqft DOUBLE,
    calcacreage DOUBLE,
    yearbuilt INT,
    totalsaledate DATE,
    landclass VARCHAR(255),
    lclass VARCHAR(255),
    phycity VARCHAR(255),
    phyzip VARCHAR(255),
    streettype VARCHAR(255),
    streetname VARCHAR(255),
    billingclass VARCHAR(255),
    apaownershipdesc VARCHAR(255),
    apaactivitydesc VARCHAR(255),
    apafunctiondesc VARCHAR(255),
    apastructuredesc VARCHAR(255),
    apasitedesc VARCHAR(255),
    utilities VARCHAR(255)
);



CREATE TABLE FACT_SALES (
    Pin VARCHAR(255) PRIMARY KEY,
    TotalSaleValue DOUBLE,
    TotalEstimateValue DOUBLE,
    BldgEstimateSqFtValue DOUBLE,
    LandEstimateAcreValue DOUBLE,
    ValueShiftPercentage DOUBLE,
    OwnershipId INT,
    ActivityId INT,
    FunctionId INT,
    StructureId INT,
    SiteId INT,
    LandClassId INT,
    LocationId INT,
    BuildYearId INT,
    BillingId INT,
    SaleDateId INT
);

CREATE TABLE DIM_UTILITIES (
    Id INT PRIMARY KEY,
    AvailableUtilities VARCHAR(255)
);

CREATE TABLE DIM_LANDCLASS (
    Id INT PRIMARY KEY,
    LandClassCode VARCHAR(255),
    LandClassDesc VARCHAR(255)
);

CREATE TABLE DIM_LOCATION (
    Id INT PRIMARY KEY,
    City VARCHAR(255),
    CityZipCode VARCHAR(255),
    StreetType VARCHAR(255),
    StreetName VARCHAR(255)
);

CREATE TABLE DIM_BUILD_YEAR (
    Id INT PRIMARY KEY,
    Year INT
);

CREATE TABLE DIM_BILLING (
    Id INT PRIMARY KEY,
    BillingClass VARCHAR(255)
);

CREATE TABLE DIM_SALE_DATE (
    Id INT PRIMARY KEY,
    Year INT,
    Quarter INT,
    Month INT
);

CREATE TABLE DIM_OWNERSHIP (
    Id INT PRIMARY KEY,
    OwnershipDesc VARCHAR(255)
);

CREATE TABLE DIM_ACTIVITY (
    Id INT PRIMARY KEY,
    ActivityDesc VARCHAR(255)
);

CREATE TABLE DIM_FUNCTION (
    Id INT PRIMARY KEY,
    FunctionDesc VARCHAR(255)
);

CREATE TABLE DIM_STRUCTURE (
    Id INT PRIMARY KEY,
    StructureDesc VARCHAR(255)
);

CREATE TABLE DIM_SITE (
    Id INT PRIMARY KEY,
    SiteDesc VARCHAR(255)
);
