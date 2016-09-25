set colsep ',' 
set pagesize 0 
set trimspool on 
set headsep off 
set linesize 10000 

spool PUBLIC_USER_INFORMATION.csv 
SELECT * FROM keykholt.PUBLIC_USER_INFORMATION; 
spool off

spool PUBLIC_ARE_FRIENDS.csv 
SELECT * FROM keykholt.PUBLIC_ARE_FRIENDS; 
spool off

spool PUBLIC_PHOTO_INFORMATION.csv 
SELECT * FROM keykholt.PUBLIC_PHOTO_INFORMATION; 
spool off

spool PUBLIC_TAG_INFORMATION.csv 
SELECT * FROM keykholt.PUBLIC_TAG_INFORMATION; 
spool off

spool PUBLIC_EVENT_INFORMATION.csv 
SELECT * FROM keykholt.PUBLIC_EVENT_INFORMATION; 
spool off

