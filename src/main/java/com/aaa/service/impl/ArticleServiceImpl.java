package com.aaa.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.mapper.ArticleMapper;
import com.aaa.model.Article;
import com.aaa.service.ArticleService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
@Service
public class ArticleServiceImpl implements ArticleService {
	@Resource(name="articleMapper")
	ArticleMapper articleMapper;
	
	@Override
	public boolean add(Article article) {
		// TODO Auto-generated method stub
		return articleMapper.add(article);
	}

	@Override
	public boolean del(String id) {
		// TODO Auto-generated method stub
		return articleMapper.del(id);
	}

	@Override
	public boolean update(Article article) {
		// TODO Auto-generated method stub
		return articleMapper.update(article);
	}

	@Override
	public void selectAll(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map> list = articleMapper.selectAll(page);
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
		//return articleMapper.selectAll(pageInfo);
	}

	@Override
	public List<Map> selectOne(String id) {
		// TODO Auto-generated method stub
		return articleMapper.selectOne(id);
	}

}
