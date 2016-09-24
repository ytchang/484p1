CREATE TABLE USERS
(
	USER_ID 		NUMBER,
	FIRST_NAME 		VARCHAR2(100), 
	LAST_NAME 		VARCHAR2(100),
	YEAR_OF_BIRTH 	INTEGER,
	MONTH_OF_BIRTH 	INTEGER,
	DAY_OF_BIRTH 	INTEGER,
	GENDER 			VARCHAR2(100),
	
	PRIMARY KEY(USER_ID)
);


CREATE TABLE FRIENDS
(
	USER1_ID 		NUMBER,
 	USER2_ID 		NUMBER,
	
	PRIMARY KEY(USER1_ID,USER2_ID)
);


CREATE TABLE CITIES
(	
	CITY_ID 		INTEGER,
	CITY_NAME 		VARCHAR2(100);
	STATE_NAME 		VARCHAR2(100);
	COUNTRY_NAME 	VARCHAR2(100);

	PRIMARY KEY(CITY_ID)
)
	

CREATE TABLE USER_CURRENT_CITY
(
	USER_ID 		NUMBER,
 	CURRENT_CITY_ID INTEGER,
 	
 	PRIMARY KEY(USER_ID)
);


CREATE TABLE USER_HOMETOWN_CITY
(
	USER_ID 			NUMBER,
 	HOMWTOWN_CITY_ID 	INTEGER,
 	
 	PRIMARY KEY(USER_ID)
);


CREATE TABLE MESSAGE
(
	MESSAGE_ID			INTEGER,
	SENDER_ID			NUMBER,
	RECEIVER_ID			NUMBER,
	MESSAGE_CONTENT		VARCHAR2(2000),
	SENT_TIME			TIMESTAMP,

	PRIMARY KEY(MESSAGE_ID)
);


CREATE TABLE PROGRAMS
(
	PROGRAM_ID			INTEGER,
	INSTITUTION			VARCHAR2(100),
	CONCENTRATION		VARCHAR2(100),
	DEGREE				VARCHAR2(100),

	PRIMARY KEY(PRIGRAM_ID)
);


CREATE TABLE EDUCATION
(
	USER_ID 			NUMBER,
	PROGRAM_ID			INTEGER,
	PROGRAM_YEAR		INTEGER,

	PRIMARY KEY(USER_ID)
);

CREATE TABLE USER_EVENTS
(
	EVENT_ID			NUMBER,
	EVENT_CREATOR_ID	NUMBER,
	EVENT_NAME			VARCHAR2(100),
	EVENT_TAGLINE		VARCHAR2(100),
	EVENT_DESCRIPTION	VARCHAR2(100),
	EVENT_HOST			VARCHAR2(100),
	EVENT_TYPE			VARCHAR2(100),
	EVENT_SUBTYPE		VARCHAR2(100),
	EVENT_LOCATION		VARCHAR2(100),
	EVENT_CITY_ID		INTEGER,
	EVENT_START_TIME	TIMESTAMP,
	EVENT_END_TIME		TIMESTAMP,

	PRIMARY KEY(EVENT_ID)
);


CREATE TABLE PARTICIPANTS
(
	EVENT_ID 			NUMBER,
	USER_ID 			NUMBER,
	CONFIRMATION		VARCHAR2(100),

	PRIMARY KEY(EVENT_ID)
);


CREATE TABLE ALBUMS
(
	ALBUM_ID 				VARCHAR2(100),
	ALBUM_OWNER_ID 			NUMBER,
	ALBUM_NAME				VARCHAR2(100),
	ALBUM_CREATED_TIME		TIMESTAMP,
	ALBUM_MODIFIED_TIME		TIMESTAMP,
	ALBUM_LINK				VARCHAR2(2000),
	ALBUM_VISIBILITY		VARCHAR2(100),
	COVER_PHOTO_ID			VARCHAR2(100)

	PRIMARY KEY(ALBUM_ID)
);


CREATE TABLE PHOTOS
(
	PHOTO_ID 				VARCHAR2(100),
	ALBUM_ID 				VARCHAR2(100),
	PHOTO_CAPTION			VARCHAR2(2000),
	PHOTO_CREATED_TIME		TIMESTAMP,
	PHOTO_MODIFIED_TIME		TIMESTAMP,
	PHOTO_LINK				VARCHAR2(2000),

	PRIMARY KEY(PHOTO_ID)
);


CREATE TABLE TAGS
(
	TAG_PHOTO_ID			VARCHAR2(100),
	TAG_SUBJECT_ID			NUMBER,
	TAG_CREATED_TIME		TIMESTAMP,
	TAG_X					NUMBER,
	TAG_Y					NUMBER,

	PRIMARY KEY(TAG_PHOTO_ID)
)























