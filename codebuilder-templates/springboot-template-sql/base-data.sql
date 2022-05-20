-- 系统核心功能表数据
use springboot_template;

-- 角色表=========================================================
truncate table tb_role;

insert into tb_role(role_name,role_group,role_info) values('admin','admin','可以管理全部信息的管理员');
insert into tb_role(role_name,role_group,role_info) values('user','user','标准用户');
insert into tb_role(role_name,role_group,role_info) values('app-admin','admin','应用管理员');

-- 用户表=========================================================
truncate table tb_user;

-- 默认管理员数据,密码是admin_pwd,4dc6dceeb03a1e683d7dc66c240243cd
insert into tb_user(username,password,salt,nickname,role,access_key) values('admin','d48dc3be25a60dafc4db503fbc36d397','JX1XRO','内置管理员','admin','ba26b9ea-9c3d-4ffb-bde5-4bee8ba571c3');
-- 默认用户数据，密码是user-pwd,b1493a406bdbfbca2511de3619a71055
insert into tb_user(username,password,salt,nickname,role,access_key) values('user','ffd3935816d6bb5b4a64a3d0f8c61cf1','C3CJXR','内置用户','user','76cb360d-256b-4660-8e13-ab4e3ae9f874');
--  默认应用管理员数据,密码是admin,21232f297a57a5a743894a0e4a801fc3
insert into tb_user(username,password,salt,nickname,role,access_key) values('app-admin','3f7e7f18f394e570dbfe0912b1d69123','WF5QS7','内置应用管理员','app-admin','10875236-27c6-40d7-aaea-876fba9489dd');

-- 接口信息表=========================================================
truncate table tb_actions;

-- 用户管理
insert into tb_actions(url,info,role) values('/admin/user/query','用户管理-查询用户列表','admin');
insert into tb_actions(url,info,role) values('/admin/user/enableUser','用户管理-启用用户','admin');
insert into tb_actions(url,info,role) values('/admin/user/disableUser','用户管理-禁用用户','admin');

-- 用户信息
insert into tb_actions(url,info,role) values('/user/auth/updatePwd','用户管理-禁用用户','user');