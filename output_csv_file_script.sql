set colsep ',' --separatecolumns with a comma
set pagesize 0 --No header rows
set trimspool on --removetrailing blanks
set headsep off --this may or may not be useful ... depends on your headings .
set linesize 10000 --linesize should be > sum of the column widths
spool userinfo.csv --output will be spooled to this file
SELECT * FROM PUBLIC_USER_INFORMATION; --type your query here
spool off


