--#####################################################################
--程序说明 
--filename: p_abc_fct_reso_list.hql
--purpose:  生成ABC资源结果表
--author:   blt

--parameters:
--${v_proc_name}:   程序名
--${v_month}:       统计月份 (yyyymm)     
--${v_fm_dt}:       昨天 (yyyymmdd)
--${v_to_dt}:       当日 (yyyymmdd)
--description       生成ABC资源结果表

--history
--date         author           version          modifications
--2019-09-01   blt              v01.00.000       生成ABC资源结果表
--#####################################################################

--#####################################################################
--设置参数
set mapred.job.name=p_abc_fct_reso_list;
set hive.fetch.task.conversion=more;
set hive.cli.print.header=true;
set hive.exec.reducers.max=300;
set hive.exec.compress.output=false;
set hive.exec.compress.intermediate=true;
set mapred.max.split.size=1000000000;
set mapred.min.split.size.per.node=1000000000;
set mapred.min.split.size.per.rack=1000000000;
set hive.auto.convert.join=true;
set hive.groupby.skewindata=true;
set hive.exec.dynamic.partition.mode=nonstrict;

--#####################################################################
use blt;

--#####################################################################
--step1.生成资源结果表
insert overwrite table abc_fct_reso_list partition
  (hq_month_code)
  select a.month_code,
         a.dept_code,
         c.dept_type,
         c.dept_type_name,
         case
           when b.reso_code = 'ZY0301' then
            '1030'
           else
            '5010'
         end func_code,
         case
           when b.reso_code = 'ZY0301' then
            '运输'
           else
            '公共'
         end func_code,
         a.car_no,
         b.reso_code,
         b.reso_name,
         sum(a.amt) amt,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') load_tm,
         '${v_month}' hq_month_code
    from ods_subj_acco a
    left join abc_rel_subj_reso b
      on a.subj_code = b.subj_code
     and to_date(b.fm_dt) <= '${v_fm_dt}'
     and to_date(b.to_dt) >= '${v_fm_dt}'
    left join abc_dim_dept c
      on a.dept_code = c.dept_code
     and to_date(c.fm_tm) <= '${v_fm_dt}'
     and to_date(c.to_tm) >= '${v_fm_dt}'
   where a.month_code = '${v_month}'
   group by a.month_code,
            a.dept_code,
            c.dept_type,
            c.dept_type_name,
            case
              when b.reso_code = 'ZY0301' then
               '1030'
              else
               '5010'
            end,
            case
              when b.reso_code = 'ZY0301' then
               '运输'
              else
               '公共'
            end,
            a.car_no,
            b.reso_code,
            b.reso_name;
--#####################################################################
