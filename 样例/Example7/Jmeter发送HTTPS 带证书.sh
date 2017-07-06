Jmeter发送HTTPS 带证书{

E:\apache-jmeter-2.12\bin\jmeter.properties 中修改对应的规则，apimgt支持的是TLSv1.2
https.default.protocol=SSLv3
https.default.protocol=TLSv1.2

配置证书方法1：
修改E:\apache-jmeter-2.12\bin\system.properties
javax.net.ssl.keyStore=E:\\apache-jmeter-2.12\\lgj_works\\cert\\my.p12
javax.net.ssl.keyStorePassword=huawei123

配置证书方法2：
选项--ssl管理器--导入秘钥  第一次访问时会需要输入keystone 密码

注意 测试计划--HTTP请求--HTTP请求--ImpLementation选择 HttpClient3.1 协议HTTPS,其他的和HTTP发送请求一样。 
证书支持.p12 格式的
openssl pkcs12 -export -inkey private.key -in client.crt -CAfile ca-cert.pem -chain -out myclient.p12

}
