-- Create a staging table for raw CSV data with all columns except the last two
CREATE TABLE STAGING_PROPERTY (
    pin NVARCHAR(255),
    pin10 NVARCHAR(255),
    realid NVARCHAR(255),
    owner NVARCHAR(255),
    owner2 NVARCHAR(255),
    owneradd1 NVARCHAR(255),
    owneradd2 NVARCHAR(255),
    owneradd3 NVARCHAR(255),
    location NVARCHAR(255),
    calcacreage FLOAT,
    deedacres FLOAT,
    streetnumber NVARCHAR(255),
    streetmisc NVARCHAR(255),
    streetprefix NVARCHAR(255),
    streetname NVARCHAR(255),
    streettype NVARCHAR(255),
    streetsuffix NVARCHAR(255),
    landclass NVARCHAR(255),
    lclass NVARCHAR(255),
    totalstructures INT,
    totalunits INT,
    propertydesc NVARCHAR(255),
    lotnum NVARCHAR(255),
    bldgvalue FLOAT,
    landvalue FLOAT,
    landsalevalue FLOAT,
    landsaledate DATE,
    totalsalevalue FLOAT,
    totalsaledate DATE,
    deedbook NVARCHAR(255),
    deedpage NVARCHAR(255),
    wc_city NVARCHAR(255),
    cary_city NVARCHAR(255),
    wc_etj NVARCHAR(255),
    topography NVARCHAR(255),
    township NVARCHAR(255),
    apaownership NVARCHAR(255),
    apaactivity NVARCHAR(255),
    apafunction NVARCHAR(255),
    apastructure NVARCHAR(255),
    apasite NVARCHAR(255),
    wc_zoning NVARCHAR(255),
    billingclass NVARCHAR(255),
    apaownershipdesc NVARCHAR(255),
    apaactivitydesc NVARCHAR(255),
    apafunctiondesc NVARCHAR(255),
    apastructuredesc NVARCHAR(255),
    apasitedesc NVARCHAR(255),
    county NVARCHAR(255),
    totalbldgsqft FLOAT,
    typeanduse NVARCHAR(255),
    typedecode NVARCHAR(255),
    phycity NVARCHAR(255),
    phyzip NVARCHAR(255),
    utilities NVARCHAR(255),
    ownerwholename NVARCHAR(255),
    reallink NVARCHAR(255),
    deedlink NVARCHAR(255),
    shape_starea FLOAT,
    shape_stlength FLOAT,
    yearbuilt INT
);




CREATE TABLE FACT_SALES (
    Pin NVARCHAR(255) PRIMARY KEY,
    TotalSaleValue FLOAT,
    TotalEstimateValue FLOAT,
    BldgEstimateSqFtValue FLOAT,
    LandEstimateAcreValue FLOAT,
    ValueShiftPercentage FLOAT,
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
    Id INT PRIMARY KEY IDENTITY(1,1),
    AvailableUtilities NVARCHAR(255)
);

CREATE TABLE DIM_LANDCLASS (
    Id INT PRIMARY KEY IDENTITY(1,1),
    LandClassCode NVARCHAR(255),
    LandClassDesc NVARCHAR(255)
);

CREATE TABLE DIM_LOCATION (
    Id INT PRIMARY KEY IDENTITY(1,1),
    City NVARCHAR(255),
    CityZipCode NVARCHAR(255),
    StreetType NVARCHAR(255),
    StreetName NVARCHAR(255)
);

CREATE TABLE DIM_BUILD_YEAR (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Year INT
);

CREATE TABLE DIM_BILLING (
    Id INT PRIMARY KEY IDENTITY(1,1),
    BillingClass NVARCHAR(255)
);

CREATE TABLE DIM_SALE_DATE (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Year INT,
    Quarter INT,
    Month INT
);

CREATE TABLE DIM_OWNERSHIP (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OwnershipDesc NVARCHAR(255)
);

CREATE TABLE DIM_ACTIVITY (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ActivityDesc NVARCHAR(255)
);

CREATE TABLE DIM_FUNCTION (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FunctionDesc NVARCHAR(255)
);

CREATE TABLE DIM_STRUCTURE (
    Id INT PRIMARY KEY IDENTITY(1,1),
    StructureDesc NVARCHAR(255)
);

CREATE TABLE DIM_SITE (
    Id INT PRIMARY KEY IDENTITY(1,1),
    SiteDesc NVARCHAR(255)
);
