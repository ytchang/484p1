CREATE TABLE USERS
(
	USER_ID 		NUMBER,
	FIRST_NAME 		VARCHAR2(100) NOT NULL, 
	LAST_NAME 		VARCHAR2(100) NOT NULL,
	YEAR_OF_BIRTH 	INTEGER,
	MONTH_OF_BIRTH 	INTEGER,
	DAY_OF_BIRTH 	INTEGER,
	GENDER 			VARCHAR2(100),
	PRIMARY KEY(USER_ID)
);

--------------------------------------------------------------------------------------------------

CREATE TABLE FRIENDS
(
	USER1_ID 		NUMBER,
 	USER2_ID 		NUMBER,
	PRIMARY KEY	(USER1_ID,USER2_ID),
	FOREIGN KEY (USER1_ID) REFERENCES USERS ON DELETE CASCADE,
    FOREIGN KEY (USER2_ID) REFERENCES USERS ON DELETE CASCADE
);

CREATE TRIGGER REPEAT_FRIENDS_CHECK
BEFORE INSERT OR UPDATE ON FRIENDS
FOR EACH ROW
DECLARE
	TEMP VARCHAR2(100);
BEGIN
	IF :NEW.USER1_ID > :NEW.USER2_ID THEN
		TEMP := :NEW.USER1_ID;
		:NEW.USER1_ID := :NEW.USER2_ID;
		:NEW.USER2_ID := TEMP;
	END IF;
END;
/

--------------------------------------------------------------------------------------------------

CREATE TABLE CITIES
(	
	CITY_ID 		INTEGER,
	CITY_NAME 		VARCHAR2(100),
	STATE_NAME 		VARCHAR2(100),
	COUNTRY_NAME 	VARCHAR2(100),
	PRIMARY KEY(CITY_ID)
);

CREATE SEQUENCE CITIES_sequence
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER CITIES_sequence_tirgger
BEFORE INSERT ON CITIES
FOR EACH ROW
BEGIN
  SELECT CITIES_sequence.NEXTVAL
  INTO :NEW.CITY_ID
  FROM DUAL;	-- select from dummy table
END;
/

--------------------------------------------------------------------------------------------------

CREATE TABLE USER_CURRENT_CITY
(
	USER_ID 		NUMBER,
 	CURRENT_CITY_ID INTEGER,
 	PRIMARY KEY	(USER_ID),
 	FOREIGN KEY (USER_ID) 		  REFERENCES USERS  ON DELETE CASCADE,
 	FOREIGN KEY (CURRENT_CITY_ID) REFERENCES CITIES ON DELETE CASCADE
);

--------------------------------------------------------------------------------------------------

CREATE TABLE USER_HOMETOWN_CITY
(
	USER_ID 			NUMBER,
 	HOMWTOWN_CITY_ID 	INTEGER,
 	PRIMARY KEY	(USER_ID),
 	FOREIGN KEY (USER_ID) 		   REFERENCES USERS 	ON DELETE CASCADE,
 	FOREIGN KEY (HOMWTOWN_CITY_ID) REFERENCES CITIES 	ON DELETE CASCADE
);

--------------------------------------------------------------------------------------------------

CREATE TABLE MESSAGE
(
	MESSAGE_ID			INTEGER,
	SENDER_ID			NUMBER  	NOT NULL,
	RECEIVER_ID			NUMBER  	NOT NULL,
	MESSAGE_CONTENT		VARCHAR2(2000),
	SENT_TIME			TIMESTAMP,
	PRIMARY KEY (MESSAGE_ID),
	FOREIGN KEY (SENDER_ID)		REFERENCES USERS 	 ON DELETE CASCADE,
	FOREIGN KEY (RECEIVER_ID)	REFERENCES USERS 	 ON DELETE CASCADE
);

--------------------------------------------------------------------------------------------------	

CREATE TABLE PROGRAMS
(
	PROGRAM_ID			INTEGER,
	INSTITUTION			VARCHAR2(100),
	CONCENTRATION		VARCHAR2(100),
	DEGREE				VARCHAR2(100),
	PRIMARY KEY(PROGRAM_ID)
);

CREATE SEQUENCE PROGRAMS_sequence
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER PROGRAMS_sequence_tirgger
BEFORE INSERT ON PROGRAMS
FOR EACH ROW
BEGIN
  SELECT PROGRAMS_sequence.NEXTVAL
  INTO :NEW.PROGRAM_ID
  FROM DUAL;	-- select from dummy table
END;
/

--------------------------------------------------------------------------------------------------	

CREATE TABLE EDUCATION
(
	USER_ID 			NUMBER,
	PROGRAM_ID			INTEGER,
	PROGRAM_YEAR		INTEGER,
	PRIMARY KEY		(USER_ID,PROGRAM_ID),
	FOREIGN KEY		(USER_ID)		REFERENCES USERS 	ON DELETE CASCADE,
	FOREIGN KEY		(PROGRAM_ID)	REFERENCES PROGRAMS
);

--------------------------------------------------------------------------------------------------	

CREATE TABLE USER_EVENTS
(
	EVENT_ID			NUMBER,
	EVENT_CREATOR_ID	NUMBER,
	EVENT_NAME			VARCHAR2(100),
	EVENT_TAGLINE		VARCHAR2(100),
	EVENT_DESCRIPTION	VARCHAR2(100),
	EVENT_HOST			VARCHAR2(100)	NOT NULL,
	EVENT_TYPE			VARCHAR2(100)	NOT NULL,
	EVENT_SUBTYPE		VARCHAR2(100)	NOT NULL,
	EVENT_LOCATION		VARCHAR2(100),
	EVENT_CITY_ID		INTEGER,
	EVENT_START_TIME	TIMESTAMP 		NOT NULL,
	EVENT_END_TIME		TIMESTAMP 		NOT NULL,
	PRIMARY KEY		(EVENT_ID),
	FOREIGN KEY		(EVENT_CREATOR_ID)		REFERENCES USERS,
	FOREIGN KEY		(EVENT_CITY_ID)			REFERENCES CITIES
);

--------------------------------------------------------------------------------------------------

CREATE TABLE PARTICIPANTS
(
	EVENT_ID 			NUMBER,
	USER_ID 			NUMBER,
	CONFIRMATION		VARCHAR2(100),
	PRIMARY KEY		(EVENT_ID,USER_ID),
	FOREIGN KEY		(EVENT_ID)		REFERENCES USER_EVENTS,
	FOREIGN KEY		(USER_ID)		REFERENCES USERS,
	CONSTRAINT CONFIRMATION_STATUS CHECK
	( 
		(CONFIRMATION = 'attending') 
		OR 
		(CONFIRMATION = 'declined') 
		OR 
		(CONFIRMATION = 'unsure') 
		OR 
		(CONFIRMATION = 'not-replied') 
	)
);

--------------------------------------------------------------------------------------------------

CREATE TABLE ALBUMS
(
	ALBUM_ID 				VARCHAR2(100),
	ALBUM_OWNER_ID 			NUMBER				NOT NULL,
	ALBUM_NAME				VARCHAR2(100)		NOT NULL,
	ALBUM_CREATED_TIME		TIMESTAMP			NOT NULL,
	ALBUM_MODIFIED_TIME		TIMESTAMP			NOT NULL,
	ALBUM_LINK				VARCHAR2(2000)		NOT NULL,
	ALBUM_VISIBILITY		VARCHAR2(100)		NOT NULL,
	COVER_PHOTO_ID			VARCHAR2(100)		NOT NULL,
	PRIMARY KEY		(ALBUM_ID),
	FOREIGN KEY		(ALBUM_OWNER_ID)		REFERENCES USERS 	ON DELETE CASCADE,
	--UNIQUE (ALBUM_LINK),
	CONSTRAINT ALBUM_VISIBILITY_VALUE CHECK
	( 
		(ALBUM_VISIBILITY = 'EVERYONE') 
		OR 
		(ALBUM_VISIBILITY = 'FRIENDS_OF_FRIENDS') 
		OR 
		(ALBUM_VISIBILITY = 'FRIENDS') 
		OR 
		(ALBUM_VISIBILITY = 'MYSELF') 
		OR
		(ALBUM_VISIBILITY = 'CUSTOM') 
	)
);

CREATE TABLE PHOTOS
(
	PHOTO_ID 				VARCHAR2(100),
	ALBUM_ID 				VARCHAR2(100)		NOT NULL,
	PHOTO_CAPTION			VARCHAR2(2000),
	PHOTO_CREATED_TIME		TIMESTAMP			NOT NULL,
	PHOTO_MODIFIED_TIME		TIMESTAMP			NOT NULL,
	PHOTO_LINK				VARCHAR2(2000)		NOT NULL,
	PRIMARY KEY		(PHOTO_ID)
	--UNIQUE (PHOTO_LINK)
	--FOREIGN KEY		(ALBUM_ID)		REFERENCES ALBUMS
);

ALTER TABLE ALBUMS ADD CONSTRAINT ALBUMS_REF_PHOTOS FOREIGN KEY (COVER_PHOTO_ID) REFERENCES PHOTOS(PHOTO_ID)
INITIALLY DEFERRED DEFERRABLE;
ALTER TABLE PHOTOS ADD CONSTRAINT PHOTOS_REF_ALBUMS FOREIGN KEY (ALBUM_ID) 		 REFERENCES ALBUMS(ALBUM_ID)
INITIALLY DEFERRED DEFERRABLE;

--------------------------------------------------------------------------------------------------

CREATE TABLE TAGS
(
	TAG_PHOTO_ID			VARCHAR2(100),
	TAG_SUBJECT_ID			NUMBER,
	TAG_CREATED_TIME		TIMESTAMP			NOT NULL,
	TAG_X					NUMBER				NOT NULL,
	TAG_Y					NUMBER				NOT NULL,
	PRIMARY KEY		(TAG_PHOTO_ID,TAG_SUBJECT_ID),
	FOREIGN KEY		(TAG_PHOTO_ID)		REFERENCES PHOTOS 	ON DELETE CASCADE,
	FOREIGN KEY		(TAG_SUBJECT_ID)	REFERENCES USERS
);

--------------------------------------------------------------------------------------------------


















