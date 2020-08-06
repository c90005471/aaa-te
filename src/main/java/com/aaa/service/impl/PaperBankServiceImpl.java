package com.aaa.service.impl;

import com.aaa.commons.result.PageInfo;
import com.aaa.mapper.PaperBankMapper;
import com.aaa.model.PaperBank;
import com.aaa.model.PaperInfo;
import com.aaa.model.TopicInfo;
import com.aaa.service.IPaperBankService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service
public class PaperBankServiceImpl extends ServiceImpl<PaperBankMapper, PaperBank> implements IPaperBankService {
    @Autowired
    private PaperBankMapper paperBankMapper;

    @Override
    public void selectDataGrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = paperBankMapper.selectPaperBankPage(page, pageInfo.getCondition());
        //获取试题类型
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }
    @Override
    public void selectDataGridBank(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = paperBankMapper.selectPaperGroup(page, pageInfo.getCondition());
        //获取试题类型
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }

    @Override
    public void deletePaperBank(Long id) {
        Map<String,Object> params=new HashMap<>();
        params.put("paperid",id);
        params.put("id",id);
        paperBankMapper.deletePapers(params);
    }


    @Override
    public void updatePapername(String papername, Long id) {
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        params.put("papername",papername);
        paperBankMapper.updatePapername(params);
    }

    @Override
    public int addPaperByManual(Long userid, Long paperid, Long infoid) {
        int len=0;
        Map<String,Object> params = new HashMap<>();
        Map<String,Object> params1 = new HashMap<>();
        params1.put("id",paperid);
        List<PaperBank> map1 = paperBankMapper.selectByMap(params1);
        params.put("paperid",paperid);
        params.put("infoid",infoid);
        List<PaperBank> map = paperBankMapper.selectByMap(params);
        if (map.size()>0){
            len = -1;
        }else {
            PaperBank info = new PaperBank();
            info.setPaperid(paperid);
            info.setInfoid(infoid);
            info.setCreateby(userid);
            info.setParentid(paperid);
            info.setIsparent(0);
            info.setPapername(map1.get(0).getPapername());
            len = paperBankMapper.insert(info);
        }
        return len;
    }

    @Override
    public void addPapername(Long userId,String papername, Integer isparent) {
        PaperBank paperBank = new PaperBank();
        paperBank.setPapername(papername);
        paperBank.setIsparent(isparent);
        paperBank.setCreateby(userId);
        paperBankMapper.insert(paperBank);
    }

    /**
     * 保存试卷
     */
    /* (non-Javadoc)
     * @see com.aaa.service.IExamPaperService#addExamPaperAndTopicInfo(java.lang.Long, java.lang.String)
     */
    @Override
    public void addExamPaperAndTopicInfo(String paperid,Long userId,String sumStr,String xin,String papername) {
        Map<String,Object> params=new HashMap<>();
        params.put("id",paperid);
        List<Map<String, Object>> list = paperBankMapper.selectPaperGroup(params);
        String papername1 = list.get(0).get("papername").toString();
        savePaperInfo(userId,Long.valueOf(paperid),sumStr,null,papername1);
    }

    @Override
    public List<Map<String, Object>> selectDataGridBank(Map<String, Object> params) {
        List<Map<String, Object>> list = paperBankMapper.selectPaperGroup(params);
        return list;
    }

    /**
     * 保存试卷和试题信息
     * @param id
     * @param sumStr
     * @param infoIdList 原来试卷中试题
     */
    private void savePaperInfo(Long userId,Long id,String sumStr,List<Long> infoIdList,String papername){
        //抽取试题
        if(StringUtils.isNotBlank(sumStr)){
            // 初始化随机数
            //Random rand = new Random();
            //分割科目id#对应抽取的数量
            String [] typeIdAndSums = sumStr.split(";");
            for (String typeIdAndSum : typeIdAndSums) {
                String[] typeIds = typeIdAndSum.split("#");
                //分割科目id 并随机抽取(数量)的试题
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("topictype", typeIds[0]);
                if(StringUtils.isNotBlank(typeIds[1])){
                    map.put("sum", Integer.valueOf(typeIds[1]));
                }
                List<TopicInfo> infoList = paperBankMapper.selectInfoByTypeIdAndSum(map);
                //获取该科目中待选取的试题
//				Map<String,Object> columnMap = new HashMap<String,Object>();
//				columnMap.put("topictype", typeIds[0]);
//				List<TopicInfo> list = topicInfoMapper.selectByMap(columnMap);
//
//				List<Long> idList = new ArrayList<Long>();
//				for (TopicInfo topicInfo : list) {
//					if(infoIdList!=null){//去掉试卷中原有的试题
//						if(!infoIdList.contains(topicInfo.getId())){
//							idList.add(topicInfo.getId());
//						}
//					}else{
//						idList.add(topicInfo.getId());
//					}
//				}
//				if(StringUtils.isNotBlank(typeIds[1])){
//					int size = Integer.valueOf(typeIds[1]);
//					if(size>idList.size()){//如果抽取的数量大于剩余数量,使用该科目的总题数
//						idList = new ArrayList<Long>();
//						for (TopicInfo info : list) {
//							idList.add(info.getId());
//						}
//					}
//					//随机抽取sum道题
//					for(int i=0;i<size;i++){
//						int myRand = rand.nextInt(idList.size());
//						Long infoId = idList.get(myRand);
//						PaperInfo info = new PaperInfo();
//						info.setPaperid(id);
//						info.setInfoid(infoId);
//						paperInfoMapper.insert(info);
//					}
//				}
                //保存试题
                for (TopicInfo topicInfo : infoList) {
                    PaperBank info = new PaperBank();
                    info.setPaperid(id);
                    info.setPapername(papername);
                    info.setInfoid(topicInfo.getId());
                    info.setCreateby(userId);
                    info.setParentid(id);
                    info.setIsparent(0);
                    paperBankMapper.insert(info);
                }
            }
        }
    }
}
