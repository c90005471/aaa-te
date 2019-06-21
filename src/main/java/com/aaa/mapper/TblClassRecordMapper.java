package com.aaa.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import com.aaa.model.TblClassRecord;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author sunshaoshan
 * @since 2017-10-17
 */
public interface TblClassRecordMapper extends BaseMapper<TblClassRecord> {
	List<TblClassRecord> selectAllTblClassRecord();
	Long insertTblClassRecord(TblClassRecord tblClassRecord);
	@Select("select r.userid from  tbl_class_record r left join user t on t.id = r.userid where t.status =0 and class_id = #{class_id}")
	@ResultType(Long.class)
	List<Long> selectUserIdListByClassId(@Param("class_id") Long classid);
}