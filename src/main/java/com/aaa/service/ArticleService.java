package com.aaa.service;

import java.util.List;
import java.util.Map;

import com.aaa.commons.result.PageInfo;
import com.aaa.model.Article;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

public interface ArticleService {
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
	boolean del(String id);
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
	void selectAll(PageInfo pageInfo);
	/***
	 * 获取一篇文章列表
	 * @param page
	 * @return
	 */
	List<Map> selectOne(String id);
}
