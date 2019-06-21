package com.aaa.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.Article;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

public interface ArticleMapper {
	/***
	 * 添加多篇文章
	 * @param article
	 * @return
	 */
	boolean add(Article article);
	/***
	 * 删除一篇或者多篇
	 * @param id
	 * @return
	 */
	boolean del(@Param(value="id")String id);
	/***
	 * 更新一篇文章
	 * @param article
	 * @return
	 */
	boolean update(Article article);
	/***
	 * 获取所有文章列表
	 * @param page
	 * @return
	 */
	List<Map> selectAll(Pagination page);
	/***
	 * 获取一篇文章列表
	 * @param page
	 * @return
	 */
	List<Map> selectOne(String id);
}
