package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import com.aaa.model.TblClass;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author chenjian
 * @since 2017-09-13
 */
public interface TblClassMapper extends BaseMapper<TblClass> {
	List<Map<String, Object>> selectClassPage(Pagination page, Map<String, Object> params);
	List<String> selectTeacherByClassId(Long id);
	List<TblClass> selectAllClass();
	List<Map> selectAllClassMap(Map<String,String> map);
	Long insertClass(TblClass tblClass);
	void insertClassTeacher(Map map);
	TblClass selectClassById(Long id);
	void updateClass(TblClass tblClass);
	void deleteClassTeacherByClassId(Long id);

List<Map> selectByClassid(@Param("class_id") Long classid);
	
	@Select("select t.user_id from  tbl_user_class t left join user u on u.id = t.user_id where t.class_id = #{class_id} and u.status=0")
	@ResultType(Long.class)
	List<Long> selectUseridListByClassid(@Param("class_id") Long classid);
	
	@Delete("DELETE FROM tbl_user_class WHERE class_id=#{class_id}")
	int deleteByClassId(@Param("class_id") Long classid);
	
	@Delete("DELETE FROM tbl_user_class WHERE class_id=#{class_id} and user_id=#{user_id}")
	int deleteByClassIdAndUserid(@Param("class_id") Long classid,@Param("user_id") Long userid);
	@Select("select id,classname from tbl_class where classname = #{classname}")
	@ResultType(TblClass.class)
	List<TblClass> selectByClassname(String classname);
}