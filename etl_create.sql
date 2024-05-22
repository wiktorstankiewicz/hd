-- Create a staging table for raw CSV data with only the necessary columns
CREATE TABLE STAGING_PROPERTY (
    pin NVARCHAR(255),
    totalsalevalue DOUBLE,
    bldgvalue DOUBLE,
    totalbldgsqft DOUBLE,
    calcacreage DOUBLE,
    yearbuilt INT,
    totalsaledate DATE,
    landclass NVARCHAR(255),
    lclass NVARCHAR(255),
    phycity NVARCHAR(255),
    phyzip NVARCHAR(255),
    streettype NVARCHAR(255),
    streetname NVARCHAR(255),
    billingclass NVARCHAR(255),
    apaownershipdesc NVARCHAR(255),
    apaactivitydesc NVARCHAR(255),
    apafunctiondesc NVARCHAR(255),
    apastructuredesc NVARCHAR(255),
    apasitedesc NVARCHAR(255),
    utilities NVARCHAR(255)
);



CREATE TABLE FACT_SALES (
    Pin NVARCHAR(255) PRIMARY KEY,
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
    AvailableUtilities NVARCHAR(255)
);

CREATE TABLE DIM_LANDCLASS (
    Id INT PRIMARY KEY,
    LandClassCode NVARCHAR(255),
    LandClassDesc NVARCHAR(255)
);

CREATE TABLE DIM_LOCATION (
    Id INT PRIMARY KEY,
    City NVARCHAR(255),
    CityZipCode NVARCHAR(255),
    StreetType NVARCHAR(255),
    StreetName NVARCHAR(255)
);

CREATE TABLE DIM_BUILD_YEAR (
    Id INT PRIMARY KEY,
    Year INT
);

CREATE TABLE DIM_BILLING (
    Id INT PRIMARY KEY,
    BillingClass NVARCHAR(255)
);

CREATE TABLE DIM_SALE_DATE (
    Id INT PRIMARY KEY,
    Year INT,
    Quarter INT,
    Month INT
);

CREATE TABLE DIM_OWNERSHIP (
    Id INT PRIMARY KEY,
    OwnershipDesc NVARCHAR(255)
);

CREATE TABLE DIM_ACTIVITY (
    Id INT PRIMARY KEY,
    ActivityDesc NVARCHAR(255)
);

CREATE TABLE DIM_FUNCTION (
    Id INT PRIMARY KEY,
    FunctionDesc NVARCHAR(255)
);

CREATE TABLE DIM_STRUCTURE (
    Id INT PRIMARY KEY,
    StructureDesc NVARCHAR(255)
);

CREATE TABLE DIM_SITE (
    Id INT PRIMARY KEY,
    SiteDesc NVARCHAR(255)
);
