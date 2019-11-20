package com.aaa.config;


/**
 * @Company AAA软件教育
 * @Author ky
 * @Date Create in 2019/8/31 16:34
 * @Description
 **/
public class FtpProperties {

    private String host = "47.101.150.87";
    private String port = "21";
    private String username = "ftpuser";
    private String password = "123456";
    private String basePath = "/home/cdn-ryan/ftp/";

    public String getHost() {
        return host;
    }

    public String getPort() {
        return port;
    }

    public String getUsername() {
        return username;
    }


    public String getPassword() {
        return password;
    }


    public String getBasePath() {
        return basePath;
    }


    @Override
    public String toString() {
        return "FtpProperties{" +
                "host='" + host + '\'' +
                ", port='" + port + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", basePath='" + basePath + '\'' +
                '}';
    }
}
