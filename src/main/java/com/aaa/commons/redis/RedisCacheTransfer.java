package com.aaa.commons.redis;

import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;

public class RedisCacheTransfer {
	public void setJedisConnectionFactory(JedisConnectionFactory jedisConnectionFactory) {
	       RedisCache.setJedisConnectionFactory(jedisConnectionFactory);
	    }

}
