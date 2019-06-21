/*
Navicat MySQL Data Transfer

Source Server         : yyl
Source Server Version : 50524
Source Host           : localhost:3306
Source Database       : aaa

Target Server Type    : MYSQL
Target Server Version : 50524
File Encoding         : 65001

Date: 2018-06-09 13:02:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_class`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_class`;
CREATE TABLE `tbl_class` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '班级id',
  `classname` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '班级名',
  `createtime` datetime DEFAULT NULL COMMENT '开班时间',
  `graduate` tinyint(2) DEFAULT NULL COMMENT '班级状态（是否毕业等）',
  `orgid` bigint(19) NOT NULL COMMENT '校区表外键',
  `begin` datetime DEFAULT NULL COMMENT '班级的开班时间',
  `over` datetime DEFAULT NULL COMMENT '班级的毕业时间',
  `firstbegin` datetime DEFAULT NULL COMMENT '第一次项目的开始时间',
  `firstover` datetime DEFAULT NULL COMMENT '第一次项目的结束时间',
  `secondbegin` datetime DEFAULT NULL COMMENT '第二次项目的开始时间',
  `secondover` datetime DEFAULT NULL COMMENT '第二次项目的结束时间',
  PRIMARY KEY (`id`),
  KEY `orgid` (`orgid`) USING BTREE,
  CONSTRAINT `tbl_class_ibfk_1` FOREIGN KEY (`orgid`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100143 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tbl_class
-- ----------------------------
INSERT INTO `tbl_class` VALUES ('100000', 'QY69', '2017-11-09 08:44:49', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100001', 'QY70', '2017-11-17 14:11:20', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100002', 'QY71', '2017-12-26 14:30:20', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100008', 'QY73', '2018-03-27 10:40:30', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100009', 'QY68', '2017-11-10 16:04:05', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100010', 'QY66', '2017-10-16 16:21:42', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100011', 'QY67', '2017-10-13 08:56:55', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100012', 'QY74', '2018-03-27 10:40:35', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100013', 'QY75', '2018-03-27 10:40:41', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100014', 'GS389/GS390', '2018-03-26 11:55:00', '1', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100015', 'A213', '2018-03-26 12:42:26', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100016', 'A216', '2018-03-26 12:42:15', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100017', 'GS398', '2017-12-27 18:20:16', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100019', 'GS393/GS394', '2018-04-08 14:32:19', '1', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100020', 'A215', '2018-04-08 14:22:52', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100021', 'A212', '2018-05-24 13:56:46', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100022', 'A307', '2018-05-24 09:15:21', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100023', 'A302', '2018-05-24 10:48:26', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100025', 'GS397', '2018-05-24 10:48:56', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100026', 'GS391/392', '2018-03-26 12:00:25', '1', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100027', 'GS395/396', '2018-03-26 12:04:11', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100028', 'A303', '2018-05-24 10:48:07', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100029', 'A305', '2018-05-24 08:59:16', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100030', 'GS387/GS388', '2017-11-24 09:26:56', '1', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100031', 'GS399', '2018-05-23 15:36:12', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100032', 'A309', '2018-04-10 14:26:06', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100033', 'A214', '2018-05-24 10:47:03', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100035', 'A217', '2018-03-26 11:51:24', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100037', 'A301', '2018-04-27 15:20:42', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100039', 'A308', '2018-04-27 15:20:51', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100054', 'A306', '2018-03-26 11:28:56', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100056', 'A304', '2018-04-27 15:20:25', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100057', 'QY72', '2018-03-27 10:40:47', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100062', 'A211', '2018-03-26 16:46:21', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100066', 'A218', '2018-03-26 11:51:36', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100067', 'A310', '2018-05-23 09:46:49', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100068', 'Java1605', '2018-04-02 11:23:02', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100069', 'Java1606', '2018-04-02 11:23:23', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100070', 'Java1601', '2018-04-02 14:33:51', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100071', 'Java1501', '2018-04-02 11:30:20', '1', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100072', 'Java1502', '2018-04-02 11:30:31', '1', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100073', 'Java1503', '2018-04-02 11:30:37', '1', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100074', 'Java1607', '2018-04-02 14:34:07', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100076', 'Java1704', '2018-04-02 11:35:26', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100078', 'Java1703', '2018-05-24 16:16:18', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100079', 'JAVA1706', '2018-04-02 11:36:03', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100080', 'Java1602', '2018-04-02 14:37:18', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100083', 'JAVA1701', '2017-11-01 15:47:46', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100084', 'JAVA1702', '2017-11-01 15:47:56', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100085', 'JAVA1705', '2018-04-02 11:37:36', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100087', 'Java1603', '2018-04-02 14:34:19', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100089', '16移动互联网', '2017-10-24 15:38:50', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100093', 'JAVA1701', '2018-03-28 10:44:51', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100094', 'JAVA1702', '2018-01-18 08:38:34', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100095', 'JAVA1703', '2018-01-18 08:39:12', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100096', 'JAVA1704', '2018-03-28 11:23:41', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100097', 'JAVA1705', '2018-03-28 10:46:00', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100098', 'JAVA1706', '2018-03-28 10:46:15', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100099', 'JAVA1707', '2018-03-28 11:27:21', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100100', 'JAVA1708', '2018-03-28 10:46:52', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100101', '4G1701', '2018-05-30 09:02:10', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100105', 'JAVA1602', '2018-05-30 09:07:47', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100106', 'JAVA1603', '2018-05-30 09:08:30', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100107', 'JAVA1610', '2018-03-28 11:17:16', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100108', 'JAVA1604', '2018-05-30 09:09:07', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100109', 'JAVA1605', '2018-01-18 08:54:50', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100110', 'JAVA1606', '2018-03-28 11:17:48', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100111', 'JAVA1607', '2018-03-28 11:18:01', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100112', 'JAVA1608', '2018-01-18 08:56:04', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100113', 'JAVA1609', '2018-01-18 08:56:21', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100114', '4G1601', '2018-01-18 08:57:34', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100115', 'JAVA1601', '2018-03-28 11:20:24', '0', '10', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100117', 'Java1604', '2017-11-01 16:11:13', '0', '9', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100118', '电子商务大数据1班', '2017-11-02 13:48:22', '0', '13', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100119', '电子商务大数据2班', '2017-11-02 13:48:36', '0', '13', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100120', 'QY76', '2018-04-12 10:18:37', '1', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100121', 'QY77', '2018-04-23 09:39:24', '0', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100122', '异常毕业', '2018-03-27 10:45:08', '0', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100123', 'QY78', '2018-04-23 09:39:50', '0', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100125', 'QY79', '2018-04-23 09:39:58', '0', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100126', 'QY80', '2018-04-23 09:40:04', '0', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100127', '休学班', '2018-03-05 11:19:59', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100128', 'A119', '2018-03-26 17:02:00', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100129', 'QY81', '2018-04-23 09:40:20', '0', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100130', 'QY82', '2018-04-23 09:40:27', '0', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100131', 'GS377/383', '2018-04-09 14:31:18', '1', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100133', 'GS380/384', '2018-04-09 14:04:54', '1', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100134', 'GS374/GS375', '2018-04-09 17:37:12', '1', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100135', 'GS363', '2018-04-09 17:37:03', '1', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100136', 'QY83', '2018-05-23 17:39:22', '0', '6', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100137', 'A120', '2018-04-27 15:17:21', '0', '7', null, null, null, null, null, null);
INSERT INTO `tbl_class` VALUES ('100138', 'qy85', '2018-06-06 20:04:25', '0', '6', '2018-11-10 20:04:21', '2018-11-10 20:04:21', '2018-08-05 08:30:00', '2018-08-31 17:15:00', '2018-09-28 08:30:00', '2018-10-21 17:15:00');
