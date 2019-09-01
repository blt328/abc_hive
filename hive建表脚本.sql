--非分区表
drop table if exists t_abc_dept;
create external table t_abc_dept
(
dept_id             int    comment '机构id ', 
dept_code           string comment '机构代码 ', 
dept_name           string comment '机构名称 ', 
city_code           string comment '城市代码 ', 
father_code         string comment '父节点 ', 
dept_type_code      string comment '机构类型 ', 
load_tm             string comment '加载时间 '
)comment '机构表'
row format delimited fields terminated by '\001'
location '/dm/fin_abc/bsl/t_abc_dept';

--分区表
drop table if exists t_abc_subject_amt;
create external table t_abc_subject_amt
(
month_code        string comment '月份',
dept_code         string comment '机构',
subject_code      string comment '科目代码',
subject_name      string comment '科目名',
amt               double comment '金额',
load_tm           string comment '加载时间'
)comment '会计金额表'
PARTITIONED BY  (hq_month_code string)
row format delimited fields terminated by '\001'
location '/dm/fin_abc/bsl/t_abc_subject_amt';
