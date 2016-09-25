set colsep ',' 
set pagesize 0 
set trimspool on 
set headsep off 
set linesize 10000 
spool userinfo.csv 
SELECT * FROM PUBLIC_USER_INFORMATION; 
spool off


