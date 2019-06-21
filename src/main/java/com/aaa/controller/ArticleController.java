package com.aaa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aaa.commons.base.BaseController;
import com.aaa.commons.result.PageInfo;
import com.aaa.model.Article;
import com.aaa.service.ArticleService;

/**
 * <p>
 * 文章  前端控制器
 * </p>
 * @author aaa.teacher
 * @since 2017-04-26
 */
@Controller
@RequestMapping("/article")
public class ArticleController extends BaseController{
    
    /**
     * 注意：BaseController 中有xss过滤，会处理掉 ueditor 中的html
     * 
     * 所以你可以不继承它，或者注释掉BaseController中防止xss的代码
     * 
     * 毕竟管理平台几乎都是内网
     * 
     */
	@Resource(name="articleServiceImpl")
	ArticleService articleService;
    @GetMapping("create")
    public String create() {
        return "admin/article/create";
    }
	/***
	 * 返回到文章列表jsp
	 * @return
	 */
	@GetMapping("/manager")
    public String manager() {
        return "admin/article/articleList";
    }

    /***
     * 去添加文章的jsp页面
     * @return
     */
    @GetMapping("toAdd")
    public String toAdd(){
    	return "admin/article/articleAdd";
    }
    /***
     * 去更新文章的jsp页面
     * @return
     */
    @GetMapping("toUpdate")
    public String toUpdate(String id,HttpServletRequest request){
    	List<Map> selectOne = articleService.selectOne(id);
    	Map map = selectOne.get(0);
    	String content = (String)map.get("content");
    	String unescapeHtml = StringEscapeUtils.unescapeHtml4(content);
    	map.put("content", unescapeHtml);
    	request.setAttribute("article", map);
    	return "admin/article/articleUpdate";
    }
    /***
     * 显示文章列表的jsp页面
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @RequestMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order){
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);
    	Map<String, Object> condition = new HashMap<String, Object>();
        pageInfo.setCondition(condition);
    	articleService.selectAll(pageInfo);
    	
    	return pageInfo;
    }
    /***
     * 添加一篇新文章
     * @param article
     * @return
     */
    @RequestMapping("/add")
    @ResponseBody
    public Object add(Article article){
        boolean b = articleService.add(article);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    /***
     * 删除一个或多篇文章
     * @param ids
     * @return
     */
    @PostMapping("/delArticle")
    @ResponseBody
    public Object delArticle(String idsStr){
    	 boolean b = articleService.del(idsStr);
         if (b) {
             return renderSuccess("删除成功！");
         } else {
             return renderError("删除失败！");
         }
    }
    @RequestMapping("/update")
    @ResponseBody
    public Object update(Article article){
    	boolean b = articleService.update(article);
    	System.out.println(article.toString());
        if (b) {
            return renderSuccess("更新成功！");
        } else {
            return renderError("更新失败！");
        } 
    }
    @RequestMapping("/toShow")
    public Object toShow(String id,HttpServletRequest request){
    	List<Map> selectOne = articleService.selectOne(id);
    	Map map = selectOne.get(0);
    	String content = (String)map.get("content");
    	String unescapeHtml = StringEscapeUtils.unescapeHtml4(content);
    	map.put("content", unescapeHtml);
    	request.setAttribute("article", map);
    	return "admin/article/article";
    }
  
}
