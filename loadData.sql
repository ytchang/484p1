INSERT INTO USERS
(
	USER_ID, 
	FIRST_NAME, 
	LAST_NAME, 
	YEAR_OF_BIRTH, 
	MONTH_OF_BIRTH, 
	DAY_OF_BIRTH, 
	GENDER
)
SELECT DISTINCT 
	CAST(uu.USER_ID AS NUMBER), 
	uu.FIRST_NAME, uu.LAST_NAME, 
	CAST(uu.YEAR_OF_BIRTH AS INTEGER), 
	CAST(uu.MONTH_OF_BIRTH AS INTEGER), 
	CAST(uu.DAY_OF_BIRTH AS INTEGER), 
	uu.GENDER
FROM 
	PUBLIC_USER_INFORMATION uu;
--keykholt.PUBLIC_USER_INFORMATION uu;
--------------------------------------------------------------------------------------------------

INSERT INTO FRIENDS 
(
	USER1_ID, 
	USER2_ID
)
SELECT DISTINCT 
	CAST(ff.USER1_ID AS NUMBER), 
	CAST(ff.USER2_ID AS NUMBER)
FROM 
	PUBLIC_ARE_FRIENDS ff;
--keykholt.PUBLIC_ARE_FRIENDS ff;
--------------------------------------------------------------------------------------------------

INSERT INTO CITIES
(
	CITY_NAME,
	STATE_NAME,
	COUNTRY_NAME
)
SELECT DISTINCT 
	CITY_NAME, 
	STATE_NAME, 
	COUNTRY_NAME
FROM 
(
	SELECT DISTINCT HOMETOWN_CITY as CITY_NAME, HOMETOWN_STATE as STATE_NAME, HOMETOWN_COUNTRY as COUNTRY_NAME
	FROM keykholt.PUBLIC_USER_INFORMATION
	UNION 
	SELECT DISTINCT CURRENT_CITY as CITY_NAME, HOMETOWN_STATE as STATE_NAME, HOMETOWN_COUNTRY as COUNTRY_NAME
	FROM keykholt.PUBLIC_USER_INFORMATION
	UNION 
	SELECT DISTINCT EVENT_CITY as CITY_NAME, EVENT_STATE as STATE_NAME, EVENT_COUNTRY as COUNTRY_NAME
	FROM keykholt.PUBLIC_EVENT_INFORMATION
);

--------------------------------------------------------------------------------------------------

INSERT INTO USER_CURRENT_CITY
(
	USER_ID,
	CURRENT_CITY_ID
)
SELECT DISTINCT 
	CAST(uu.USER_ID AS NUMBER), 
	cc.CITY_ID
FROM 
	keykholt.PUBLIC_USER_INFORMATION uu, 
	CITIES cc
WHERE
(
	uu.CURRENT_CITY 	= cc.CITY_NAME 
	AND
	uu.CURRENT_STATE 	= cc.STATE_NAME
	AND
	uu.CURRENT_COUNTRY 	= cc.COUNTRY_NAME
);

--------------------------------------------------------------------------------------------------

INSERT INTO USER_HOMETOWN_CITY
(
	USER_ID,
	HOMWTOWN_CITY_ID
)
SELECT DISTINCT 
	CAST(uu.USER_ID AS NUMBER),
	cc.CITY_ID
FROM 
	keykholt.PUBLIC_USER_INFORMATION uu, 
	CITIES cc
WHERE
(
	uu.HOMETOWN_CITY 	= cc.CITY_NAME 
	AND
	uu.HOMETOWN_STATE 	= cc.STATE_NAME
	AND
	uu.HOMETOWN_COUNTRY = cc.COUNTRY_NAME
);

--------------------------------------------------------------------------------------------------

--MESSAGE

--------------------------------------------------------------------------------------------------	

INSERT INTO PROGRAMS
(
	INSTITUTION,
	CONCENTRATION,DEGREE
)
SELECT DISTINCT 
	uu.INSTITUTION_NAME, 
	CAST(uu.PROGRAM_CONCENTRATION AS VARCHAR2(100)),
	uu.PROGRAM_DEGREE
FROM 
	keykholt.PUBLIC_USER_INFORMATION uu;

--------------------------------------------------------------------------------------------------

INSERT INTO EDUCATION
(
	USER_ID,PROGRAM_ID,
	PROGRAM_YEAR
)
SELECT DISTINCT 
	CAST(uu.USER_ID AS NUMBER), 
	pp.PROGRAM_ID, 
	CAST(uu.PROGRAM_YEAR AS NUMBER)
FROM 
	keykholt.PUBLIC_USER_INFORMATION uu, 
	PROGRAMS pp
WHERE
(
	uu.INSTITUTION_NAME = pp.INSTITUTION
	AND
	CAST(uu.PROGRAM_CONCENTRATION AS VARCHAR2(100)) = pp.CONCENTRATION
	AND
	uu.PROGRAM_DEGREE = pp.DEGREE
);

--------------------------------------------------------------------------------------------------

INSERT INTO USER_EVENTS
(
	EVENT_ID,
	EVENT_CREATOR_ID,
	EVENT_NAME,
	EVENT_TAGLINE,
	EVENT_DESCRIPTION,
	EVENT_HOST,
	EVENT_TYPE,
	EVENT_SUBTYPE,
	EVENT_LOCATION,
	EVENT_CITY_ID,
	EVENT_START_TIME,
	EVENT_END_TIME
)
SELECT DISTINCT
	CAST(eei.EVENT_ID 			AS NUMBER),
	CAST(eei.EVENT_CREATOR_ID 	AS NUMBER),
	eei.EVENT_NAME,
	eei.EVENT_TAGLINE,
	eei.EVENT_DESCRIPTION,
	eei.EVENT_HOST,
	eei.EVENT_TYPE,
	eei.EVENT_SUBTYPE,
	eei.EVENT_LOCATION,
	cc.CITY_ID,
	CAST(eei.EVENT_START_TIME 	AS TIMESTAMP),
	CAST(eei.EVENT_END_TIME 	AS TIMESTAMP)
FROM 
	keykholt.PUBLIC_EVENT_INFORMATION eei
LEFT JOIN CITIES cc ON
(
	eei.EVENT_CITY 		= cc.CITY_NAME 
	AND
	eei.EVENT_STATE 	= cc.STATE_NAME 
	AND
	eei.EVENT_COUNTRY 	= cc.COUNTRY_NAME 
);

--------------------------------------------------------------------------------------------------

--PARTICIPANTS

--------------------------------------------------------------------------------------------------

SET AUTOCOMMIT OFF

INSERT INTO ALBUMS 
(
	ALBUM_ID, 
	ALBUM_OWNER_ID, 
	ALBUM_NAME, 
	ALBUM_CREATED_TIME, 
	ALBUM_MODIFIED_TIME, 
	ALBUM_LINK, 
	ALBUM_VISIBILITY, 
	COVER_PHOTO_ID
)
SELECT DISTINCT
	ppi.ALBUM_ID,
	CAST(ppi.OWNER_ID AS NUMBER),
	ppi.ALBUM_NAME,
	CAST(ppi.ALBUM_CREATED_TIME AS TIMESTAMP),
	CAST(ppi.ALBUM_MODIFIED_TIME AS TIMESTAMP),
	ppi.ALBUM_LINK,
	ppi.ALBUM_VISIBILITY,
	ppi.COVER_PHOTO_ID
FROM
	keykholt.PUBLIC_PHOTO_INFORMATION ppi;

INSERT INTO PHOTOS 
(
	PHOTO_ID, 
	ALBUM_ID, 
	PHOTO_CAPTION, 
	PHOTO_CREATED_TIME, 
	PHOTO_MODIFIED_TIME, 
	PHOTO_LINK
)
SELECT DISTINCT
	ppi.PHOTO_ID,
	ppi.ALBUM_ID,
	ppi.PHOTO_CAPTION,
	CAST(ppi.PHOTO_CREATED_TIME 	AS TIMESTAMP),
	CAST(ppi.PHOTO_MODIFIED_TIME 	AS TIMESTAMP),
	ppi.PHOTO_LINK
FROM
	keykholt.PUBLIC_PHOTO_INFORMATION ppi;

COMMIT
SET AUTOCOMMIT ON

--------------------------------------------------------------------------------------------------

INSERT INTO TAGS
(
	TAG_PHOTO_ID,
	TAG_SUBJECT_ID,
	TAG_CREATED_TIME,
	TAG_X,
	TAG_Y
)
SELECT DISTINCT
	tti.PHOTO_ID, 
	CAST(tti.TAG_SUBJECT_ID AS NUMBER), 
	CAST(tti.TAG_CREATED_TIME AS TIMESTAMP), 
	CAST(tti.TAG_X_COORDINATE AS NUMBER), 
	CAST(tti.TAG_Y_COORDINATE AS NUMBER)
FROM
	keykholt.PUBLIC_TAG_INFORMATION tti;

--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------
-- TEST ZONE--

--------------------------------------------------------------------------------------------------




