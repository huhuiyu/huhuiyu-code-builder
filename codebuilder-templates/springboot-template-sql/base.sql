-- 系统核心功能表
use springboot_template;

-- 角色表=========================================================
drop table if exists tb_role;
create table tb_role
(
  role_name varchar(50) primary key not null comment '主键，角色名称',
  role_group varchar(50) not null comment '角色组',
  role_info varchar(200) not null comment '角色描述',
  enable enum('y','n') default 'y' not null comment '是否启用'
)comment '角色信息表';

select * from tb_role;

-- 用户表=========================================================
drop table if exists tb_user;
create table tb_user
(
  uid integer auto_increment primary key not null comment '主键',
  username varchar(20) unique not null comment '登录用户名',
  password varchar(50) not null comment '登录密码',
  salt varchar(20) not null comment '密码盐',
  nickname varchar(50) not null comment '昵称',
  access_key varchar(50) not null default '' comment '用户鉴权key',
  role varchar(200) default '' not null comment '用户角色列表',
  enable enum('y','n') default 'y' not null comment '是否启用',
  lastupdate timestamp default now() not null comment '注册时间'
)comment '用户信息表';

select * from tb_user;

-- 功能权限表=========================================================
drop table if exists tb_actions;
create table tb_actions
(
  aid integer auto_increment primary key comment '主键',
  url varchar(255) unique not null comment 'api的url地址',
  info varchar(200) not null comment 'api描述信息',
  role varchar(200) not null comment '可以访问api的角色列表'
)comment '托管的api地址信息表';

select * from tb_actions;

-- 菜单权限表=========================================================
drop table if exists tb_menus;
create table tb_menus
(
  mid integer auto_increment primary key comment '主键',
  parent integer default -1 not null comment '父级，默认为-1，表示顶级菜单',
  url varchar(255) unique not null comment '菜单的url地址',
  text varchar(255) not null comment '菜单的文本',
  info varchar(255) not null comment '菜单的描述',
  icon varchar(255) default '' not null comment '菜单的图标',
  role varchar(200) default '' not null comment '用户角色列表',
  enable enum('y','n') default 'y' not null comment '是否启用',
  lastupdate timestamp on update now() default now() not null comment '最后更新时间'
)comment '前端菜单地址管理';

select * from tb_menus;

