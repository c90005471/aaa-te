package com.aaa.commons.redis;

import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.apache.ibatis.cache.Cache;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.connection.jedis.JedisConnection;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializer;

import redis.clients.jedis.Jedis;

/**
 * @author chenjian
 * @description 使用第三方缓存服务器，处理二级缓存
 * @company AAA软件
 * 2017-6-29下午2:16:56
 */
public class RedisCache implements Cache {

	private static JedisConnectionFactory jedisConnectionFactory;
    private final String id;
    
    
    private final ReadWriteLock readWriteLock = new ReentrantReadWriteLock();
    
    public RedisCache(final String id){
        if (id == null) {
            throw new IllegalArgumentException("cache instances require an ID");
        }
        this.id = id;
    }
    

    /**
     * 
    	* @description: 清空redis缓存
    	* @author 
    	* @param 
    	* @return
     */
    @Override
    public void clear() {
    	RedisConnection connection = null;
        try {
            connection =  jedisConnectionFactory.getConnection();
            connection.flushDb();
            connection.flushAll();
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if (connection != null) {
                connection.close();
            }
        }
    }

    @Override
    public String getId() {
        return this.id;
    }
    /**
     * 
    	* @description: 根据key换取redis缓存中的值
    	* @author 
    	* @param 
    	* @return
     */
    @Override
    public Object getObject(Object key) {
        System.out.println("--------------------------------key:["+key+"]");
        Object result = null;
        RedisConnection connection = null;
        try {
            connection = jedisConnectionFactory.getConnection();
            RedisSerializer<Object> serializer = new JdkSerializationRedisSerializer();
            result = serializer.deserialize(connection.get(serializer.serialize(key)));
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if (connection != null) {
                connection.close();
            }
        }
        
        return result;
    }

    @Override
    public ReadWriteLock getReadWriteLock() {
        return this.readWriteLock;
    }

    @Override
    public int getSize() {
        int result = 0;
        RedisConnection connection = null;
        try {
            connection = jedisConnectionFactory.getConnection();
            result = Integer.valueOf(connection.dbSize().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if (connection != null) {
                connection.close();
            }
        }
        return result;
    }
    /**
     * 
    	* @description: 将数据保存到redis缓存
    	* @author 
    	* @param 
    	* @return
     */
    @Override
    public void putObject(Object key, Object value) {
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>key:"+key);
          
        RedisConnection connection = null;
        try {
            connection = jedisConnectionFactory.getConnection();
            RedisSerializer<Object> serializer = new JdkSerializationRedisSerializer();
            System.out.println("**"+serializer.serialize(key));
            connection.set(serializer.serialize(key), serializer.serialize(value));
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if (connection != null) {
                connection.close();
            }
        }
        
    }
    /**
     * 
    	* @description: 根据key清除redis缓存中对应 的值
    	* @author 
    	* @param 
    	* @return
     */
    @Override
    public Object removeObject(Object key) {
    	RedisConnection connection = null;
        Object result = null;
        try {
            connection = jedisConnectionFactory.getConnection();
            RedisSerializer<Object> serializer = new JdkSerializationRedisSerializer();
            result = connection.expireAt(serializer.serialize(key), 0);
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if (connection != null) {
                connection.close();
            }
        }
        return result;
    }
    public static void setJedisConnectionFactory(JedisConnectionFactory jedisConnectionFactory) {
        RedisCache.jedisConnectionFactory = jedisConnectionFactory;
    }
    
    public static void main(String[] args) {
    	Jedis jedis = new Jedis("192.168.153.115", 6379);
    	jedis.set("aaa", "I love you !");
		/*jedis.set("name2", "mrdg2");
		jedis.set("age2", "242");*/
		System.out.println("aaa:"+jedis.get("aaa"));
		/*System.out.println("age1:"+jedis.get("age2"));
		System.out.println("tel:"+jedis.get("Tel"));*/
    	 
	}
}