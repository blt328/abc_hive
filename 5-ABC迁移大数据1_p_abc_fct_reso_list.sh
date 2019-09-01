#!/bin/bash
source /etc/profile

############################################################
# System Name：abc
# Model  Name：生成资源结果表
# Create Date：2019-09-01
# Description：生成资源结果表
############################################################

######目录变量######
abc_path='/blt/abc/reso/';   #脚本所在的绝对路径
abc_log='/blt/abc/log/';     #脚本所在的日志文件

######参数定义和赋值######
#v_fm_dt=`date -d last-month +%Y-%m`"-01";
#v_to_dt=`date '+%Y-%m'`"-01";
#v_month=`date -d last-month +%Y%m`;
v_cur_dt=`date '+%Y-%m-%d'`;
v_mode_code='100';                            #模型代码
v_fm_dt='2019-05-01';                         #开始日期:$1
v_to_dt='2019-06-01';                         #结束日期:$2
v_month='201905';                             #月份:$3

######日志文件名######
SUCCESS_FILE="${abc_log}SUCCESS${v_cur_dt}.log";
FAILURE_FILE="${abc_log}FAILURE${v_cur_dt}.log";

######程序处理开始######
echo "#开始`date '+%Y-%m-%d %H:%M:%S'`\n";

v_proc_name='ABC迁移大数据1_p_abc_fct_reso_list';
echo "开始${v_proc_name}:`date '+%Y-%m-%d %H:%M:%S'`(${v_fm_dt},${v_to_dt},${v_month}]\n";
  /app/hive-2.0.1/bin/hive -hivevar v_mode_code=${v_mode_code} -hivevar v_fm_dt=${v_fm_dt} -hivevar v_to_dt=${v_to_dt} -hivevar v_month=${v_month} -f "${abc_path}5-ABC迁移大数据1_p_abc_fct_reso_list.hql"&& \
echo "结束${v_proc_name}`date '+%Y-%m-%d %H:%M:%S'`\n"

if [ $? -ne 0 ]; then
  v_log_text="${v_proc_name}结束时间: `date '+%Y-%m-%d %H:%M:%S'`"
  echo -e ${v_log_text} >> ${FAILURE_FILE}
else
  v_log_text="${v_proc_name}结束时间: `date '+%Y-%m-%d %H:%M:%S'`"
  echo -e ${v_log_text} >> ${SUCCESS_FILE}
fi

echo "#结束`date '+%Y-%m-%d %H:%M:%S'`\n";
######程序处理结束#########
