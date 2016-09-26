CREATE VIEW VIEW_USER_INFORMATION 
(
	USER_ID
) 
AS SELECT 
	CAST(uu.USER_ID AS VARCHAR2(100)) 
FROM USERS uu;

-----------------------------------------------------------

CREATE VIEW VIEW_ARE_FRIENDS
(
	USER1_ID
) 
AS SELECT 
	CAST(ff.USER1_ID AS VARCHAR2(100)) 
FROM FRIENDS ff;

-----------------------------------------------------------

CREATE VIEW VIEW_PHOTO_INFORMATION 
(
	PHOTO_ID
) 
AS SELECT 
	pp.PHOTO_ID
FROM PHOTOS pp;

-----------------------------------------------------------

CREATE VIEW VIEW_TAG_INFORMATION 
(
	PHOTO_ID
) 
AS SELECT 
	ta.TAG_PHOTO_ID
FROM TAGS ta;

-----------------------------------------------------------

CREATE VIEW VIEW_EVENT_INFORMATION 
(
	EVENT_ID
) 
AS SELECT 
	CAST(uue.EVENT_ID AS VARCHAR2(100)) 
FROM USER_EVENTS uue;
