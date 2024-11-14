SELECT * FROM PortfolioProject..Nashvillehousing;

SELECT SaleDate,CONVERT(DATE,SaleDate) FROM PortfolioProject..Nashvillehousing;


ALTER TABLE PortfolioProject..Nashvillehousing ADD  SaleDateConverted DATE;

UPDATE PortfolioProject..Nashvillehousing SET SaleDateConverted = CONVERT(DATE, SaleDate);

SELECT * FROM PortfolioProject..Nashvillehousing;
-- Property Address
SELECT PropertyAddress FROM PortfolioProject..Nashvillehousing WHERE PropertyAddress IS NULL;

-- Select ParcelID and PropertyAddress 
SELECT ParcelID, PropertyAddress FROM PortfolioProject..Nashvillehousing;

SELECT ParcelID, PropertyAddress FROM PortfolioProject..Nashvillehousing WHERE PropertyAddress IS NULL ORDER BY ParcelID;

-- Join the table to itself
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..Nashvillehousing a
JOIN PortfolioProject..Nashvillehousing b
ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ] WHERE a.PropertyAddress IS NULL;

UPDATE a 
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..Nashvillehousing a
JOIN PortfolioProject..Nashvillehousing b
ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;


-- Breaking out Propertyaddress into Individual Columns(Address, City, State)
SELECT PropertyAddress FROM PortfolioProject..Nashvillehousing;

SELECT SUBSTRING(PropertyAddress,1,
CHARINDEX(',',PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) AS City
FROM PortfolioProject..Nashvillehousing;


ALTER TABLE PortfolioProject..Nashvillehousing 
ADD PropertySplitAddress Nvarchar(255);

UPDATE PortfolioProject..Nashvillehousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1);

ALTER TABLE PortfolioProject..Nashvillehousing
ADD PropertySplitCity Nvarchar(255);

UPDATE PortfolioProject..Nashvillehousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress));

SELECT * FROM PortfolioProject..Nashvillehousing;

-- Breaking out OwnerAddress into Individual Columns(Address, City, State)
SELECT OwnerAddress FROM PortfolioProject..Nashvillehousing;

SELECT OwnerAddress FROM PortfolioProject..Nashvillehousing WHERE OwnerAddress IS NOT NULL;

SELECT * FROM PortfolioProject..Nashvillehousing WHERE OwnerAddress IS NOT NULL;

SELECT c.ParcelID, c.OwnerAddress, d.ParcelID, d.PropertyAddress FROM PortfolioProject..Nashvillehousing c
JOIN PortfolioProject..Nashvillehousing d ON
c.ParcelID = d.ParcelID AND c.[UniqueID ] <> d.[UniqueID ]
WHERE c.OwnerAddress IS NULL;

SELECT SUBSTRING(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1) AS OwnerSplitAddress,
SUBSTRING(OwnerAddress, CHARINDEX(',', OwnerAddress)+1,LEN(OwnerAddress)) AS OwnerSplitCity 
FROM PortfolioProject..Nashvillehousing WHERE OwnerAddress IS NOT NULL;

ALTER TABLE PortfolioProject..Nashvillehousing
ADD OwnerSplitAddress Nvarchar(255);

UPDATE PortfolioProject..Nashvillehousing
SET OwnerSplitAddress = SUBSTRING(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1);

ALTER TABLE PortfolioProject..Nashvillehousing
ADD OwnerSplitCity Nvarchar(255);

--
UPDATE PortfolioProject..Nashvillehousing
SET OwnerSplitCity = SUBSTRING(OwnerAddress, CHARINDEX(',',OwnerAddress)+1, LEN(OwnerAddress));

--Use PARSENAME instead of SUBSTRING
SELECT PARSENAME(REPLACE(OwnerAddress, ',', '.'),3) AS OwnerSplitAddress,
PARSENAME(REPLACE(OwnerAddress,',','.'),2) AS OwnerSplitCity,
PARSENAME(REPLACE(OwnerAddress,',','.'),1) AS OwnerSplitState
FROM PortfolioProject..Nashvillehousing WHERE OwnerAddress IS NOT NULL;

UPDATE PortfolioProject..Nashvillehousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2);

ALTER TABLE PortfolioProject..Nashvillehousing
ADD OwnerSplitState Nvarchar(255);

UPDATE PortfolioProject..Nashvillehousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1);


SELECT * FROM PortfolioProject..Nashvillehousing WHERE OwnerAddress IS NOT NULL;


SELECT * FROM PortfolioProject..Nashvillehousing;

SELECT DISTINCT OwnerSplitCity FROM PortfolioProject..Nashvillehousing;


-- change Y and N to Yes and No in "SoldAsVacant" column

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) FROM PortfolioProject..Nashvillehousing
Group by SoldAsVacant;

SELECT SoldAsVacant,
CASE
WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END
FROM PortfolioProject..Nashvillehousing;

UPDATE PortfolioProject..Nashvillehousing
SET SoldAsVacant = CASE
WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END;

-- Remove Duplicates
WITH ROWNUM AS(
SELECT *, ROW_NUMBER() OVER (PARTITION BY
ParcelID,
PropertyAddress,
SaleDate,
SalePrice,
LegalReference ORDER BY UniqueID) row_num
FROM PortfolioProject..Nashvillehousing)

SELECT * FROM ROWNUM WHERE row_num > 1;

DELETE FROM ROWNUM WHERE row_num > 1;

--Remove Unused Columns
ALTER TABLE PortfolioProject..Nashvillehousing
DROP COLUMN SaleDate;

SELECT * FROM PortfolioProject..Nashvillehousing;

