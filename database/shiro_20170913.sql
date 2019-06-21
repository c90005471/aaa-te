/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50152
Source Host           : localhost:3306
Source Database       : shiro

Target Server Type    : MYSQL
Target Server Version : 50152
File Encoding         : 65001

Date: 2017-09-13 11:44:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `course`
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(19) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `course_code` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '科目代码，例如html',
  `course_name` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '科目名称，例如html为超文本标记语言',
  `pid` int(19) DEFAULT NULL,
  `seq` int(4) DEFAULT NULL COMMENT '序号',
  `status` tinyint(2) DEFAULT NULL COMMENT '图标',
  `icon` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图标',
  `course_type` tinyint(2) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `orgId` bigint(19) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orgId` (`orgId`) USING BTREE,
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`orgId`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', 'JCLX', '计算机基础', '0', '0', '0', 'fi-foundation icon-blue', '0', '2017-09-11 20:52:10', '7');
INSERT INTO `course` VALUES ('2', 'HTML', 'HTML基础', '0', '0', '0', 'fi-foundation icon-blue', '0', '2017-09-11 20:57:25', '6');
INSERT INTO `course` VALUES ('3', 'HTML-1', 'HTML基础第一章', '2', '1', '0', 'fi-foundation icon-blue', '0', '2017-09-12 00:45:27', '6');
INSERT INTO `course` VALUES ('4', 'HTML-2', 'HTML基础第二章', '2', '2', '0', 'fi-foundation icon-blue', '0', '2017-09-12 00:46:20', '6');
INSERT INTO `course` VALUES ('5', 'HTML-1-1', 'HTML基础第一章基本标签', '3', '0', '0', 'fi-foundation icon-blue', '1', '2017-09-12 00:50:48', '6');
INSERT INTO `course` VALUES ('6', 'HTML-1-2', 'HTML基础第一章基本表单', '3', '0', '0', 'fi-foundation icon-blue', '1', '2017-09-12 00:52:31', '6');
INSERT INTO `course` VALUES ('7', 'JCLX-1', '计算机基础第一章', '1', '0', '0', 'fi-foundation icon-blue', '0', '2017-09-12 14:40:11', '7');
INSERT INTO `course` VALUES ('8', 'JCLX-2', '计算机基础第二章', '1', '1', '0', 'fi-foundation icon-blue', '0', '2017-09-12 14:48:04', '7');

-- ----------------------------
-- Table structure for `course_bak`
-- ----------------------------
DROP TABLE IF EXISTS `course_bak`;
CREATE TABLE `course_bak` (
  `id` int(19) NOT NULL DEFAULT '0' COMMENT '主键自增',
  `course_code` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '科目代码，例如html',
  `course_name` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '科目名称，例如html为超文本标记语言',
  `pid` int(19) DEFAULT NULL,
  `seq` int(4) DEFAULT NULL COMMENT '序号',
  `status` tinyint(2) DEFAULT NULL COMMENT '图标',
  `icon` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图标',
  `course_type` tinyint(2) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `orgId` bigint(19) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of course_bak
-- ----------------------------
INSERT INTO `course_bak` VALUES ('1', 'JCLX', '计算机基础', '0', '100', '0', 'fi-page-multiple icon-blue', '0', '2017-09-11 20:52:10', '6');
INSERT INTO `course_bak` VALUES ('2', 'HTML', 'HTML基础', '0', '200', '0', 'fi-page-multiple icon-blue', '0', '2017-09-11 20:57:25', '6');
INSERT INTO `course_bak` VALUES ('3', 'HTML-1', 'HTML基础第一章', '2', '1', '0', 'fi-foundation icon-blue', '0', '2017-09-12 00:45:27', null);
INSERT INTO `course_bak` VALUES ('4', 'HTML-2', 'HTML基础第二章', '2', '2', '0', 'fi-foundation icon-blue', '0', '2017-09-12 00:46:20', null);
INSERT INTO `course_bak` VALUES ('5', 'HTML-1-1', 'HTML基础第一章基本标签', '3', '0', '0', 'fi-sheriff-badge icon-blue', '1', '2017-09-12 00:50:48', null);
INSERT INTO `course_bak` VALUES ('6', 'HTML-1-2', 'HTML基础第一章基本表单', '3', '1', '0', 'fi-sheriff-badge icon-blue', '1', '2017-09-12 00:52:31', null);
INSERT INTO `course_bak` VALUES ('7', 'JCLX-1', '计算机基础第一章', '1', '0', '0', 'fi-foundation icon-blue', '0', '2017-09-12 14:40:11', null);
INSERT INTO `course_bak` VALUES ('8', 'JCLX-2', '计算机基础第二章', '1', '1', '0', 'fi-foundation icon-blue', '0', '2017-09-12 14:48:04', null);

-- ----------------------------
-- Table structure for `organization`
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) NOT NULL COMMENT '组织名',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `code` varchar(64) NOT NULL COMMENT '编号',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标',
  `pid` bigint(19) DEFAULT NULL COMMENT '父级主键',
  `seq` tinyint(2) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='组织机构';

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES ('1', '政通路校区', '郑州市二七区政通路', '01', 'fi-die-one', null, '0', '2014-02-19 01:00:00');
INSERT INTO `organization` VALUES ('3', '杨金路校区', '郑州市金水区牛顿国际', '02', 'fi-die-two', null, '1', '2015-10-01 13:10:42');
INSERT INTO `organization` VALUES ('5', '新乡校区', '新乡市', '03', 'fi-die-three', '5', '1', '2015-12-06 12:15:30');
INSERT INTO `organization` VALUES ('6', 'java专业', '', '04', 'fi-social-stumbleupon icon-red', '3', '0', '2015-12-06 13:12:18');
INSERT INTO `organization` VALUES ('7', 'java专业', '', '55', 'fi-social-stumbleupon icon-red', '1', '3', '2017-09-03 15:58:50');
INSERT INTO `organization` VALUES ('8', '开封校区', '开封市', '56', 'fi-die-four', null, '3', '2017-09-09 15:46:16');
INSERT INTO `organization` VALUES ('9', 'java专业', '', '57', 'fi-social-stumbleupon icon-red', '5', '0', '2017-09-09 15:48:39');
INSERT INTO `organization` VALUES ('10', 'java专业', '', '67', 'fi-social-stumbleupon icon-red', '8', '0', '2017-09-09 15:49:22');
INSERT INTO `organization` VALUES ('11', '大数据专业', '', '70', 'fi-social-windows icon-red', '3', '1', '2017-09-12 09:12:47');

-- ----------------------------
-- Table structure for `resource`
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '资源名称',
  `url` varchar(100) DEFAULT NULL COMMENT '资源路径',
  `open_mode` varchar(32) DEFAULT NULL COMMENT '打开方式 ajax,iframe',
  `description` varchar(255) DEFAULT NULL COMMENT '资源介绍',
  `icon` varchar(32) DEFAULT NULL COMMENT '资源图标',
  `pid` bigint(19) DEFAULT NULL COMMENT '父级资源id',
  `seq` tinyint(2) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `opened` tinyint(2) NOT NULL DEFAULT '1' COMMENT '打开状态',
  `resource_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '资源类别',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8 COMMENT='资源';

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('1', '权限管理', '', '', '系统管理', 'fi-wrench icon-red', null, '0', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('11', '资源管理', '/resource/manager', 'ajax', '资源管理', 'fi-database icon-red', '1', '1', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('12', '角色管理', '/role/manager', 'ajax', '角色管理', 'fi-torso-business  icon-red', '1', '2', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('13', '用户管理', '/user/manager', 'ajax', '用户管理', 'fi-torsos-all icon-red', '1', '3', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('14', '部门管理', '/organization/manager', 'ajax', '部门管理', 'fi-social-joomla icon-red', '1', '4', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('111', '列表', '/resource/treeGrid', 'ajax', '资源列表', 'fi-list', '11', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('112', '添加', '/resource/add', 'ajax', '资源添加', 'fi-page-add', '11', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('113', '编辑', '/resource/edit', 'ajax', '资源编辑', 'fi-page-edit', '11', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('114', '删除', '/resource/delete', 'ajax', '资源删除', 'fi-page-delete', '11', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('121', '列表', '/role/dataGrid', 'ajax', '角色列表', 'fi-list', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('122', '添加', '/role/add', 'ajax', '角色添加', 'fi-page-add', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('123', '编辑', '/role/edit', 'ajax', '角色编辑', 'fi-page-edit', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('124', '删除', '/role/delete', 'ajax', '角色删除', 'fi-page-delete', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('125', '授权', '/role/grant', 'ajax', '角色授权', 'fi-check', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('131', '列表', '/user/dataGrid', 'ajax', '用户列表', 'fi-list', '13', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('132', '添加', '/user/add', 'ajax', '用户添加', 'fi-page-add', '13', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('133', '编辑', '/user/edit', 'ajax', '用户编辑', 'fi-page-edit', '13', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('134', '删除', '/user/delete', 'ajax', '用户删除', 'fi-page-delete', '13', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('141', '列表', '/organization/treeGrid', 'ajax', '用户列表', 'fi-list', '14', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('142', '添加', '/organization/add', 'ajax', '部门添加', 'fi-page-add', '14', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('143', '编辑', '/organization/edit', 'ajax', '部门编辑', 'fi-page-edit', '14', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('144', '删除', '/organization/delete', 'ajax', '部门删除', 'fi-page-delete', '14', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('221', '日志监控', '', null, null, 'fi-folder', null, '3', '0', '0', '0', '2015-12-01 11:44:20');
INSERT INTO `resource` VALUES ('226', '修改密码', '/user/editPwdPage', 'ajax', null, 'fi-unlock', null, '4', '0', '1', '1', '2015-12-07 20:23:06');
INSERT INTO `resource` VALUES ('227', '登录日志', '/sysLog/manager', 'ajax', null, 'fi-info', '221', '0', '0', '1', '0', '2016-09-30 22:10:53');
INSERT INTO `resource` VALUES ('228', 'Druid监控', '/druid', 'iframe', null, 'fi-monitor', '221', '0', '0', '1', '0', '2016-09-30 22:12:50');
INSERT INTO `resource` VALUES ('229', '系统图标', '/icons.html', 'ajax', null, 'fi-photo', '221', '0', '0', '1', '0', '2016-12-24 15:53:47');
INSERT INTO `resource` VALUES ('230', '新闻管理', '', 'ajax', null, 'fi-page-multiple', null, '1', '0', '0', '0', '2016-12-24 15:53:47');
INSERT INTO `resource` VALUES ('231', '新建文章', '/article/create', 'ajax', null, 'fi-page-edit', '230', '0', '0', '1', '0', '2016-12-24 15:53:47');
INSERT INTO `resource` VALUES ('232', '学生管理', '/stu/manager', '', null, 'fi-torsos-all icon-red', null, '0', '0', '1', '0', '2017-09-09 16:42:41');
INSERT INTO `resource` VALUES ('233', '学生管理', '/stu/manager', 'ajax', null, 'fi-torsos-all icon-red', '232', '0', '0', '1', '0', '2017-09-09 16:44:36');
INSERT INTO `resource` VALUES ('235', '课程管理', '', '', null, 'fi-book icon-blue', null, '0', '0', '1', '0', '2017-09-11 14:36:05');
INSERT INTO `resource` VALUES ('236', '课表管理', '/course/manager', 'ajax', null, 'fi-book-bookmark icon-blue', '235', '0', '0', '1', '0', '2017-09-11 14:37:54');
INSERT INTO `resource` VALUES ('237', '列表', '/course/dataGrid', 'ajax', null, 'fi-list', '236', '0', '0', '1', '1', '2017-09-11 15:50:46');
INSERT INTO `resource` VALUES ('238', '编辑', '/course/edit', 'ajax', null, 'fi-page-edit', '236', '1', '0', '1', '1', '2017-09-12 01:00:43');
INSERT INTO `resource` VALUES ('239', '删除', '/course/delete', 'ajax', null, 'fi-page-delete', '236', '3', '0', '1', '1', '2017-09-12 01:08:05');
INSERT INTO `resource` VALUES ('240', '添加', '/course/add', 'ajax', null, 'fi-page-add', '236', '-1', '0', '1', '1', '2017-09-12 10:05:50');
INSERT INTO `resource` VALUES ('241', '教评管理', '/te/manager', 'ajax', null, 'fi-ticket icon-purple', null, '0', '0', '1', '0', '2017-09-13 10:37:59');
INSERT INTO `resource` VALUES ('242', '评价老师', '/te/teacher', 'ajax', null, 'fi-like icon-purple', '241', '0', '0', '1', '0', '2017-09-13 10:41:08');
INSERT INTO `resource` VALUES ('243', '学生自评', '/te/student', 'ajax', null, 'fi-dislike icon-purple', '241', '1', '0', '1', '0', '2017-09-13 10:44:54');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) NOT NULL COMMENT '角色名',
  `seq` tinyint(2) NOT NULL DEFAULT '0' COMMENT '排序号',
  `description` varchar(255) DEFAULT NULL COMMENT '简介',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin', '0', '超级管理员', '0');
INSERT INTO `role` VALUES ('2', 'de', '0', '技术部经理', '0');
INSERT INTO `role` VALUES ('7', 'pm', '0', '产品部经理', '0');
INSERT INTO `role` VALUES ('8', 'test', '0', '测试账户', '0');

-- ----------------------------
-- Table structure for `role_resource`
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` bigint(19) NOT NULL COMMENT '角色id',
  `resource_id` bigint(19) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`id`),
  KEY `idx_role_resource_ids` (`role_id`,`resource_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=701 DEFAULT CHARSET=utf8 COMMENT='角色资源';

-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES ('664', '1', '1');
INSERT INTO `role_resource` VALUES ('665', '1', '11');
INSERT INTO `role_resource` VALUES ('670', '1', '12');
INSERT INTO `role_resource` VALUES ('676', '1', '13');
INSERT INTO `role_resource` VALUES ('681', '1', '14');
INSERT INTO `role_resource` VALUES ('666', '1', '111');
INSERT INTO `role_resource` VALUES ('667', '1', '112');
INSERT INTO `role_resource` VALUES ('668', '1', '113');
INSERT INTO `role_resource` VALUES ('669', '1', '114');
INSERT INTO `role_resource` VALUES ('671', '1', '121');
INSERT INTO `role_resource` VALUES ('672', '1', '122');
INSERT INTO `role_resource` VALUES ('673', '1', '123');
INSERT INTO `role_resource` VALUES ('674', '1', '124');
INSERT INTO `role_resource` VALUES ('675', '1', '125');
INSERT INTO `role_resource` VALUES ('677', '1', '131');
INSERT INTO `role_resource` VALUES ('678', '1', '132');
INSERT INTO `role_resource` VALUES ('679', '1', '133');
INSERT INTO `role_resource` VALUES ('680', '1', '134');
INSERT INTO `role_resource` VALUES ('682', '1', '141');
INSERT INTO `role_resource` VALUES ('683', '1', '142');
INSERT INTO `role_resource` VALUES ('684', '1', '143');
INSERT INTO `role_resource` VALUES ('685', '1', '144');
INSERT INTO `role_resource` VALUES ('696', '1', '221');
INSERT INTO `role_resource` VALUES ('700', '1', '226');
INSERT INTO `role_resource` VALUES ('697', '1', '227');
INSERT INTO `role_resource` VALUES ('698', '1', '228');
INSERT INTO `role_resource` VALUES ('699', '1', '229');
INSERT INTO `role_resource` VALUES ('694', '1', '230');
INSERT INTO `role_resource` VALUES ('695', '1', '231');
INSERT INTO `role_resource` VALUES ('686', '1', '232');
INSERT INTO `role_resource` VALUES ('687', '1', '233');
INSERT INTO `role_resource` VALUES ('688', '1', '235');
INSERT INTO `role_resource` VALUES ('689', '1', '236');
INSERT INTO `role_resource` VALUES ('691', '1', '237');
INSERT INTO `role_resource` VALUES ('692', '1', '238');
INSERT INTO `role_resource` VALUES ('693', '1', '239');
INSERT INTO `role_resource` VALUES ('690', '1', '240');
INSERT INTO `role_resource` VALUES ('437', '2', '1');
INSERT INTO `role_resource` VALUES ('438', '2', '13');
INSERT INTO `role_resource` VALUES ('439', '2', '131');
INSERT INTO `role_resource` VALUES ('440', '2', '132');
INSERT INTO `role_resource` VALUES ('441', '2', '133');
INSERT INTO `role_resource` VALUES ('445', '2', '221');
INSERT INTO `role_resource` VALUES ('446', '2', '227');
INSERT INTO `role_resource` VALUES ('447', '2', '228');
INSERT INTO `role_resource` VALUES ('158', '3', '1');
INSERT INTO `role_resource` VALUES ('159', '3', '11');
INSERT INTO `role_resource` VALUES ('170', '3', '13');
INSERT INTO `role_resource` VALUES ('175', '3', '14');
INSERT INTO `role_resource` VALUES ('160', '3', '111');
INSERT INTO `role_resource` VALUES ('161', '3', '112');
INSERT INTO `role_resource` VALUES ('162', '3', '113');
INSERT INTO `role_resource` VALUES ('163', '3', '114');
INSERT INTO `role_resource` VALUES ('165', '3', '121');
INSERT INTO `role_resource` VALUES ('166', '3', '122');
INSERT INTO `role_resource` VALUES ('167', '3', '123');
INSERT INTO `role_resource` VALUES ('168', '3', '124');
INSERT INTO `role_resource` VALUES ('169', '3', '125');
INSERT INTO `role_resource` VALUES ('171', '3', '131');
INSERT INTO `role_resource` VALUES ('172', '3', '132');
INSERT INTO `role_resource` VALUES ('173', '3', '133');
INSERT INTO `role_resource` VALUES ('174', '3', '134');
INSERT INTO `role_resource` VALUES ('176', '3', '141');
INSERT INTO `role_resource` VALUES ('177', '3', '142');
INSERT INTO `role_resource` VALUES ('178', '3', '143');
INSERT INTO `role_resource` VALUES ('179', '3', '144');
INSERT INTO `role_resource` VALUES ('359', '7', '1');
INSERT INTO `role_resource` VALUES ('360', '7', '14');
INSERT INTO `role_resource` VALUES ('361', '7', '141');
INSERT INTO `role_resource` VALUES ('362', '7', '142');
INSERT INTO `role_resource` VALUES ('363', '7', '143');
INSERT INTO `role_resource` VALUES ('367', '7', '221');
INSERT INTO `role_resource` VALUES ('368', '7', '226');
INSERT INTO `role_resource` VALUES ('448', '8', '1');
INSERT INTO `role_resource` VALUES ('449', '8', '11');
INSERT INTO `role_resource` VALUES ('453', '8', '13');
INSERT INTO `role_resource` VALUES ('455', '8', '14');
INSERT INTO `role_resource` VALUES ('450', '8', '111');
INSERT INTO `role_resource` VALUES ('452', '8', '121');
INSERT INTO `role_resource` VALUES ('454', '8', '131');
INSERT INTO `role_resource` VALUES ('456', '8', '141');
INSERT INTO `role_resource` VALUES ('460', '8', '221');
INSERT INTO `role_resource` VALUES ('461', '8', '227');
INSERT INTO `role_resource` VALUES ('462', '8', '228');
INSERT INTO `role_resource` VALUES ('478', '8', '229');
INSERT INTO `role_resource` VALUES ('479', '8', '230');
INSERT INTO `role_resource` VALUES ('480', '8', '231');

-- ----------------------------
-- Table structure for `sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `login_name` varchar(255) DEFAULT NULL COMMENT '登陆名',
  `role_name` varchar(255) DEFAULT NULL COMMENT '角色名',
  `opt_content` varchar(1024) DEFAULT NULL COMMENT '内容',
  `client_ip` varchar(255) DEFAULT NULL COMMENT '客户端ip',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=768 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('391', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.CommonsController,[方法]:ueditor,[参数]:action=config&noCache=1504411840385&', '127.0.0.1', '2017-09-03 12:10:40');
INSERT INTO `sys_log` VALUES ('392', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.UserController,[方法]:addPage,[参数]:', null, '2017-09-03 15:01:40');
INSERT INTO `sys_log` VALUES ('393', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.UserController,[方法]:addPage,[参数]:', null, '2017-09-03 15:02:00');
INSERT INTO `sys_log` VALUES ('394', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.CommonsController,[方法]:ueditor,[参数]:action=config&noCache=1504422149623&', '127.0.0.1', '2017-09-03 15:02:29');
INSERT INTO `sys_log` VALUES ('395', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.ResourceController,[方法]:editPage,[参数]:id=227&_=1504422070754&', '127.0.0.1', '2017-09-03 15:14:23');
INSERT INTO `sys_log` VALUES ('396', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1504425265381&', '127.0.0.1', '2017-09-03 15:54:31');
INSERT INTO `sys_log` VALUES ('397', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.RoleController,[方法]:editPage,[参数]:id=2&_=1504425265382&', '127.0.0.1', '2017-09-03 15:54:46');
INSERT INTO `sys_log` VALUES ('398', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.RoleController,[方法]:editPage,[参数]:id=2&_=1504425265383&', '127.0.0.1', '2017-09-03 15:54:52');
INSERT INTO `sys_log` VALUES ('399', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-03 15:58:02');
INSERT INTO `sys_log` VALUES ('400', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.OrganizationController,[方法]:add,[参数]:code=55&name=学术部&seq=3&icon=fi-folder&address=&pid=1&', '127.0.0.1', '2017-09-03 15:58:50');
INSERT INTO `sys_log` VALUES ('401', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.OrganizationController,[方法]:editPage,[参数]:id=6&_=1504425265387&', '127.0.0.1', '2017-09-03 15:59:05');
INSERT INTO `sys_log` VALUES ('402', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.OrganizationController,[方法]:editPage,[参数]:id=7&_=1504425265388&', '127.0.0.1', '2017-09-03 15:59:14');
INSERT INTO `sys_log` VALUES ('403', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.OrganizationController,[方法]:editPage,[参数]:id=7&_=1504425265391&', '127.0.0.1', '2017-09-03 16:00:14');
INSERT INTO `sys_log` VALUES ('404', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.OrganizationController,[方法]:edit,[参数]:id=7&code=55&name=学术部&seq=3&icon=fi-torsos-all icon-blue&address=&pid=1&', '127.0.0.1', '2017-09-03 16:00:18');
INSERT INTO `sys_log` VALUES ('405', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.UserController,[方法]:addPage,[参数]:', null, '2017-09-03 16:01:52');
INSERT INTO `sys_log` VALUES ('406', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.UserController,[方法]:add,[参数]:loginName=chenjian&name=陈建&password=admin&sex=0&age=23&userType=1&organizationId=7&roleIds=8&phone=648731658315&status=0&', '127.0.0.1', '2017-09-03 16:02:31');
INSERT INTO `sys_log` VALUES ('407', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.OrganizationController,[方法]:editPage,[参数]:id=7&_=1504834460816&', '127.0.0.1', '2017-09-08 09:34:52');
INSERT INTO `sys_log` VALUES ('408', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.OrganizationController,[方法]:edit,[参数]:id=7&code=55&name=学术部&seq=3&icon=fi-torsos-all icon-blue&address=二七区政通路&pid=1&', '127.0.0.1', '2017-09-08 09:35:05');
INSERT INTO `sys_log` VALUES ('409', 'admin', 'admin', '[类名]:com.wangzhixuan.controller.UserController,[方法]:addPage,[参数]:', null, '2017-09-08 11:48:51');
INSERT INTO `sys_log` VALUES ('410', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=222&_=1504911727034&', '127.0.0.1', '2017-09-09 07:03:15');
INSERT INTO `sys_log` VALUES ('411', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=222&name=视频教程&resourceType=0&url=&openMode=&icon=fi-folder&seq=2&status=0&opened=0&pid=230&', '127.0.0.1', '2017-09-09 07:03:27');
INSERT INTO `sys_log` VALUES ('412', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=1&_=1504912074446&', '127.0.0.1', '2017-09-09 07:09:22');
INSERT INTO `sys_log` VALUES ('413', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=1&name=权限管理&resourceType=0&url=&openMode=&icon=fi-wrench icon-green&seq=0&status=0&opened=1&pid=&', '127.0.0.1', '2017-09-09 07:09:29');
INSERT INTO `sys_log` VALUES ('414', 'admin', 'admin', '[类名]:com.aaa.controller.UserController,[方法]:editPage,[参数]:id=1&_=1504924628329&', '127.0.0.1', '2017-09-09 11:02:20');
INSERT INTO `sys_log` VALUES ('415', 'admin', 'admin', '[类名]:com.aaa.controller.UserController,[方法]:edit,[参数]:id=1&loginName=admin&name=admin&password=tiger&sex=0&age=25&userType=0&organizationId=1&roleIds=1&phone=18707173376&status=0&', '127.0.0.1', '2017-09-09 11:02:31');
INSERT INTO `sys_log` VALUES ('416', 'admin', 'admin', '[类名]:com.aaa.controller.LoginController,[方法]:logout,[参数]:', null, '2017-09-09 11:02:45');
INSERT INTO `sys_log` VALUES ('417', 'admin', 'admin', '[类名]:com.aaa.controller.CommonsController,[方法]:ueditor,[参数]:action=config&noCache=1504926201341&', '127.0.0.1', '2017-09-09 11:03:21');
INSERT INTO `sys_log` VALUES ('418', 'admin', 'admin', '[类名]:com.aaa.controller.CommonsController,[方法]:ueditor,[参数]:action=listimage&start=0&size=20&noCache=1504926245094&', '127.0.0.1', '2017-09-09 11:04:05');
INSERT INTO `sys_log` VALUES ('419', 'admin', 'admin', '[类名]:com.aaa.controller.UserController,[方法]:editPwdPage,[参数]:', null, '2017-09-09 11:45:40');
INSERT INTO `sys_log` VALUES ('420', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=111&_=1504938762589&', '127.0.0.1', '2017-09-09 14:33:37');
INSERT INTO `sys_log` VALUES ('421', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:delete,[参数]:id=222&', '127.0.0.1', '2017-09-09 15:02:24');
INSERT INTO `sys_log` VALUES ('422', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:delete,[参数]:id=223&', '127.0.0.1', '2017-09-09 15:02:49');
INSERT INTO `sys_log` VALUES ('423', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:delete,[参数]:id=224&', '127.0.0.1', '2017-09-09 15:02:56');
INSERT INTO `sys_log` VALUES ('424', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=230&_=1504940439066&', '127.0.0.1', '2017-09-09 15:03:06');
INSERT INTO `sys_log` VALUES ('425', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=230&name=新闻管理&resourceType=0&url=&openMode=ajax&icon=fi-page-multiple&seq=1&status=0&opened=0&pid=&', '127.0.0.1', '2017-09-09 15:03:18');
INSERT INTO `sys_log` VALUES ('426', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=1&_=1504941175025&', '127.0.0.1', '2017-09-09 15:14:45');
INSERT INTO `sys_log` VALUES ('427', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=1&name=权限管理&resourceType=0&url=&openMode=&icon=fi-wrench icon-red&seq=0&status=0&opened=1&pid=&', '127.0.0.1', '2017-09-09 15:14:51');
INSERT INTO `sys_log` VALUES ('428', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=11&_=1504941175026&', '127.0.0.1', '2017-09-09 15:14:56');
INSERT INTO `sys_log` VALUES ('429', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=11&name=资源管理&resourceType=0&url=/resource/manager&openMode=ajax&icon=fi-database icon-red&seq=1&status=0&opened=1&pid=1&', '127.0.0.1', '2017-09-09 15:15:00');
INSERT INTO `sys_log` VALUES ('430', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=12&_=1504941175028&', '127.0.0.1', '2017-09-09 15:15:23');
INSERT INTO `sys_log` VALUES ('431', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=12&name=角色管理&resourceType=0&url=/role/manager&openMode=ajax&icon=fi-torso-business  icon-red&seq=2&status=0&opened=1&pid=1&', '127.0.0.1', '2017-09-09 15:15:27');
INSERT INTO `sys_log` VALUES ('432', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=13&_=1504941175029&', '127.0.0.1', '2017-09-09 15:15:31');
INSERT INTO `sys_log` VALUES ('433', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=13&name=用户管理&resourceType=0&url=/user/manager&openMode=ajax&icon=fi-torsos-all icon-red&seq=3&status=0&opened=1&pid=1&', '127.0.0.1', '2017-09-09 15:15:35');
INSERT INTO `sys_log` VALUES ('434', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=14&_=1504941175031&', '127.0.0.1', '2017-09-09 15:15:42');
INSERT INTO `sys_log` VALUES ('435', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=14&name=部门管理&resourceType=0&url=/organization/manager&openMode=ajax&icon=fi-results-demographics  icon-red&seq=4&status=0&opened=1&pid=1&', '127.0.0.1', '2017-09-09 15:15:46');
INSERT INTO `sys_log` VALUES ('436', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=14&name=部门管理&resourceType=0&url=/organization/manager&openMode=ajax&icon=fi-results-demographics  icon-red&seq=4&status=0&opened=1&pid=1&', '127.0.0.1', '2017-09-09 15:15:48');
INSERT INTO `sys_log` VALUES ('437', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=14&name=部门管理&resourceType=0&url=/organization/manager&openMode=ajax&icon=fi-results-demographics  icon-red&seq=4&status=0&opened=1&pid=1&', '127.0.0.1', '2017-09-09 15:15:56');
INSERT INTO `sys_log` VALUES ('438', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=14&_=1504941175032&', '127.0.0.1', '2017-09-09 15:19:28');
INSERT INTO `sys_log` VALUES ('439', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=14&name=部门管理&resourceType=0&url=/organization/manager&openMode=ajax&icon=fi-social-joomla icon-red&seq=4&status=0&opened=1&pid=1&', '127.0.0.1', '2017-09-09 15:19:32');
INSERT INTO `sys_log` VALUES ('440', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=226&_=1504941175033&', '127.0.0.1', '2017-09-09 15:20:30');
INSERT INTO `sys_log` VALUES ('441', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1504941758212&', '127.0.0.1', '2017-09-09 15:25:30');
INSERT INTO `sys_log` VALUES ('442', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-09 15:25:48');
INSERT INTO `sys_log` VALUES ('443', 'admin', 'admin', '[类名]:com.aaa.controller.UserController,[方法]:addPage,[参数]:', null, '2017-09-09 15:29:24');
INSERT INTO `sys_log` VALUES ('444', 'admin', 'admin', '[类名]:com.aaa.controller.UserController,[方法]:editPage,[参数]:id=1&_=1504942645031&', '127.0.0.1', '2017-09-09 15:38:09');
INSERT INTO `sys_log` VALUES ('445', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=1&_=1504942645033&', '127.0.0.1', '2017-09-09 15:38:23');
INSERT INTO `sys_log` VALUES ('446', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=1&code=01&name=政通路&seq=0&icon=fi-social-windows&address=郑州市二七区政通路&pid=&', '127.0.0.1', '2017-09-09 15:39:02');
INSERT INTO `sys_log` VALUES ('447', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=7&_=1504942645034&', '127.0.0.1', '2017-09-09 15:39:07');
INSERT INTO `sys_log` VALUES ('448', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=7&code=55&name=学术部&seq=3&icon=fi-torsos-all icon-blue&address=&pid=1&', '127.0.0.1', '2017-09-09 15:39:11');
INSERT INTO `sys_log` VALUES ('449', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=3&_=1504942645035&', '127.0.0.1', '2017-09-09 15:39:41');
INSERT INTO `sys_log` VALUES ('450', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=3&code=02&name=杨金路&seq=1&icon=fi-social-github&address=郑州市金水区牛顿国际&pid=&', '127.0.0.1', '2017-09-09 15:40:22');
INSERT INTO `sys_log` VALUES ('451', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=5&_=1504942645036&', '127.0.0.1', '2017-09-09 15:40:25');
INSERT INTO `sys_log` VALUES ('452', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=5&code=03&name=新乡职业技术学院&seq=2&icon=fi-social-apple&address=&pid=&', '127.0.0.1', '2017-09-09 15:40:39');
INSERT INTO `sys_log` VALUES ('453', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=6&_=1504942645037&', '127.0.0.1', '2017-09-09 15:41:47');
INSERT INTO `sys_log` VALUES ('454', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=6&code=04&name=学术部&seq=0&icon=fi-social-snapchat&address=&pid=3&', '127.0.0.1', '2017-09-09 15:41:56');
INSERT INTO `sys_log` VALUES ('455', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-09 15:42:06');
INSERT INTO `sys_log` VALUES ('456', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=7&_=1504942645039&', '127.0.0.1', '2017-09-09 15:42:20');
INSERT INTO `sys_log` VALUES ('457', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-09 15:42:34');
INSERT INTO `sys_log` VALUES ('458', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-09 15:45:04');
INSERT INTO `sys_log` VALUES ('459', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:add,[参数]:code=56&name=化工开封校区&seq=3&icon=fi-folder&address=&pid=&', '127.0.0.1', '2017-09-09 15:46:16');
INSERT INTO `sys_log` VALUES ('460', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=5&_=1504942645044&', '127.0.0.1', '2017-09-09 15:47:24');
INSERT INTO `sys_log` VALUES ('461', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=5&code=03&name=学术部&seq=1&icon=fi-social-apple&address=&pid=5&', '127.0.0.1', '2017-09-09 15:47:43');
INSERT INTO `sys_log` VALUES ('462', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=5&_=1504942645045&', '127.0.0.1', '2017-09-09 15:47:46');
INSERT INTO `sys_log` VALUES ('463', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=5&code=03&name=新乡职业技术学院&seq=1&icon=fi-social-apple&address=&pid=5&', '127.0.0.1', '2017-09-09 15:48:15');
INSERT INTO `sys_log` VALUES ('464', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-09 15:48:22');
INSERT INTO `sys_log` VALUES ('465', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:add,[参数]:code=57&name=学术部&seq=0&icon=fi-folder&address=&pid=5&', '127.0.0.1', '2017-09-09 15:48:39');
INSERT INTO `sys_log` VALUES ('466', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=7&_=1504942645047&', '127.0.0.1', '2017-09-09 15:48:47');
INSERT INTO `sys_log` VALUES ('467', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=6&_=1504942645048&', '127.0.0.1', '2017-09-09 15:48:51');
INSERT INTO `sys_log` VALUES ('468', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=6&code=04&name=学术部&seq=0&icon=fi-torsos-all icon-blue&address=&pid=3&', '127.0.0.1', '2017-09-09 15:48:54');
INSERT INTO `sys_log` VALUES ('469', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=9&_=1504942645049&', '127.0.0.1', '2017-09-09 15:48:55');
INSERT INTO `sys_log` VALUES ('470', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=9&code=57&name=学术部&seq=0&icon=fi-torsos-all icon-blue&address=&pid=5&', '127.0.0.1', '2017-09-09 15:48:57');
INSERT INTO `sys_log` VALUES ('471', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-09 15:49:04');
INSERT INTO `sys_log` VALUES ('472', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:add,[参数]:code=67&name=学术部&seq=0&icon=fi-torsos-all icon-blue&address=&pid=8&', '127.0.0.1', '2017-09-09 15:49:22');
INSERT INTO `sys_log` VALUES ('473', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=5&_=1504942645051&', '127.0.0.1', '2017-09-09 15:49:39');
INSERT INTO `sys_log` VALUES ('474', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=5&code=03&name=新乡职业技术学院&seq=1&icon=fi-social-apple&address=新乡市&pid=5&', '127.0.0.1', '2017-09-09 15:49:52');
INSERT INTO `sys_log` VALUES ('475', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=8&_=1504942645052&', '127.0.0.1', '2017-09-09 15:49:54');
INSERT INTO `sys_log` VALUES ('476', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=8&code=56&name=化工开封校区&seq=3&icon=fi-folder&address=开封市&pid=&', '127.0.0.1', '2017-09-09 15:50:02');
INSERT INTO `sys_log` VALUES ('477', 'admin', 'admin', '[类名]:com.aaa.controller.CommonsController,[方法]:ueditor,[参数]:action=config&noCache=1504945714747&', '127.0.0.1', '2017-09-09 16:28:34');
INSERT INTO `sys_log` VALUES ('478', 'admin', 'admin', '[类名]:com.aaa.controller.LoginController,[方法]:logout,[参数]:', null, '2017-09-09 16:35:29');
INSERT INTO `sys_log` VALUES ('479', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-09 16:41:21');
INSERT INTO `sys_log` VALUES ('480', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=学生管理&resourceType=0&url=/stu/manager&openMode=ajax&icon=&seq=0&status=0&opened=1&pid=&', '127.0.0.1', '2017-09-09 16:42:41');
INSERT INTO `sys_log` VALUES ('481', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=232&_=1504946473362&', '127.0.0.1', '2017-09-09 16:43:27');
INSERT INTO `sys_log` VALUES ('482', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=232&name=学生管理&resourceType=0&url=/stu/manager&openMode=&icon=fi-torsos-all icon-red&seq=0&status=0&opened=1&pid=&', '127.0.0.1', '2017-09-09 16:43:32');
INSERT INTO `sys_log` VALUES ('483', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-09 16:43:50');
INSERT INTO `sys_log` VALUES ('484', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=添加学生&resourceType=1&url=/stu/add&openMode=ajax&icon=fi-torsos-all icon-red&seq=0&status=0&opened=1&pid=232&', '127.0.0.1', '2017-09-09 16:44:36');
INSERT INTO `sys_log` VALUES ('485', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1504946473365&', '127.0.0.1', '2017-09-09 16:45:11');
INSERT INTO `sys_log` VALUES ('486', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=232&_=1504946473366&', '127.0.0.1', '2017-09-09 16:45:19');
INSERT INTO `sys_log` VALUES ('487', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-09 16:45:32');
INSERT INTO `sys_log` VALUES ('488', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=修改学生&resourceType=0&url=&openMode=ajax&icon=fi-torsos-all icon-red&seq=0&status=0&opened=1&pid=232&', '127.0.0.1', '2017-09-09 16:46:00');
INSERT INTO `sys_log` VALUES ('489', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:editPage,[参数]:id=1&_=1505102052489&', '127.0.0.1', '2017-09-11 11:55:41');
INSERT INTO `sys_log` VALUES ('490', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1505102052490&', '127.0.0.1', '2017-09-11 11:55:44');
INSERT INTO `sys_log` VALUES ('491', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1505111091312&', '127.0.0.1', '2017-09-11 14:25:32');
INSERT INTO `sys_log` VALUES ('492', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=233&name=添加学生&resourceType=0&url=/stu/add&openMode=ajax&icon=fi-torsos-all icon-red&seq=0&status=0&opened=1&pid=232&', '127.0.0.1', '2017-09-11 14:25:38');
INSERT INTO `sys_log` VALUES ('493', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:delete,[参数]:id=234&', '127.0.0.1', '2017-09-11 14:27:12');
INSERT INTO `sys_log` VALUES ('494', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1505111091316&', '127.0.0.1', '2017-09-11 14:27:25');
INSERT INTO `sys_log` VALUES ('495', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=233&name=学生管理&resourceType=0&url=/stu/manager&openMode=ajax&icon=fi-torsos-all icon-red&seq=0&status=0&opened=1&pid=232&', '127.0.0.1', '2017-09-11 14:27:49');
INSERT INTO `sys_log` VALUES ('496', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=7&_=1505111091324&', '127.0.0.1', '2017-09-11 14:34:02');
INSERT INTO `sys_log` VALUES ('497', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-11 14:35:22');
INSERT INTO `sys_log` VALUES ('498', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=课程管理&resourceType=0&url=&openMode=无(用于上层菜单)&icon=&seq=0&status=0&opened=0&pid=&', '127.0.0.1', '2017-09-11 14:36:05');
INSERT INTO `sys_log` VALUES ('499', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-11 14:36:23');
INSERT INTO `sys_log` VALUES ('500', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=课表管理&resourceType=1&url=/course/manager&openMode=ajax&icon=&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-11 14:37:54');
INSERT INTO `sys_log` VALUES ('501', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=236&_=1505111091327&', '127.0.0.1', '2017-09-11 14:38:04');
INSERT INTO `sys_log` VALUES ('502', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=236&name=课表管理&resourceType=0&url=/course/manager&openMode=ajax&icon=&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-11 14:38:09');
INSERT INTO `sys_log` VALUES ('503', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=235&_=1505111091334&', '127.0.0.1', '2017-09-11 14:39:28');
INSERT INTO `sys_log` VALUES ('504', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=235&name=课程管理&resourceType=0&url=&openMode=&icon=fi-book icon-blue&seq=0&status=0&opened=0&pid=&', '127.0.0.1', '2017-09-11 14:39:31');
INSERT INTO `sys_log` VALUES ('505', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=236&_=1505111091335&', '127.0.0.1', '2017-09-11 14:39:34');
INSERT INTO `sys_log` VALUES ('506', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=236&name=课表管理&resourceType=0&url=/course/manager&openMode=ajax&icon=fi-book icon-blue&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-11 14:39:37');
INSERT INTO `sys_log` VALUES ('507', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=236&_=1505111091336&', '127.0.0.1', '2017-09-11 14:42:10');
INSERT INTO `sys_log` VALUES ('508', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=236&name=课表管理&resourceType=0&url=/course/manager&openMode=ajax&icon=fi-book-bookmark icon-blue&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-11 14:42:14');
INSERT INTO `sys_log` VALUES ('509', 'admin', 'admin', '[类名]:com.aaa.controller.UserController,[方法]:addPage,[参数]:', null, '2017-09-11 14:43:12');
INSERT INTO `sys_log` VALUES ('510', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grantPage,[参数]:id=2&_=1505111091341&', '127.0.0.1', '2017-09-11 14:44:02');
INSERT INTO `sys_log` VALUES ('511', 'admin', 'admin', '[类名]:com.aaa.controller.UserController,[方法]:addPage,[参数]:', null, '2017-09-11 14:59:37');
INSERT INTO `sys_log` VALUES ('512', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-11 15:06:40');
INSERT INTO `sys_log` VALUES ('513', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=12&_=1505111091346&', '127.0.0.1', '2017-09-11 15:10:12');
INSERT INTO `sys_log` VALUES ('514', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-11 15:20:11');
INSERT INTO `sys_log` VALUES ('515', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-11 15:46:06');
INSERT INTO `sys_log` VALUES ('516', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=13&_=1505111091352&', '127.0.0.1', '2017-09-11 15:48:31');
INSERT INTO `sys_log` VALUES ('517', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=236&_=1505111091353&', '127.0.0.1', '2017-09-11 15:48:42');
INSERT INTO `sys_log` VALUES ('518', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=236&name=课表管理&resourceType=0&url=/user/manager&openMode=ajax&icon=fi-book-bookmark icon-blue&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-11 15:48:46');
INSERT INTO `sys_log` VALUES ('519', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-11 15:49:43');
INSERT INTO `sys_log` VALUES ('520', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/resource/treeGrid&openMode=ajax&icon=fi-list&seq=0&status=0&opened=1&pid=236&', '127.0.0.1', '2017-09-11 15:50:46');
INSERT INTO `sys_log` VALUES ('521', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=11&_=1505111091357&', '127.0.0.1', '2017-09-11 15:51:14');
INSERT INTO `sys_log` VALUES ('522', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=236&_=1505111091358&', '127.0.0.1', '2017-09-11 15:51:24');
INSERT INTO `sys_log` VALUES ('523', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=236&name=课表管理&resourceType=0&url=/resource/manager&openMode=ajax&icon=fi-book-bookmark icon-blue&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-11 15:51:27');
INSERT INTO `sys_log` VALUES ('524', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=114&_=1505118119838&', '127.0.0.1', '2017-09-11 16:22:04');
INSERT INTO `sys_log` VALUES ('525', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=236&_=1505120832996&', '127.0.0.1', '2017-09-11 17:12:44');
INSERT INTO `sys_log` VALUES ('526', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=236&name=课表管理&resourceType=0&url=/user/manager&openMode=ajax&icon=fi-book-bookmark icon-blue&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-11 17:12:55');
INSERT INTO `sys_log` VALUES ('527', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=131&_=1505120832997&', '127.0.0.1', '2017-09-11 17:13:07');
INSERT INTO `sys_log` VALUES ('528', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=237&_=1505120832998&', '127.0.0.1', '2017-09-11 17:13:13');
INSERT INTO `sys_log` VALUES ('529', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=237&name=列表&resourceType=1&url=/user/dataGrid&openMode=ajax&icon=fi-list&seq=0&status=0&opened=1&pid=236&', '127.0.0.1', '2017-09-11 17:13:18');
INSERT INTO `sys_log` VALUES ('530', 'admin', 'admin', '[类名]:com.aaa.controller.UserController,[方法]:addPage,[参数]:', null, '2017-09-11 17:14:29');
INSERT INTO `sys_log` VALUES ('531', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=236&_=1505137650004&', '127.0.0.1', '2017-09-11 22:12:50');
INSERT INTO `sys_log` VALUES ('532', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=236&name=课表管理&resourceType=0&url=/course/manager&openMode=ajax&icon=fi-book-bookmark icon-blue&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-11 22:12:58');
INSERT INTO `sys_log` VALUES ('533', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 00:58:45');
INSERT INTO `sys_log` VALUES ('534', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=1&url=/course/edit&openMode=ajax&icon=fi-page-edit&seq=1&status=0&opened=0&pid=236&', '127.0.0.1', '2017-09-12 01:00:43');
INSERT INTO `sys_log` VALUES ('535', 'admin', 'admin', '[类名]:com.aaa.controller.LoginController,[方法]:logout,[参数]:', null, '2017-09-12 01:01:45');
INSERT INTO `sys_log` VALUES ('536', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1505149314401&', '127.0.0.1', '2017-09-12 01:04:59');
INSERT INTO `sys_log` VALUES ('537', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,235,236,237,238,221,227,228&', '127.0.0.1', '2017-09-12 01:05:17');
INSERT INTO `sys_log` VALUES ('538', 'admin', 'admin', '[类名]:com.aaa.controller.LoginController,[方法]:logout,[参数]:', null, '2017-09-12 01:05:26');
INSERT INTO `sys_log` VALUES ('539', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 01:06:08');
INSERT INTO `sys_log` VALUES ('540', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=1&url=/course/delete&openMode=ajax&icon=fi-page-delete&seq=3&status=0&opened=0&pid=236&', '127.0.0.1', '2017-09-12 01:08:05');
INSERT INTO `sys_log` VALUES ('541', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 01:08:21');
INSERT INTO `sys_log` VALUES ('542', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=236&_=1505149539400&', '127.0.0.1', '2017-09-12 01:08:56');
INSERT INTO `sys_log` VALUES ('543', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=236&name=课表管理&resourceType=0&url=/course/manager&openMode=ajax&icon=fi-book-bookmark icon-blue&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-12 01:09:09');
INSERT INTO `sys_log` VALUES ('544', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=236&_=1505149539401&', '127.0.0.1', '2017-09-12 01:09:24');
INSERT INTO `sys_log` VALUES ('545', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=236&name=课表管理&resourceType=0&url=/course/manager&openMode=ajax&icon=fi-book-bookmark icon-blue&seq=0&status=0&opened=1&pid=235&', '127.0.0.1', '2017-09-12 01:09:31');
INSERT INTO `sys_log` VALUES ('546', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1505149539403&', '127.0.0.1', '2017-09-12 01:09:53');
INSERT INTO `sys_log` VALUES ('547', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,232,233,235,236,237,238,239,230,231,221,227,228,229,226&', '127.0.0.1', '2017-09-12 01:10:00');
INSERT INTO `sys_log` VALUES ('548', 'admin', 'admin', '[类名]:com.aaa.controller.LoginController,[方法]:logout,[参数]:', null, '2017-09-12 01:10:12');
INSERT INTO `sys_log` VALUES ('549', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=6&_=1505177736277&', '127.0.0.1', '2017-09-12 09:12:08');
INSERT INTO `sys_log` VALUES ('550', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=6&code=04&name=java专业&seq=0&icon=fi-torsos-all icon-blue&address=&pid=3&', '127.0.0.1', '2017-09-12 09:12:17');
INSERT INTO `sys_log` VALUES ('551', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-12 09:12:20');
INSERT INTO `sys_log` VALUES ('552', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:add,[参数]:code=70&name=大数据专业&seq=1&icon=fi-folder&address=&pid=3&', '127.0.0.1', '2017-09-12 09:12:47');
INSERT INTO `sys_log` VALUES ('553', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 09:24:50');
INSERT INTO `sys_log` VALUES ('554', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=238&_=1505179485022&', '127.0.0.1', '2017-09-12 09:25:02');
INSERT INTO `sys_log` VALUES ('555', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1505179485024&', '127.0.0.1', '2017-09-12 09:25:22');
INSERT INTO `sys_log` VALUES ('556', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,232,233,235,236,237,238,230,231,221,227,228,229,226&', '127.0.0.1', '2017-09-12 09:25:37');
INSERT INTO `sys_log` VALUES ('557', 'admin', 'admin', '[类名]:com.aaa.controller.LoginController,[方法]:logout,[参数]:', null, '2017-09-12 09:25:43');
INSERT INTO `sys_log` VALUES ('558', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1505179550269&', '127.0.0.1', '2017-09-12 09:26:01');
INSERT INTO `sys_log` VALUES ('559', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,232,233,235,236,237,238,239,230,231,221,227,228,229,226&', '127.0.0.1', '2017-09-12 09:26:08');
INSERT INTO `sys_log` VALUES ('560', 'admin', 'admin', '[类名]:com.aaa.controller.LoginController,[方法]:logout,[参数]:', null, '2017-09-12 09:26:11');
INSERT INTO `sys_log` VALUES ('561', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 10:04:33');
INSERT INTO `sys_log` VALUES ('562', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/course/add&openMode=ajax&icon=fi-page-add&seq=-1&status=0&opened=0&pid=236&', '127.0.0.1', '2017-09-12 10:05:50');
INSERT INTO `sys_log` VALUES ('563', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1505184449127&', '127.0.0.1', '2017-09-12 10:48:29');
INSERT INTO `sys_log` VALUES ('564', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,232,233,235,236,240,237,238,239,230,231,221,227,228,229,226,237,238,239,230,231,221,227,228,229,226&', '127.0.0.1', '2017-09-12 10:49:02');
INSERT INTO `sys_log` VALUES ('565', 'admin', 'admin', '[类名]:com.aaa.controller.LoginController,[方法]:logout,[参数]:', null, '2017-09-12 10:49:05');
INSERT INTO `sys_log` VALUES ('566', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=6&_=1505184550730&', '127.0.0.1', '2017-09-12 10:49:35');
INSERT INTO `sys_log` VALUES ('567', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=6&_=1505184550733&', '127.0.0.1', '2017-09-12 10:51:04');
INSERT INTO `sys_log` VALUES ('568', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=6&code=04&name=java专业&seq=0&icon=fi-social-stumbleupon icon-red&address=&pid=3&', '127.0.0.1', '2017-09-12 10:51:09');
INSERT INTO `sys_log` VALUES ('569', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=11&_=1505184550734&', '127.0.0.1', '2017-09-12 10:51:12');
INSERT INTO `sys_log` VALUES ('570', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=11&_=1505184550735&', '127.0.0.1', '2017-09-12 10:51:54');
INSERT INTO `sys_log` VALUES ('571', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=11&code=70&name=大数据专业&seq=1&icon=fi-social-windows icon-red&address=&pid=3&', '127.0.0.1', '2017-09-12 10:51:58');
INSERT INTO `sys_log` VALUES ('572', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 11:04:30');
INSERT INTO `sys_log` VALUES ('573', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 11:15:29');
INSERT INTO `sys_log` VALUES ('574', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 11:16:25');
INSERT INTO `sys_log` VALUES ('575', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 11:19:38');
INSERT INTO `sys_log` VALUES ('576', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 11:19:46');
INSERT INTO `sys_log` VALUES ('577', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 11:21:17');
INSERT INTO `sys_log` VALUES ('578', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 11:21:41');
INSERT INTO `sys_log` VALUES ('579', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=测试&resourceType=0&url=&openMode=ajax&icon=&seq=0&status=0&opened=0&pid=&', '127.0.0.1', '2017-09-12 11:21:57');
INSERT INTO `sys_log` VALUES ('580', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:delete,[参数]:id=241&', '127.0.0.1', '2017-09-12 11:22:05');
INSERT INTO `sys_log` VALUES ('581', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 11:22:26');
INSERT INTO `sys_log` VALUES ('582', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 11:26:06');
INSERT INTO `sys_log` VALUES ('583', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 11:31:19');
INSERT INTO `sys_log` VALUES ('584', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 11:35:47');
INSERT INTO `sys_log` VALUES ('585', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 11:44:59');
INSERT INTO `sys_log` VALUES ('586', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 11:46:18');
INSERT INTO `sys_log` VALUES ('587', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 11:47:33');
INSERT INTO `sys_log` VALUES ('588', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 13:59:49');
INSERT INTO `sys_log` VALUES ('589', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:05:48');
INSERT INTO `sys_log` VALUES ('590', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:07:17');
INSERT INTO `sys_log` VALUES ('591', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 14:08:56');
INSERT INTO `sys_log` VALUES ('592', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:15:56');
INSERT INTO `sys_log` VALUES ('593', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:16:49');
INSERT INTO `sys_log` VALUES ('594', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:31:35');
INSERT INTO `sys_log` VALUES ('595', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:32:51');
INSERT INTO `sys_log` VALUES ('596', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:39:47');
INSERT INTO `sys_log` VALUES ('597', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:add,[参数]:courseName=计算机基础第一章&courseCode=JCLX-1&icon=fi-foubdation icon-blue&seq=0&status=0&courseType=1&pid=1&', '127.0.0.1', '2017-09-12 14:40:06');
INSERT INTO `sys_log` VALUES ('598', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:42:13');
INSERT INTO `sys_log` VALUES ('599', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:43:29');
INSERT INTO `sys_log` VALUES ('600', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:46:59');
INSERT INTO `sys_log` VALUES ('601', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:47:31');
INSERT INTO `sys_log` VALUES ('602', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:add,[参数]:courseName=计算机基础第二章&courseCode=JCLX-2&icon=fi-foundation icon-blue&seq=1&status=0&courseType=0&pid=1&', '127.0.0.1', '2017-09-12 14:48:00');
INSERT INTO `sys_log` VALUES ('603', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:48:26');
INSERT INTO `sys_log` VALUES ('604', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:add,[参数]:courseName=计算机基础第三章&courseCode=JCLX-3&icon=fi-foundation icon-blue&seq=2&status=0&courseType=0&pid=1&', '127.0.0.1', '2017-09-12 14:48:48');
INSERT INTO `sys_log` VALUES ('605', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:51:55');
INSERT INTO `sys_log` VALUES ('606', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:add,[参数]:courseName=计算机基础第四章&courseCode=JCLX-4&icon=fi-foundation icon-blue&seq=3&status=0&courseType=0&pid=1&', '127.0.0.1', '2017-09-12 14:52:29');
INSERT INTO `sys_log` VALUES ('607', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:53:23');
INSERT INTO `sys_log` VALUES ('608', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 14:54:35');
INSERT INTO `sys_log` VALUES ('609', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:add,[参数]:courseName=安装操作系统&courseCode=JCLX-1-01&icon=fi-sheriff-badge icon-blue&seq=0&status=0&courseType=1&pid=10&', '127.0.0.1', '2017-09-12 14:55:09');
INSERT INTO `sys_log` VALUES ('610', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=9&', '127.0.0.1', '2017-09-12 15:06:18');
INSERT INTO `sys_log` VALUES ('611', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=10&', '127.0.0.1', '2017-09-12 15:07:42');
INSERT INTO `sys_log` VALUES ('612', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 15:10:55');
INSERT INTO `sys_log` VALUES ('613', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=课程测试&resourceType=0&url=&openMode=ajax&icon=fi-torsos-all icon-blue&seq=0&status=0&opened=0&pid=235&', '127.0.0.1', '2017-09-12 15:11:22');
INSERT INTO `sys_log` VALUES ('614', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-12 15:11:30');
INSERT INTO `sys_log` VALUES ('615', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=测试01&resourceType=0&url=&openMode=ajax&icon=&seq=0&status=0&opened=1&pid=242&', '127.0.0.1', '2017-09-12 15:11:47');
INSERT INTO `sys_log` VALUES ('616', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=238&_=1505198899176&', '127.0.0.1', '2017-09-12 15:12:00');
INSERT INTO `sys_log` VALUES ('617', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=238&name=编辑&resourceType=1&url=/course/edit&openMode=ajax&icon=fi-page-edit&seq=1&status=0&opened=1&pid=236&', '127.0.0.1', '2017-09-12 15:12:04');
INSERT INTO `sys_log` VALUES ('618', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=239&_=1505198899177&', '127.0.0.1', '2017-09-12 15:12:09');
INSERT INTO `sys_log` VALUES ('619', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=239&name=删除&resourceType=1&url=/course/delete&openMode=ajax&icon=fi-page-delete&seq=3&status=0&opened=1&pid=236&', '127.0.0.1', '2017-09-12 15:12:12');
INSERT INTO `sys_log` VALUES ('620', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:delete,[参数]:id=242&', '127.0.0.1', '2017-09-12 15:12:54');
INSERT INTO `sys_log` VALUES ('621', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:delete,[参数]:id=243&', '127.0.0.1', '2017-09-12 15:13:13');
INSERT INTO `sys_log` VALUES ('622', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=12&', '127.0.0.1', '2017-09-12 15:18:13');
INSERT INTO `sys_log` VALUES ('623', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 15:19:30');
INSERT INTO `sys_log` VALUES ('624', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=3&', '127.0.0.1', '2017-09-12 15:59:59');
INSERT INTO `sys_log` VALUES ('625', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=2&', '127.0.0.1', '2017-09-12 16:31:13');
INSERT INTO `sys_log` VALUES ('626', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=2&', '127.0.0.1', '2017-09-12 16:33:41');
INSERT INTO `sys_log` VALUES ('627', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=2&', '127.0.0.1', '2017-09-12 16:35:32');
INSERT INTO `sys_log` VALUES ('628', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=4&', '127.0.0.1', '2017-09-12 16:39:55');
INSERT INTO `sys_log` VALUES ('629', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=5&', '127.0.0.1', '2017-09-12 16:39:59');
INSERT INTO `sys_log` VALUES ('630', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=3&', '127.0.0.1', '2017-09-12 16:40:02');
INSERT INTO `sys_log` VALUES ('631', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=1&', '127.0.0.1', '2017-09-12 16:40:06');
INSERT INTO `sys_log` VALUES ('632', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=2&', '127.0.0.1', '2017-09-12 16:40:09');
INSERT INTO `sys_log` VALUES ('633', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=114&_=1505205325319&', '127.0.0.1', '2017-09-12 16:50:05');
INSERT INTO `sys_log` VALUES ('634', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=235&_=1505205325320&', '127.0.0.1', '2017-09-12 16:50:18');
INSERT INTO `sys_log` VALUES ('635', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=235&_=1505205325321&', '127.0.0.1', '2017-09-12 16:50:31');
INSERT INTO `sys_log` VALUES ('636', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=4&_=1505206668947&', '127.0.0.1', '2017-09-12 16:57:54');
INSERT INTO `sys_log` VALUES ('637', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=124&_=1505206668949&', '127.0.0.1', '2017-09-12 16:59:06');
INSERT INTO `sys_log` VALUES ('638', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=121&_=1505206668950&', '127.0.0.1', '2017-09-12 16:59:28');
INSERT INTO `sys_log` VALUES ('639', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=4&_=1505206668951&', '127.0.0.1', '2017-09-12 17:00:51');
INSERT INTO `sys_log` VALUES ('640', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 17:03:45');
INSERT INTO `sys_log` VALUES ('641', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:add,[参数]:courseName=计算机基础第三章&courseCode=JCLX-3&icon=fi-foundation icon-blue&seq=2&status=0&courseType=0&pid=1&', '127.0.0.1', '2017-09-12 17:05:05');
INSERT INTO `sys_log` VALUES ('642', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=6&', '127.0.0.1', '2017-09-12 17:05:36');
INSERT INTO `sys_log` VALUES ('643', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=2&', '127.0.0.1', '2017-09-12 17:05:43');
INSERT INTO `sys_log` VALUES ('644', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=9&_=1505206668953&', '127.0.0.1', '2017-09-12 17:05:48');
INSERT INTO `sys_log` VALUES ('645', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 17:05:52');
INSERT INTO `sys_log` VALUES ('646', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=5&_=1505219900159&', '127.0.0.1', '2017-09-12 20:45:55');
INSERT INTO `sys_log` VALUES ('647', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=6&_=1505219900160&', '127.0.0.1', '2017-09-12 20:46:02');
INSERT INTO `sys_log` VALUES ('648', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=4&_=1505220415496&', '127.0.0.1', '2017-09-12 20:47:10');
INSERT INTO `sys_log` VALUES ('649', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=111&_=1505220415498&', '127.0.0.1', '2017-09-12 20:50:05');
INSERT INTO `sys_log` VALUES ('650', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=240&_=1505220415499&', '127.0.0.1', '2017-09-12 20:51:23');
INSERT INTO `sys_log` VALUES ('651', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=240&name=添加&resourceType=1&url=/course/add&openMode=ajax&icon=fi-page-add&seq=-1&status=0&opened=1&pid=236&', '127.0.0.1', '2017-09-12 20:51:28');
INSERT INTO `sys_log` VALUES ('652', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=231&_=1505220415500&', '127.0.0.1', '2017-09-12 20:51:31');
INSERT INTO `sys_log` VALUES ('653', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=231&_=1505220415501&', '127.0.0.1', '2017-09-12 21:03:05');
INSERT INTO `sys_log` VALUES ('654', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=231&_=1505220415502&', '127.0.0.1', '2017-09-12 21:03:24');
INSERT INTO `sys_log` VALUES ('655', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1505220415505&', '127.0.0.1', '2017-09-12 21:04:26');
INSERT INTO `sys_log` VALUES ('656', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,232,233,235,236,240,237,238,239,230,231,221,227,228,229,226&', '127.0.0.1', '2017-09-12 21:04:40');
INSERT INTO `sys_log` VALUES ('657', 'admin', 'admin', '[类名]:com.aaa.controller.RoleController,[方法]:editPage,[参数]:id=1&_=1505220415506&', '127.0.0.1', '2017-09-12 21:04:43');
INSERT INTO `sys_log` VALUES ('658', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=1&_=1505220415508&', '127.0.0.1', '2017-09-12 21:05:28');
INSERT INTO `sys_log` VALUES ('659', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=231&_=1505220415509&', '127.0.0.1', '2017-09-12 21:07:27');
INSERT INTO `sys_log` VALUES ('660', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505220415510&', '127.0.0.1', '2017-09-12 21:08:10');
INSERT INTO `sys_log` VALUES ('661', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505220415511&', '127.0.0.1', '2017-09-12 21:08:26');
INSERT INTO `sys_log` VALUES ('662', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505220415512&', '127.0.0.1', '2017-09-12 21:08:30');
INSERT INTO `sys_log` VALUES ('663', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505220415514&', '127.0.0.1', '2017-09-12 21:09:33');
INSERT INTO `sys_log` VALUES ('664', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=6&_=1505220415515&', '127.0.0.1', '2017-09-12 21:10:14');
INSERT INTO `sys_log` VALUES ('665', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=3&_=1505220415517&', '127.0.0.1', '2017-09-12 21:12:25');
INSERT INTO `sys_log` VALUES ('666', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=3&_=1505220415518&', '127.0.0.1', '2017-09-12 21:12:41');
INSERT INTO `sys_log` VALUES ('667', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505220415520&', '127.0.0.1', '2017-09-12 21:13:32');
INSERT INTO `sys_log` VALUES ('668', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 21:13:41');
INSERT INTO `sys_log` VALUES ('669', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 21:13:52');
INSERT INTO `sys_log` VALUES ('670', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=3&_=1505220415525&', '127.0.0.1', '2017-09-12 21:14:09');
INSERT INTO `sys_log` VALUES ('671', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=5&_=1505220415526&', '127.0.0.1', '2017-09-12 21:22:45');
INSERT INTO `sys_log` VALUES ('672', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=7&_=1505220415532&', '127.0.0.1', '2017-09-12 21:29:38');
INSERT INTO `sys_log` VALUES ('673', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=6&_=1505220415533&', '127.0.0.1', '2017-09-12 21:29:47');
INSERT INTO `sys_log` VALUES ('674', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=7&_=1505220415534&', '127.0.0.1', '2017-09-12 21:29:53');
INSERT INTO `sys_log` VALUES ('675', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=7&code=55&name=java专业&seq=3&icon=fi-social-stumbleupon icon-red&address=&pid=1&', '127.0.0.1', '2017-09-12 21:30:09');
INSERT INTO `sys_log` VALUES ('676', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=9&_=1505220415535&', '127.0.0.1', '2017-09-12 21:30:17');
INSERT INTO `sys_log` VALUES ('677', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=9&code=57&name=java专业&seq=0&icon=fi-social-stumbleupon icon-red&address=&pid=5&', '127.0.0.1', '2017-09-12 21:30:26');
INSERT INTO `sys_log` VALUES ('678', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=10&_=1505220415536&', '127.0.0.1', '2017-09-12 21:30:29');
INSERT INTO `sys_log` VALUES ('679', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=10&code=67&name=java专业&seq=0&icon=fi-social-stumbleupon icon-red&address=&pid=8&', '127.0.0.1', '2017-09-12 21:30:40');
INSERT INTO `sys_log` VALUES ('680', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=1&_=1505220415537&', '127.0.0.1', '2017-09-12 21:30:47');
INSERT INTO `sys_log` VALUES ('681', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=1&code=01&name=政通路校区&seq=0&icon=fi-social-windows&address=郑州市二七区政通路&pid=&', '127.0.0.1', '2017-09-12 21:30:54');
INSERT INTO `sys_log` VALUES ('682', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=3&_=1505220415538&', '127.0.0.1', '2017-09-12 21:30:57');
INSERT INTO `sys_log` VALUES ('683', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=3&code=02&name=杨金路校区&seq=1&icon=fi-social-github&address=郑州市金水区牛顿国际&pid=&', '127.0.0.1', '2017-09-12 21:31:03');
INSERT INTO `sys_log` VALUES ('684', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=5&_=1505220415539&', '127.0.0.1', '2017-09-12 21:31:06');
INSERT INTO `sys_log` VALUES ('685', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=5&code=03&name=新乡校区&seq=1&icon=fi-social-apple&address=新乡市&pid=5&', '127.0.0.1', '2017-09-12 21:31:12');
INSERT INTO `sys_log` VALUES ('686', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=8&_=1505220415540&', '127.0.0.1', '2017-09-12 21:31:15');
INSERT INTO `sys_log` VALUES ('687', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=8&code=56&name=开封校区&seq=3&icon=fi-folder&address=开封市&pid=&', '127.0.0.1', '2017-09-12 21:31:19');
INSERT INTO `sys_log` VALUES ('688', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=1&_=1505220415543&', '127.0.0.1', '2017-09-12 21:32:18');
INSERT INTO `sys_log` VALUES ('689', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=1&_=1505220415544&', '127.0.0.1', '2017-09-12 21:32:38');
INSERT INTO `sys_log` VALUES ('690', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=1&code=01&name=政通路校区&seq=0&icon=fi-die-one&address=郑州市二七区政通路&pid=&', '127.0.0.1', '2017-09-12 21:32:41');
INSERT INTO `sys_log` VALUES ('691', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=3&_=1505220415545&', '127.0.0.1', '2017-09-12 21:32:56');
INSERT INTO `sys_log` VALUES ('692', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=3&code=02&name=杨金路校区&seq=1&icon=fi-die-two&address=郑州市金水区牛顿国际&pid=&', '127.0.0.1', '2017-09-12 21:32:58');
INSERT INTO `sys_log` VALUES ('693', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=5&_=1505220415546&', '127.0.0.1', '2017-09-12 21:33:14');
INSERT INTO `sys_log` VALUES ('694', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=5&code=03&name=新乡校区&seq=1&icon=fi-die-three&address=新乡市&pid=5&', '127.0.0.1', '2017-09-12 21:33:18');
INSERT INTO `sys_log` VALUES ('695', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:editPage,[参数]:id=8&_=1505220415547&', '127.0.0.1', '2017-09-12 21:33:29');
INSERT INTO `sys_log` VALUES ('696', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:edit,[参数]:id=8&code=56&name=开封校区&seq=3&icon=fi-die-four&address=开封市&pid=&', '127.0.0.1', '2017-09-12 21:33:32');
INSERT INTO `sys_log` VALUES ('697', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 22:26:31');
INSERT INTO `sys_log` VALUES ('698', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 22:35:59');
INSERT INTO `sys_log` VALUES ('699', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 22:56:54');
INSERT INTO `sys_log` VALUES ('700', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=2&_=1505224997846&', '127.0.0.1', '2017-09-12 22:57:54');
INSERT INTO `sys_log` VALUES ('701', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=1&_=1505228287445&', '127.0.0.1', '2017-09-12 22:58:20');
INSERT INTO `sys_log` VALUES ('702', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=3&_=1505228344748&', '127.0.0.1', '2017-09-12 22:59:11');
INSERT INTO `sys_log` VALUES ('703', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 23:01:07');
INSERT INTO `sys_log` VALUES ('704', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=1&_=1505228455789&', '127.0.0.1', '2017-09-12 23:01:12');
INSERT INTO `sys_log` VALUES ('705', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505228455790&', '127.0.0.1', '2017-09-12 23:01:16');
INSERT INTO `sys_log` VALUES ('706', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=8&_=1505228455791&', '127.0.0.1', '2017-09-12 23:01:20');
INSERT INTO `sys_log` VALUES ('707', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=6&_=1505228455795&', '127.0.0.1', '2017-09-12 23:04:18');
INSERT INTO `sys_log` VALUES ('708', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505228673174&', '127.0.0.1', '2017-09-12 23:06:01');
INSERT INTO `sys_log` VALUES ('709', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=8&_=1505228673175&', '127.0.0.1', '2017-09-12 23:06:09');
INSERT INTO `sys_log` VALUES ('710', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=6&_=1505229091287&', '127.0.0.1', '2017-09-12 23:11:53');
INSERT INTO `sys_log` VALUES ('711', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=6&_=1505229091289&', '127.0.0.1', '2017-09-12 23:13:06');
INSERT INTO `sys_log` VALUES ('712', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=3&_=1505229091290&', '127.0.0.1', '2017-09-12 23:13:15');
INSERT INTO `sys_log` VALUES ('713', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=2&_=1505229091291&', '127.0.0.1', '2017-09-12 23:13:24');
INSERT INTO `sys_log` VALUES ('714', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=5&_=1505229091292&', '127.0.0.1', '2017-09-12 23:15:06');
INSERT INTO `sys_log` VALUES ('715', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=5&_=1505229091294&', '127.0.0.1', '2017-09-12 23:16:29');
INSERT INTO `sys_log` VALUES ('716', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=5&_=1505229091295&', '127.0.0.1', '2017-09-12 23:18:51');
INSERT INTO `sys_log` VALUES ('717', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=6&_=1505229091296&', '127.0.0.1', '2017-09-12 23:19:16');
INSERT INTO `sys_log` VALUES ('718', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=8&_=1505229091297&', '127.0.0.1', '2017-09-12 23:19:32');
INSERT INTO `sys_log` VALUES ('719', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 23:19:55');
INSERT INTO `sys_log` VALUES ('720', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=6&_=1505229799525&', '127.0.0.1', '2017-09-12 23:23:27');
INSERT INTO `sys_log` VALUES ('721', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=5&_=1505229799527&', '127.0.0.1', '2017-09-12 23:25:53');
INSERT INTO `sys_log` VALUES ('722', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=1&_=1505229799529&', '127.0.0.1', '2017-09-12 23:30:09');
INSERT INTO `sys_log` VALUES ('723', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505229799530&', '127.0.0.1', '2017-09-12 23:30:14');
INSERT INTO `sys_log` VALUES ('724', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:edit,[参数]:id=7&courseName=计算机基础第一章&courseCode=JCLX-1&icon=fi-foundation icon-blue&seq=0&status=0&courseType=0&pid=1&', '127.0.0.1', '2017-09-12 23:30:17');
INSERT INTO `sys_log` VALUES ('725', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505229799531&', '127.0.0.1', '2017-09-12 23:30:39');
INSERT INTO `sys_log` VALUES ('726', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=1&_=1505229799532&', '127.0.0.1', '2017-09-12 23:30:53');
INSERT INTO `sys_log` VALUES ('727', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:edit,[参数]:id=1&courseName=计算机基础&courseCode=JCLX&icon=fi-foundation icon-blue&seq=0&status=0&courseType=0&pid=0&', '127.0.0.1', '2017-09-12 23:30:58');
INSERT INTO `sys_log` VALUES ('728', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=2&_=1505229799533&', '127.0.0.1', '2017-09-12 23:31:08');
INSERT INTO `sys_log` VALUES ('729', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:edit,[参数]:id=2&courseName=HTML基础&courseCode=HTML&icon=fi-foundation icon-blue&seq=0&status=0&courseType=0&pid=0&', '127.0.0.1', '2017-09-12 23:31:13');
INSERT INTO `sys_log` VALUES ('730', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=5&_=1505229799534&', '127.0.0.1', '2017-09-12 23:31:30');
INSERT INTO `sys_log` VALUES ('731', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:edit,[参数]:id=5&courseName=HTML基础第一章基本标签&courseCode=HTML-1-1&icon=fi-foundation icon-blue&seq=0&status=0&courseType=1&pid=3&', '127.0.0.1', '2017-09-12 23:31:35');
INSERT INTO `sys_log` VALUES ('732', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=6&_=1505229799535&', '127.0.0.1', '2017-09-12 23:31:37');
INSERT INTO `sys_log` VALUES ('733', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:edit,[参数]:id=6&courseName=HTML基础第一章基本表单&courseCode=HTML-1-2&icon=fi-foundation icon-blue&seq=0&status=0&courseType=1&pid=3&', '127.0.0.1', '2017-09-12 23:31:41');
INSERT INTO `sys_log` VALUES ('734', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:addPage,[参数]:', null, '2017-09-12 23:32:30');
INSERT INTO `sys_log` VALUES ('735', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:editPage,[参数]:id=7&_=1505229799538&', '127.0.0.1', '2017-09-12 23:32:37');
INSERT INTO `sys_log` VALUES ('736', 'admin', 'admin', '[类名]:com.aaa.controller.CourseController,[方法]:delete,[参数]:id=1&', '127.0.0.1', '2017-09-13 09:31:54');
INSERT INTO `sys_log` VALUES ('737', 'admin', 'admin', '[类名]:com.aaa.controller.UserController,[方法]:editPage,[参数]:id=14&_=1505269417727&', '127.0.0.1', '2017-09-13 10:33:09');
INSERT INTO `sys_log` VALUES ('738', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-13 10:35:26');
INSERT INTO `sys_log` VALUES ('739', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=教评管理&resourceType=0&url=/te/manager&openMode=ajax&icon=&seq=0&status=0&opened=0&pid=&', '127.0.0.1', '2017-09-13 10:37:59');
INSERT INTO `sys_log` VALUES ('740', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=235&_=1505269417732&', '127.0.0.1', '2017-09-13 10:38:24');
INSERT INTO `sys_log` VALUES ('741', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=235&name=课程管理&resourceType=0&url=&openMode=&icon=fi-book icon-blue&seq=0&status=0&opened=1&pid=&', '127.0.0.1', '2017-09-13 10:38:28');
INSERT INTO `sys_log` VALUES ('742', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=241&_=1505269417735&', '127.0.0.1', '2017-09-13 10:39:23');
INSERT INTO `sys_log` VALUES ('743', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=241&name=教评管理&resourceType=0&url=/te/manager&openMode=无(用于上层菜单)&icon=fi-like icon-purple&seq=0&status=0&opened=0&pid=&', '127.0.0.1', '2017-09-13 10:39:32');
INSERT INTO `sys_log` VALUES ('744', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=241&_=1505269417737&', '127.0.0.1', '2017-09-13 10:39:50');
INSERT INTO `sys_log` VALUES ('745', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=241&_=1505269417739&', '127.0.0.1', '2017-09-13 10:40:15');
INSERT INTO `sys_log` VALUES ('746', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=241&name=教评管理&resourceType=0&url=/te/manager&openMode=ajax&icon=fi-like icon-purple&seq=0&status=0&opened=0&pid=&', '127.0.0.1', '2017-09-13 10:40:19');
INSERT INTO `sys_log` VALUES ('747', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-13 10:40:23');
INSERT INTO `sys_log` VALUES ('748', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=学生自评&resourceType=0&url=/te/student&openMode=ajax&icon=&seq=0&status=0&opened=0&pid=241&', '127.0.0.1', '2017-09-13 10:41:08');
INSERT INTO `sys_log` VALUES ('749', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=241&_=1505269417741&', '127.0.0.1', '2017-09-13 10:42:30');
INSERT INTO `sys_log` VALUES ('750', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=241&name=教评管理&resourceType=0&url=/te/manager&openMode=ajax&icon=fi-ticket icon-purple&seq=0&status=0&opened=0&pid=&', '127.0.0.1', '2017-09-13 10:42:34');
INSERT INTO `sys_log` VALUES ('751', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=242&_=1505269417742&', '127.0.0.1', '2017-09-13 10:43:05');
INSERT INTO `sys_log` VALUES ('752', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=242&name=学生自评&resourceType=0&url=/te/student&openMode=&icon=fi-like icon-purple&seq=0&status=0&opened=0&pid=241&', '127.0.0.1', '2017-09-13 10:43:08');
INSERT INTO `sys_log` VALUES ('753', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=242&_=1505269417743&', '127.0.0.1', '2017-09-13 10:43:23');
INSERT INTO `sys_log` VALUES ('754', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=242&name=评价老师&resourceType=0&url=/te/teacher&openMode=ajax&icon=fi-like icon-purple&seq=0&status=0&opened=1&pid=241&', '127.0.0.1', '2017-09-13 10:44:14');
INSERT INTO `sys_log` VALUES ('755', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:addPage,[参数]:', null, '2017-09-13 10:44:19');
INSERT INTO `sys_log` VALUES ('756', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:add,[参数]:name=学生自评&resourceType=0&url=/te/student&openMode=ajax&icon=&seq=0&status=0&opened=0&pid=241&', '127.0.0.1', '2017-09-13 10:44:54');
INSERT INTO `sys_log` VALUES ('757', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=243&_=1505269417745&', '127.0.0.1', '2017-09-13 10:44:58');
INSERT INTO `sys_log` VALUES ('758', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=243&name=学生自评&resourceType=0&url=/te/student&openMode=&icon=&seq=0&status=0&opened=1&pid=241&', '127.0.0.1', '2017-09-13 10:45:01');
INSERT INTO `sys_log` VALUES ('759', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=243&_=1505269417746&', '127.0.0.1', '2017-09-13 10:45:13');
INSERT INTO `sys_log` VALUES ('760', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=243&name=学生自评&resourceType=0&url=/te/student&openMode=ajax&icon=fi-dislike icon-purple&seq=1&status=0&opened=1&pid=241&', '127.0.0.1', '2017-09-13 10:45:23');
INSERT INTO `sys_log` VALUES ('761', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=241&_=1505269417747&', '127.0.0.1', '2017-09-13 10:46:14');
INSERT INTO `sys_log` VALUES ('762', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=241&name=教评管理&resourceType=0&url=/te/manager&openMode=ajax&icon=fi-ticket icon-purple&seq=0&status=0&opened=1&pid=&', '127.0.0.1', '2017-09-13 10:46:18');
INSERT INTO `sys_log` VALUES ('763', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:editPage,[参数]:id=237&_=1505269417749&', '127.0.0.1', '2017-09-13 10:48:02');
INSERT INTO `sys_log` VALUES ('764', 'admin', 'admin', '[类名]:com.aaa.controller.ResourceController,[方法]:edit,[参数]:id=237&name=列表&resourceType=1&url=/course/dataGrid&openMode=ajax&icon=fi-list&seq=0&status=0&opened=1&pid=236&', '127.0.0.1', '2017-09-13 10:48:10');
INSERT INTO `sys_log` VALUES ('765', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-13 11:05:13');
INSERT INTO `sys_log` VALUES ('766', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-13 11:08:14');
INSERT INTO `sys_log` VALUES ('767', 'admin', 'admin', '[类名]:com.aaa.controller.OrganizationController,[方法]:addPage,[参数]:', null, '2017-09-13 11:14:22');

-- ----------------------------
-- Table structure for `tbl_chapter`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_chapter`;
CREATE TABLE `tbl_chapter` (
  `chapterId` int(8) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `chapterCode` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '科目代码，例如html',
  `chapterName` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '科目名称，例如html为超文本标记语言',
  `seq` int(4) DEFAULT NULL COMMENT '序号',
  `status` tinyint(2) DEFAULT NULL COMMENT '图标',
  `icon` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图标',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `courseId` int(8) DEFAULT NULL,
  PRIMARY KEY (`chapterId`),
  KEY `FK_Reference_2` (`courseId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='一个课程有多个章节';

-- ----------------------------
-- Records of tbl_chapter
-- ----------------------------
INSERT INTO `tbl_chapter` VALUES ('1', 'JCLX-1', '安装相关软件，打字练习', '1', '0', 'fi-page-multiple icon-blue', '2017-09-11 20:53:55', '1');
INSERT INTO `tbl_chapter` VALUES ('2', 'JCLX-2', 'PPT、word使用', '2', '0', 'fi-page-multiple icon-blue', '2017-09-11 20:58:15', '1');

-- ----------------------------
-- Table structure for `tbl_topic`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_topic`;
CREATE TABLE `tbl_topic` (
  `topicId` int(8) NOT NULL COMMENT '主键自增',
  `topicCode` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '知识点代码，例如html_topic_1',
  `topicName` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '科目名称，例如html为超文本标记语言',
  `seq` int(4) DEFAULT NULL COMMENT '序号',
  `status` tinyint(2) DEFAULT NULL COMMENT '图标',
  `icon` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图标',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `chapterId` int(8) DEFAULT NULL,
  PRIMARY KEY (`topicId`),
  KEY `FK_Reference_1` (`chapterId`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`chapterId`) REFERENCES `tbl_chapter` (`chapterId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='一个章节有多个知识点';

-- ----------------------------
-- Records of tbl_topic
-- ----------------------------
INSERT INTO `tbl_topic` VALUES ('1', null, '安装office', '1', '0', 'fi-sheriff-badge icon-blue', '2017-09-11 20:48:29', '1');
INSERT INTO `tbl_topic` VALUES ('2', null, '安装打字软件', '2', '0', 'fi-sheriff-badge icon-blue', '2017-09-11 20:59:19', '1');
INSERT INTO `tbl_topic` VALUES ('3', null, '安装excel', '3', '0', 'fi-sheriff-badge icon-blue', '2017-09-11 21:01:51', '1');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `login_name` varchar(64) NOT NULL COMMENT '登陆名',
  `name` varchar(64) NOT NULL COMMENT '用户名',
  `password` varchar(64) NOT NULL COMMENT '密码',
  `salt` varchar(36) DEFAULT NULL COMMENT '密码加密盐',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别',
  `age` tinyint(2) DEFAULT '0' COMMENT '年龄',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `user_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '用户类别',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '用户状态',
  `organization_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属机构',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDx_user_login_name` (`login_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'admin', 'bfbd1c7d0549dc1720987778bedd9412', 'test', '0', '25', '18707173376', '0', '0', '1', '2015-12-06 13:14:05');
INSERT INTO `user` VALUES ('13', 'snoopy', 'snoopy', '05a671c66aefea124cc08b76ea6d30bb', 'test', '0', '25', '18707173376', '1', '0', '3', '2015-10-01 13:12:07');
INSERT INTO `user` VALUES ('14', 'dreamlu', 'dreamlu', '05a671c66aefea124cc08b76ea6d30bb', 'test', '0', '25', '18707173376', '1', '0', '5', '2015-10-11 23:12:58');
INSERT INTO `user` VALUES ('15', 'test', 'test', '05a671c66aefea124cc08b76ea6d30bb', 'test', '0', '25', '18707173376', '1', '0', '6', '2015-12-06 13:13:03');
INSERT INTO `user` VALUES ('16', 'chenjian', '陈建', 'f6ce866df1e950c80166cf8f1fe585cf', 'b70adfa7-11c8-4519-a58f-d18f797ce52f', '0', '23', '648731658315', '1', '0', '7', '2017-09-03 16:02:31');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(19) NOT NULL COMMENT '用户id',
  `role_id` bigint(19) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `idx_user_role_ids` (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('67', '1', '1');
INSERT INTO `user_role` VALUES ('68', '1', '2');
INSERT INTO `user_role` VALUES ('69', '1', '7');
INSERT INTO `user_role` VALUES ('70', '1', '8');
INSERT INTO `user_role` VALUES ('63', '13', '2');
INSERT INTO `user_role` VALUES ('64', '14', '7');
INSERT INTO `user_role` VALUES ('53', '15', '8');
INSERT INTO `user_role` VALUES ('66', '16', '8');
