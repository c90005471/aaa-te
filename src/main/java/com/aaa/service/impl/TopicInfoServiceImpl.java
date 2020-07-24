package com.aaa.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaa.commons.result.PageInfo;
import com.aaa.commons.result.Tree;
import com.aaa.mapper.TopicInfoMapper;
import com.aaa.mapper.TopicOptionMapper;
import com.aaa.mapper.TopicTypesMapper;
import com.aaa.model.TopicInfo;
import com.aaa.model.TopicOption;
import com.aaa.model.TopicTypes;
import com.aaa.model.vo.TopicInfoExcelVo;
import com.aaa.model.vo.TopicInfoVo;
import com.aaa.service.ITopicInfoService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
/**
 * 类名称：TopicInfoServiceImpl
 * 类描述： 
 * 创建人：sunshaoshan
 * 创建时间：2018-6-30 下午3:01:02
 * @version
 */
@Service
public class TopicInfoServiceImpl extends ServiceImpl<TopicInfoMapper,TopicInfo> implements ITopicInfoService{


	@Autowired
	private TopicInfoMapper topicInfoMapper;
	@Autowired
	private TopicTypesMapper topicTypesMapper;
	@Autowired
	private TopicOptionMapper topicOptionMapper;
	/**
	 * 查询列表信息
	 */
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = topicInfoMapper.selectTopicInfoPage(page, pageInfo.getCondition());
        //获取试题类型
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	/**
	 * 获取题目类型
	 */
	@Override
	public Map<Integer, String> selectTopicTypes() {
		List<TopicTypes> typesList =  topicTypesMapper.selectByMap(null);
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (TopicTypes topicTypes : typesList) {
			map.put(Integer.valueOf(topicTypes.getId()+""), topicTypes.getTypename());
		}
		return map;
	}
	/**
	 * 保存题目信息
	 */
	@Override
	public void insertQuestionAndOption(TopicInfo info, String[] optionnum,String[] options, String score,Long userId) {
		info.setCreator(userId);
		info.setCreatetime(new Date());
		topicInfoMapper.insertTopicInfo(info);
		//保存选项信息
		for (int i=0;i<options.length;i++) {
			TopicOption option = new TopicOption();
			option.setInfoid(info.getId());
			option.setOptionnum(optionnum[i]);
			option.setOption(options[i]);
			topicOptionMapper.insert(option);
		}
	}
	/**
	 * 获取题目选项信息
	 */
	@Override
	public List<TopicOption> selectTopicOptionListByInfoId(Long id) {
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("infoid", id);
		List<TopicOption> list = topicOptionMapper.selectByMap(columnMap);
		return list;
	}
	/**
	 * 修改试题信息
	 */
	@Override
	public void updateTopInfoAndOption(TopicInfo info, String[] optionnum,String[] options, String[] option2) {
		info.setCreatetime(new Date());
		topicInfoMapper.updateById(info);
		//删除对应的选项信息
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("infoid", info.getId());
		topicOptionMapper.deleteByMap(columnMap);
		//保存选项信息
		for (int i=0;i<options.length;i++) {
			TopicOption option = new TopicOption();
			option.setInfoid(info.getId());
			option.setOptionnum(optionnum[i]);
			option.setOption(options[i]);
			topicOptionMapper.insert(option);
		}
	}
	/**
	 * 删除试题信息
	 */
	@Override
	public void deleteTopInfoAndOption(Long id) {
		//删除选项信息
		Map<String,Object> columnMap = new HashMap<String,Object>();
		columnMap.put("infoid", id);
		topicOptionMapper.deleteByMap(columnMap);
		//删除试题信息
		topicInfoMapper.deleteById(id);
	}
	/**
	 * 处理试题vo信息
	 */
	@Override
	public List<TopicInfoVo> selectTopicInfoVoList(List<TopicInfoVo> topicInfoList) {
		for (TopicInfoVo topicInfoVo : topicInfoList) {
			//试题类型
			topicInfoVo.setType(topicInfoVo.getType().equals("0")?"单选题":"多选题");
			//选项
			Map<String,Object> columnMap = new HashMap<String,Object>();
			columnMap.put("infoid", topicInfoVo.getId());
			List<TopicOption> optionList = topicOptionMapper.selectByMap(columnMap);
			if(optionList!=null&&optionList.size()>0){
				topicInfoVo.setOptionA(optionList.get(0).getOption());
				topicInfoVo.setOptionB(optionList.get(1).getOption());
				topicInfoVo.setOptionC(optionList.get(2).getOption());
				topicInfoVo.setOptionD(optionList.get(3).getOption());
			}
		}
		return topicInfoList;
	}
	
	@Override
	public List<Tree> selectTree(String stage) {
		Map<String,Object> map = new HashMap<String,Object>();
//		if(StringUtils.isBlank(stage)){
//			stage ="S3";
//		}
//		map.put("stage", stage);
		map.put("typestate", 1);
	  List<TopicTypes> typeList = topicTypesMapper.selectByMap(map);//获取所有班级和组织信息
      List<Tree> trees = new ArrayList<Tree>();
       if (typeList!=null&&typeList.size()>0) {
            for (TopicTypes type : typeList) {
                Tree tree = new Tree();
                tree.setId(type.getId());
                tree.setText(type.getTypename());
                //tree.setIconCls(tblClass.get("iconCls")+"");
                tree.setPid(0l);
                trees.add(tree);
            }
        }
        return trees;
	}
	/**
	 * 保存从excel中导入的题目信息
	 */
	@Override
	public boolean addTopicInfoAndOption(List<TopicInfoExcelVo> excelToList,Long topictype,Long userId) {
		try {
			for (TopicInfoExcelVo vo : excelToList) {
				//题目信息
				TopicInfo info = new TopicInfo();
				info.setTopicname(vo.getTopicname());
				info.setTopictype(topictype);
				info.setCorrect(vo.getCorrect());
				info.setType(vo.getType().equals("单选题")?0:1);
				if (vo.getDifficulty().equals("简单")){
					info.setDifficulty("0");
				}
				if (vo.getDifficulty().equals("中等")){
					info.setDifficulty("1");
				}
				if (vo.getDifficulty().equals("困难")){
					info.setDifficulty("2");
				}
				info.setCreator(userId);
				info.setCreatetime(new Date());
				info.setScore(2);
				topicInfoMapper.insertTopicInfo(info);
				//选项信息
				if(StringUtils.isNotBlank(vo.getOptionA())){
					TopicOption optionA = new TopicOption();
					optionA.setInfoid(info.getId());
					optionA.setOptionnum("A");
					optionA.setOption(vo.getOptionA());
					topicOptionMapper.insert(optionA);
				}
				if(StringUtils.isNotBlank(vo.getOptionB())){
					TopicOption optionB = new TopicOption();
					optionB.setInfoid(info.getId());
					optionB.setOptionnum("B");
					optionB.setOption(vo.getOptionB());
					topicOptionMapper.insert(optionB);
				}
				if(StringUtils.isNotBlank(vo.getOptionC())){
					TopicOption optionC = new TopicOption();
					optionC.setInfoid(info.getId());
					optionC.setOptionnum("C");
					optionC.setOption(vo.getOptionC());
					topicOptionMapper.insert(optionC);
				}
				if(StringUtils.isNotBlank(vo.getOptionD())){
					TopicOption optionD = new TopicOption();
					optionD.setInfoid(info.getId());
					optionD.setOptionnum("D");
					optionD.setOption(vo.getOptionD());
					topicOptionMapper.insert(optionD);
				}
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
