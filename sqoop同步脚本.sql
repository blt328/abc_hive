--hdfs->rdb

sqoop export --connect "jdbc:oracle:thin:@192.168.1.102:1521:orcl" --username "blt" --password "orcl" --table t_abc_dept --columns 'dept_id,dept_code,dept_name,load_tm' --export-dir /dm/fin_abc/bsl/t_abc_dept --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' -m 8




--rdb->hdfs


sqoop import --connect "jdbc:oracle:thin:@192.168.1.102:1521:orcl" --username "blt" --password "orcl" --query "select * from t_abc_dept WHERE \$CONDITIONS and 1=1" --null-string '\\N' --null-non-string '\\N'  --target-dir /dm/fin_abc/bsl/t_abc_dept --fields-terminated-by '\001' --hive-drop-import-delims  --split-by dept_id -m 8 --delete-target-dir



