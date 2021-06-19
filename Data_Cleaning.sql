--Cleaning data in SQL Queries
SELECT *
FROM NashvilleHousing

--1. Change sale date (remove time at the end of date)
SELECT SaleDate, CONVERT(Date,SaleDate)
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate=CONVERT(Date,SaleDate)

--The update statement above did not work, 
--so let's try something else

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

SELECT SaleDateConverted 
FROM NashvilleHousing

--This now works with the new SalesDateConverted column

--2. Populate Property Address data
--We want to understand why there are nulls in this column

SELECT *
FROM NashvilleHousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

--We noticed after looking through the data that when ParcelID
--is duplicated, PropertyAddress is also duplicated

--We need a self join where ParcelID is the same but it's 
--not the same row
--We also need the ISNULL function
SELECT a.ParcelID, a.PropertyAddress, 
b.ParcelID, b.PropertyAddress, 
ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID=b.ParcelID
AND a.UniqueID<>b.UniqueID
WHERE a.PropertyAddress IS NULL

--Let's update to remove the NULLS
UPDATE a
SET PropertyAddress=ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID=b.ParcelID
AND a.UniqueID<>b.UniqueID
WHERE a.PropertyAddress IS NULL

--Running the Self Join query above shows there are no more NULLS

--3. Breaking out address into individual columns (address, city, state)
SELECT PropertyAddress
FROM NashvilleHousing

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)
AS Address
FROM NashvilleHousing

--The above query is starting from the first character of
--PropertyAddress and going until the ,
--However we don't want the comma at the end of the output,
--so we add -1 at the end
--Let's continue building out the query

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)
AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))
AS Address
FROM NashvilleHousing

--Let's create two new columns to split the address out

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress nvarchar(255)

Update NashvilleHousing
SET PropertySplitAddress = 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)


ALTER TABLE NashvilleHousing
ADD PropertySplitCity nvarchar(255)

Update NashvilleHousing
SET PropertySplitCity = 
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))

SELECT*
FROM NashvilleHousing


--Let's split out OwnerAddress
--Instead of substring, let's use PARSENAME
--PARSENAME looks for periods
--We do '3,2,1' because PARSENAME does thing backwards

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
FROM NashvilleHousing

--Let's add the columns and values now
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress nvarchar(255)

Update NashvilleHousing
SET OwnerSplitAddress = 
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity nvarchar(255)

Update NashvilleHousing
SET OwnerSplitCity = 
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState nvarchar(255)

Update NashvilleHousing
SET OwnerSplitState = 
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

--4. Change Y and N to Yes and No in 
--"Sold as vacant" field

SELECT Distinct(SoldAsVacant),
COUNT(SoldAsVacant)
FROM NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

--Use case statement to replace

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant='Y' THEN 'Yes'
WHEN SoldAsVacant='N' THEN 'No'
ELSE SoldAsVacant
END
FROM NashvilleHousing


Update NashvilleHousing
SET SoldAsVacant =
CASE WHEN SoldAsVacant='Y' THEN 'Yes'
WHEN SoldAsVacant='N' THEN 'No'
ELSE SoldAsVacant
END

--5. Remove duplicates
--CTE and windows functions to find duplicates
WITH RowNumCTE AS (
SELECT*, 
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY
					UniqueID
					) row_num
FROM NashvilleHousing
)
--ORDER BY ParcelID 
--In the query below, we had DELETE rather than
--SELECT*, but we changed it back
SELECT*
FROM RowNumCTE
WHERE row_num>1
--Duplicates now removed

--6. Delete unused columns

ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate

SELECT*
FROM NashvilleHousing




