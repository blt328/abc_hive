drop table if exists abc_dim_dept;
create external table abc_dim_dept
(
dept_id                    int    comment '机构id代理键',
dept_code                  string comment '部门代码',
dept_name                  string comment '部门名称',
dept_type                  string comment '网点类型',
dept_type_name             string comment '网点类型名',
fm_tm                      string comment '开始日期',
to_tm                      string comment '结束日期',
level1_code                string comment '层级1代码',
level1_name                string comment '层级1名称',
level2_code                string comment '层级2代码',
level2_name                string comment '层级2名称',
level3_code                string comment '层级3代码',
level3_name                string comment '层级3名称',
level4_code                string comment '层级4代码',
level4_name                string comment '层级4名称',
level5_code                string comment '层级5代码',
level5_name                string comment '层级5名称',
parent_code                string comment '父结点',
city_code                  string comment '城市',
type_level                 int    comment '层级',
load_tm                    string comment '加载时间'
)comment '机构维度表'
row format delimited fields terminated by '\001'
location '/dm/blt/bsl/abc_dim_dept';


drop table if exists abc_rel_subj_reso;
create external table abc_rel_subj_reso
(
fm_dt                     string comment '开始日期',
to_dt                     string comment '结束日期',
subj_code                 string comment '科目代码',
subj_name                 string comment '科目名称',
reso_code                 string comment '资源代码',
reso_name                 string comment '资源名称',
reso_type                 string comment '类型',
load_tm                   string comment '加载时间'
)comment '科目资源配置表'
row format delimited fields terminated by '\001'
location '/dm/blt/bsl/abc_rel_subj_reso';



drop table if exists abc_fct_reso_list;
create external table abc_fct_reso_list
(
month_code              string comment '月份',
dept_code               string comment '机构代码',
dept_type               string comment '机构类型',
dept_type_name          string comment '机构类型名',
func_code               string comment '功能中心代码',
func_name               string comment '功能中心名称',
car_no                  string comment '车牌号',
reso_code               string comment '资源代码',
reso_name               string comment '资源名称',
amt                     double comment '金额',
load_tm                 string comment '加载时间'
)comment 'ABC资源结果表'
PARTITIONED BY  (hq_month_code string)
row format delimited fields terminated by '\001'
location '/dm/blt/bsl/abc_fct_reso_list';



drop table if exists ods_subj_acco;
create external table ods_subj_acco
(
month_code                   string comment '月份',
dept_code                    string comment '机构代码',
subj_code                    string comment '科目代码',
subj_name                    string comment '科目名称',
post_name                    string comment '岗位名',
car_no                       string comment '车牌号',
amt                          double comment '金额',
load_tm                      string comment '加载时间'
)comment 'ODS财务成本接口表'
PARTITIONED BY  (hq_month_code string)
row format delimited fields terminated by '\001'
location '/dm/blt/bsl/ods_subj_acco';

--手动增加分区并指定目录
alter table ods_subj_acco add partition (hq_month_code='201905') location '/dm/blt/bsl/ods_subj_acco/201905';
alter table ods_subj_acco add partition (hq_month_code='201906') location '/dm/blt/bsl/ods_subj_acco/201906';

--删除分区
alter table ods_subj_acco drop partition (hq_month_code='201905');

--删除DFS上的目录
dfs -rm -r -f /dm/blt/bsl/ods_subj_acco/hq_month_code=201905;

