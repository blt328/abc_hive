--rdb->hdfs

--机构维度表
sqoop import --connect "jdbc:oracle:thin:@192.168.1.102:1521:orcl" --username "blt" --password "orcl" --query "select * from abc_dim_dept WHERE \$CONDITIONS and 1=1" --null-string '\\N' --null-non-string '\\N'  --target-dir /dm/blt/bsl/abc_dim_dept --fields-terminated-by '\001' --hive-drop-import-delims  --split-by dept_id -m 8 --delete-target-dir

--科目资源配置表
sqoop import --connect "jdbc:oracle:thin:@192.168.1.102:1521:orcl" --username "blt" --password "orcl" --query "select * from abc_rel_subj_reso WHERE \$CONDITIONS and 1=1" --null-string '\\N' --null-non-string '\\N'  --target-dir /dm/blt/bsl/abc_rel_subj_reso --fields-terminated-by '\001' --hive-drop-import-delims  --split-by subj_code -m 8 --delete-target-dir

--ODS财务成本接口表
sqoop import --connect "jdbc:oracle:thin:@192.168.1.102:1521:orcl" --username "blt" --password "orcl" --query "select * from ods_subj_acco WHERE \$CONDITIONS and 1=1 and month_code='201905'" --null-string '\\N' --null-non-string '\\N'  --target-dir /dm/blt/bsl/ods_subj_acco/201905 --fields-terminated-by '\001' --hive-drop-import-delims  --split-by month_code -m 8 --delete-target-dir

