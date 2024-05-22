-- Load data from CSV file into the staging table
BULK INSERT STAGING_PROPERTY
FROM '/mnt/data/property.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- Remove rows with any null values in the necessary columns
DELETE FROM STAGING_PROPERTY WHERE
    pin IS NULL OR
    totalsalevalue IS NULL OR
    bldgvalue IS NULL OR
    totalbldgsqft IS NULL OR
    calcacreage IS NULL OR
    yearbuilt IS NULL OR
    totalsaledate IS NULL OR
    landclass IS NULL OR
    lclass IS NULL OR
    phycity IS NULL OR
    phyzip IS NULL OR
    streettype IS NULL OR
    streetname IS NULL OR
    billingclass IS NULL OR
    apaownershipdesc IS NULL OR
    apaactivitydesc IS NULL OR
    apafunctiondesc IS NULL OR
    apastructuredesc IS NULL OR
    apasitedesc IS NULL OR
    utilities IS NULL;

INSERT INTO DIM_UTILITIES (Id, AvailableUtilities)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY utilities), utilities
FROM STAGING_PROPERTY;

INSERT INTO DIM_LANDCLASS (Id, LandClassCode, LandClassDesc)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY landclass), landclass, lclass
FROM STAGING_PROPERTY;

INSERT INTO DIM_LOCATION (Id, City, CityZipCode, StreetType, StreetName)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY phycity), phycity, phyzip, streettype, streetname
FROM STAGING_PROPERTY;

INSERT INTO DIM_BUILD_YEAR (Id, Year)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY yearbuilt), yearbuilt
FROM STAGING_PROPERTY;

INSERT INTO DIM_BILLING (Id, BillingClass)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY billingclass), billingclass
FROM STAGING_PROPERTY;

INSERT INTO DIM_SALE_DATE (Id, Year, Quarter, Month)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY YEAR(totalsaledate), DATEPART(quarter, totalsaledate), DATEPART(month, totalsaledate)), 
    YEAR(totalsaledate), DATEPART(quarter, totalsaledate), DATEPART(month, totalsaledate)
FROM STAGING_PROPERTY;

INSERT INTO DIM_OWNERSHIP (Id, OwnershipDesc)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY apaownershipdesc), apaownershipdesc
FROM STAGING_PROPERTY;

INSERT INTO DIM_ACTIVITY (Id, ActivityDesc)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY apaactivitydesc), apaactivitydesc
FROM STAGING_PROPERTY;

INSERT INTO DIM_FUNCTION (Id, FunctionDesc)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY apafunctiondesc), apafunctiondesc
FROM STAGING_PROPERTY;

INSERT INTO DIM_STRUCTURE (Id, StructureDesc)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY apastructuredesc), apastructuredesc
FROM STAGING_PROPERTY;

INSERT INTO DIM_SITE (Id, SiteDesc)
SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY apasitedesc), apasitedesc
FROM STAGING_PROPERTY;

INSERT INTO FACT_SALES (Pin, TotalSaleValue, TotalEstimateValue, BldgEstimateSqFtValue, LandEstimateAcreValue, ValueShiftPercentage, OwnershipId, ActivityId, FunctionId, StructureId, SiteId, LandClassId, LocationId, BuildYearId, BillingId, SaleDateId)
SELECT 
    s.pin,
    s.totalsalevalue,
    s.bldgvalue + s.landvalue,
    s.bldgvalue / s.totalbldgsqft,
    s.landvalue / s.calcacreage,
    (s.bldgvalue + s.landvalue - s.totalsalevalue) / s.totalsalevalue * 100,
    o.Id,
    a.Id,
    f.Id,
    st.Id,
    si.Id,
    lc.Id,
    l.Id,
    by.Id,
    b.Id,
    sd.Id
FROM 
    STAGING_PROPERTY s
    LEFT JOIN DIM_OWNERSHIP o ON s.apaownershipdesc = o.OwnershipDesc
    LEFT JOIN DIM_ACTIVITY a ON s.apaactivitydesc = a.ActivityDesc
    LEFT JOIN DIM_FUNCTION f ON s.apafunctiondesc = f.FunctionDesc
    LEFT JOIN DIM_STRUCTURE st ON s.apastructuredesc = st.StructureDesc
    LEFT JOIN DIM_SITE si ON s.apasitedesc = si.SiteDesc
    LEFT JOIN DIM_LANDCLASS lc ON s.landclass = lc.LandClassCode AND s.lclass = lc.LandClassDesc
    LEFT JOIN DIM_LOCATION l ON s.phycity = l.City AND s.phyzip = l.CityZipCode AND s.streettype = l.StreetType AND s.streetname = l.StreetName
    LEFT JOIN DIM_BUILD_YEAR by ON s.yearbuilt = by.Year
    LEFT JOIN DIM_BILLING b ON s.billingclass = b.BillingClass
    LEFT JOIN DIM_SALE_DATE sd ON YEAR(s.totalsaledate) = sd.Year AND DATEPART(quarter, s.totalsaledate) = sd.Quarter AND DATEPART(month, s.totalsaledate) = sd.Month;
