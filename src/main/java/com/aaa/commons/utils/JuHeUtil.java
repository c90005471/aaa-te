package com.aaa.commons.utils;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

/**
*身份证查询调用示例代码 － 聚合数据
*在线接口文档：http://www.juhe.cn/docs/38
**/
 
public class JuHeUtil {
    public static final String DEF_CHATSET = "UTF-8";
    public static final int DEF_CONN_TIMEOUT = 30000;
    public static final int DEF_READ_TIMEOUT = 30000;
    public static String userAgent =  "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36";
 
  //配置您申请的KEY
    public static final String APPKEY ="bee0cb801c72784a62b3ad0e02066f5a";
 
  //1.身份证信息查询
    public static String getRequest1(String IDCard){
        String result =null;
        String url ="http://apis.juhe.cn/idcard/index";//请求接口地址
        Map params = new HashMap();//请求参数
            params.put("cardno",IDCard);//身份证号码
            params.put("dtype","");//返回数据格式：json或xml,默认json
            params.put("key",APPKEY);//你申请的key
 
        try {
            result =net(url, params, "GET");
            JSONObject object = JSONObject.fromObject(result);
            if(object.getInt("error_code")==0){
            	//System.out.println(object.get("result"));
            	if(object.get("result")!=null){
            		String s=object.get("result")+"";
            		String[] split = s.split(",");
            		String[] split2 = split[2].split("\"");
            		//System.out.println(split2[3]);
            		return split2[3];
            	}
            	
            }else{
                System.out.println(object.get("error_code")+":"+object.get("reason"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
 
  //2.身份证泄漏查询
    public static void getRequest2(){
        String result =null;
        String url ="http://apis.juhe.cn/idcard/leak";//请求接口地址
        Map params = new HashMap();//请求参数
            params.put("cardno","");//身份证号码
            params.put("dtype","");//返回数据格式：json或xml,默认json
            params.put("key",APPKEY);//你申请的key
 
        try {
            result =net(url, params, "GET");
            JSONObject object = JSONObject.fromObject(result);
            if(object.getInt("error_code")==0){
                System.out.println(object.get("result"));
            }else{
                System.out.println(object.get("error_code")+":"+object.get("reason"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
  //3.身份证挂失查询
    public static void getRequest3(){
        String result =null;
        String url ="http://apis.juhe.cn/idcard/loss";//请求接口地址
        Map params = new HashMap();//请求参数
            params.put("cardno","");//身份证号码
            params.put("dtype","");//返回数据格式：json或xml,默认json
            params.put("key",APPKEY);//你申请的key
 
        try {
            result =net(url, params, "GET");
            JSONObject object = JSONObject.fromObject(result);
            if(object.getInt("error_code")==0){
                System.out.println(object.get("result"));
            }else{
                System.out.println(object.get("error_code")+":"+object.get("reason"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
 
 
    public static void main(String[] args) {
//    	List<Map> list=new StuServiceImpl().fillAllHighStu();
//    	List list2=new ArrayList();
//    	for(Map map:list){
//    		String request1 = getRequest1(map.get("idno")+"");
//    		System.out.println(request1);
//    	}
    	
    }
 
    /**
    *
    * @param strUrl 请求地址
    * @param params 请求参数
    * @param method 请求方法
    * @return  网络请求字符串
    * @throws Exception
    */
    public static String net(String strUrl, Map params,String method) throws Exception {
        HttpURLConnection conn = null;
        BufferedReader reader = null;
        String rs = null;
        try {
            StringBuffer sb = new StringBuffer();
            if(method==null || method.equals("GET")){
                strUrl = strUrl+"?"+urlencode(params);
            }
            URL url = new URL(strUrl);
            conn = (HttpURLConnection) url.openConnection();
            if(method==null || method.equals("GET")){
                conn.setRequestMethod("GET");
            }else{
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
            }
            conn.setRequestProperty("User-agent", userAgent);
            conn.setUseCaches(false);
            conn.setConnectTimeout(DEF_CONN_TIMEOUT);
            conn.setReadTimeout(DEF_READ_TIMEOUT);
            conn.setInstanceFollowRedirects(false);
            conn.connect();
            if (params!= null && method.equals("POST")) {
                try {
                    DataOutputStream out = new DataOutputStream(conn.getOutputStream());
                        out.writeBytes(urlencode(params));
                } catch (Exception e) {
                    // TODO: handle exception
                }
            }
            InputStream is = conn.getInputStream();
            reader = new BufferedReader(new InputStreamReader(is, DEF_CHATSET));
            String strRead = null;
            while ((strRead = reader.readLine()) != null) {
                sb.append(strRead);
            }
            rs = sb.toString();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                reader.close();
            }
            if (conn != null) {
                conn.disconnect();
            }
        }
        return rs;
    }
 
  //将map型转为请求参数型
    public static String urlencode(Map<String,Object>data) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry i : data.entrySet()) {
            try {
                sb.append(i.getKey()).append("=").append(URLEncoder.encode(i.getValue()+"","UTF-8")).append("&");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }
    /***
     * 获取省
     * @param areaNo
     * @return
     */
    public static String getProvince(String areaNo){
    	if("41".equals(areaNo)){
    		return "河南";
    	}else if("42".equals(areaNo)){
    		return "湖北";
    	}else if("43".equals(areaNo)){
    		return "湖北";
    	}else if("44".equals(areaNo)){
    		return "广东";
    	}else if("45".equals(areaNo)){
    		return "广西";
    	}else if("46".equals(areaNo)){
    		return "海南";
    	}else if("50".equals(areaNo)){
    		return "重庆";
    	}else if("51".equals(areaNo)){
    		return "四川";
    	}else if("52".equals(areaNo)){
    		return "贵州";
    	}else if("53".equals(areaNo)){
    		return "云南";
    	}else if("54".equals(areaNo)){
    		return "西藏";
    	}else if("61".equals(areaNo)){
    		return "陕西";
    	}else if("62".equals(areaNo)){
    		return "甘肃";
    	}else if("63".equals(areaNo)){
    		return "青海";
    	}else if("64".equals(areaNo)){
    		return "宁夏";
    	}else if("65".equals(areaNo)){
    		return "新疆";
    	}else if("11".equals(areaNo)){
    		return "北京";
    	}else if("12".equals(areaNo)){
    		return "天津";
    	}else if("13".equals(areaNo)){
    		return "河北";
    	}else if("14".equals(areaNo)){
    		return "山西";
    	}else if("15".equals(areaNo)){
    		return "内蒙古";
    	}else if("21".equals(areaNo)){
    		return "辽宁";
    	}else if("22".equals(areaNo)){
    		return "吉林";
    	}else if("23".equals(areaNo)){
    		return "黑龙江";
    	}else if("31".equals(areaNo)){
    		return "上海";
    	}else if("32".equals(areaNo)){
    		return "江苏";
    	}else if("33".equals(areaNo)){
    		return "浙江";
    	}else if("34".equals(areaNo)){
    		return "安徽";
    	}else if("35".equals(areaNo)){
    		return "福建";
    	}else if("36".equals(areaNo)){
    		return "江西";
    	}else if("37".equals(areaNo)){
    		return "山东";
    	}else if("71".equals(areaNo)){
    		return "台湾";
    	}else if("81".equals(areaNo)){
    		return "香港";
    	}
    	return "";
    }
    /***
     * 获取城市
     * @param cityNo
     * @return
     */
    public static String getCity(String cityNo){
    	if("01".equals(cityNo)){
    		return "郑州市";
    	}else if("02".equals(cityNo)){
    		return "开封市";
    	}else if("03".equals(cityNo)){
    		return "洛阳市";
    	}else if("04".equals(cityNo)){
    		return "平顶山市";
    	}else if("05".equals(cityNo)){
    		return "安阳市";
    	}else if("06".equals(cityNo)){
    		return "鹤壁市";
    	}else if("07".equals(cityNo)){
    		return "新乡市";
    	}else if("08".equals(cityNo)){
    		return "焦作市";
    	}else if("09".equals(cityNo)){
    		return "濮阳市";
    	}else if("10".equals(cityNo)){
    		return "许昌市";
    	}else if("11".equals(cityNo)){
    		return "漯河市";
    	}else if("12".equals(cityNo)){
    		return "三门峡市";
    	}else if("13".equals(cityNo)){
    		return "南阳市";
    	}else if("14".equals(cityNo)){
    		return "商丘市";
    	}else if("15".equals(cityNo)){
    		return "信阳市";
    	}else if("16".equals(cityNo)){
    		return "周口市";
    	}else if("17".equals(cityNo)){
    		return "驻马店市";
    	}else if("27".equals(cityNo)){
    		return "周口市";
    	}else if("23".equals(cityNo)){
    		return "商丘市";
    	}else if("28".equals(cityNo)){
    		return "驻马店市";
    	}else if("30".equals(cityNo)){
    		return "信阳市";
    	}else if("24".equals(cityNo)){
    		return "开封市";
    	}else if("25".equals(cityNo)){
    		return "三门峡市";
    	}else if("26".equals(cityNo)){
    		return "许昌市";
    	}else if("29".equals(cityNo)){
    		return "南阳市";
    	}else if("93".equals(cityNo)){
    		return "济源市";
    	}
    	return "";
    }
}