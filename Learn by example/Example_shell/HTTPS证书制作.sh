制作服务端、客户端证书
{
#根证书 ca-cert.pem ca-key.pem 是服务端和业务端相同的(先制作根证书、再分别制作服务端、客户端证书并用根证书签发、再再cat、copy到相应地方)
# http://www.cnblogs.com/Anker/p/6018032.html
mkdir CA
mkdir CA/service
mkdir CA/client
cd CA/
1.生成根证书(根证书是服务端和客户端共用的)
{
生成CA根证书“ca-key.pem”
openssl genrsa -out ca-key.pem 2048 -sha256
openssl req -new -out ca-req.csr -key ca-key.pem -sha256    >>#这一步 server's' hostname 必须填服务端的IP
openssl x509 -req -in ca-req.csr -out ca-cert.pem -signkey ca-key.pem -days 3650 -sha256  #3650表示10年，可以改成2天
}
cp ca-cert.pem  ca-key.pem ./service
cd service
2.生成经过根证书签名的  #服务端证书
{
2.1 生成私钥“private.key”
openssl genrsa  -aes256 -out private.key 2048 -sha256

2.2.生成证书签名请求文件“certsignreqfile.csr” Common Name (eg, your name or your server's' hostname) []:10.175.102.162  #如果是制作业务平面的证书，双机请输入业务平面的浮动IP地址，单机请输入业务平面的物理IP地址。
openssl req -new -key private.key -out certsignreqfile.csr -sha256

2.3.生成服务器端证书“server.crt”（未经过根证书签名）
openssl x509 -req -days 3650 -in certsignreqfile.csr -signkey private.key -out server.crt -sha256

2.4 #生成经过签名的服务器证书“server.crt”
openssl x509 -req -in certsignreqfile.csr -out server.crt -signkey private.key -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -days 3650 -sha256

cat server.crt private.key | tee business.pem
}

3.经过根证书签名的  #客户端证书
cd ..
cp ca-cert.pem  ca-key.pem ./client
cd client
{
3.1 生成私钥“private.key”
openssl genrsa  -aes256 -out private.key 2048 -sha256  #访问时需要输密码
openssl genrsa  -out private.key 2048 -sha256  	       #使用curl访问时不需要输密码
3.2.生成证书签名请求文件“certsignreqfile.csr” Common Name (eg, your name or your server's' hostname) []:10.175.102.162  #其实客户端这里可以随便填
openssl req -new -key private.key -out certsignreqfile.csr -sha256

3.3.生成客户端证书“client.crt”（未经过根证书签名）
openssl x509 -req -days 3650 -in certsignreqfile.csr -signkey private.key -out client.crt -sha256

3.4. #生成经过签名的客户端证书 client.crt  
openssl x509 -req -in certsignreqfile.csr -out client.crt -signkey private.key -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -days 3650 -sha256

cat client.crt private.key | tee client.pem
}

4.
如果是制作业务平面证书，请命名为MGTHAcert.pem。
#mv business.pem MGTHAcert.pem
请导出MGTHAcert.pem和ca-key.pem，供后续使用。
如果是制作Internet平面的证书，请命名为SRVHAcert.pem。
#mv business.pem SRVHAcert.pem
请导出SRVHAcert.pem和ca-key.pem，供后续使用。
cd ../service/
cp business.pem MGTHAcert.pem
cp business.pem SRVHAcert.pem
#双向认证需要copy下面两组文件
chown topus:topus *
cp MGTHAcert.pem ca-cert.pem  /opt/topus/plugins/haproxy_mgt/cert/
cp SRVHAcert.pem ca-cert.pem  /opt/topus/plugins/haproxy_srv/cert/
#若只是单向的话，不用copy  ca-cert.pem

5. 证书替换
进入制作证书的目录，拷贝证书到指定目录。
# cp MGTHAcert.pem /opt/topus/plugins/haproxy_mgt/cert/
执行如下命令完成替换。
# cd /opt/topus/plugins/haproxy_mgt/ 
# ./update_cert.sh mgt
回显如下，请根据提示输入密码：
Whether to enter a password(y/n): y 
Please enter your password: 
update haproxy_mgt certificate SUCCESS

#管理口证书验证
curl -v -E ./client.pem --cacert ./ca-cert.pem -X POST -H "Authorization: Basic cHJvdmlkZXI6UHYmODlJam4=" -H "Content-Type: application/json" -d '[["POST"],["{1.1.0}"]]' 'https://10.175.102.225:9543/apimgt/api/v1/?name=API_south_1&context=/test/localhost/https&version=1.0.0&quota=60-30&catalog=ZCY'

curl -v -E ./client.pem --cacert ./ca-cert.pem -X DELETE -H "Authorization: Basic cHJvdmlkZXI6UHYmODlJam4=" -H "Content-Type: application/json" 'https://10.175.102.225:9543/apimgt/api/v1/?name=API_south_1&version=1.0.0&quota=60-30&catalog=ZCY'

curl -v  -X POST -H "Authorization: Basic cHJvdmlkZXI6UHYmODlJam4=" -H "Content-Type: application/json" -d '[["POST"],["{1.1.0}"]]' 'http://10.175.102.225:9580/apimgt/api/v1/?name=API_south_2&context=/test/localhost/https2&version=1.0.0&quota=60-30&catalog=ZCY'
#业务口证书校验
curl -k -v -X POST -H "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" -H "Content-Type:application/json" -H "app_key:48muuJkPJuDedh8t5sVypY39evsa" -H "access_token:token1" 'http://9.91.53.104:8580/iocm/app/reg/v1.0' -d "{\"nodeIddeviceId\":\"1G1BL52P7TR115520\",\"verifyCode\":\"13521211212\",\"timeout\":0}"

curl -v -E ./client.pem --cacert ./ca-cert.pem  -X POST -H "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" -H "Content-Type:application/json" -H "app_key:48muuJkPJuDedh8t5sVypY39evsa" -H "access_token:token1" 'https://9.91.53.104:8543/iocm/app/reg/v1.0' -d "{\"nodeIddeviceId\":\"1G1BL52P7TR115520\",\"verifyCode\":\"13521211212\",\"timeout\":0}"

#cd /opt/CA/client
curl -E ./client.pem --cacert ./ca-cert.pem  -v -X PUT -H "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" -H "Content-Type:application/json" -H "app_key:MvmSR0wEKK5erGB8O3OASKlmYwsa" -H "access_token:7858a7a422f19567261c4aceadb84689" 'https://10.175.102.225:8543/iocm/app/dm/v1.0?app_key=MvmSR0wEKK5erGB8O3OASKlmYwsa' -d '{"plateNumber":"吉A21345","simNumber":"13001598745","carModel":SUV,"data":{"plateNumber":"吉A21345","simNumber":"13001598745","carModel":"SUV","vin":"SDFG12235895","engineModel":"LAS12334SS","terminalID":"SDF1234589"}}'
#HTTPS过程：
{
step1： “客户”向服务端发送一个通信请求
“客户”->“服务器”：你好
  
step2： “服务器”向客户发送自己的数字证书。证书中有一个公钥用来加密信息，私钥由“服务器”持有
“服务器”->“客户”：你好，我是服务器，这里是我的数字证书 
 
step3： “客户”收到“服务器”的证书后，它会去验证这个数字证书到底是不是“服务器”的，数字证书有没有什么问题，数字证书如果检查没有问题，就说明数字证书中的公钥确实是“服务器”的。检查数字证书后，“客户”会发送一个随机的字符串给“服务器”用私钥去加密，服务器把加密的结果返回给“客户”，“客户”用公钥解密这个返回结果，如果解密结果与之前生成的随机字符串一致，那说明对方确实是私钥的持有者，或者说对方确实是“服务器”。
“客户”->“服务器”：向我证明你就是服务器，这是一个随机字符串     //前面的例子中为了方便解释，用的是“你好”等内容，实际情况下一般是随机生成的一个字符串。
“服务器”->“客户”：{一个随机字符串}[私钥|RSA]
 
step4： 验证“服务器”的身份后，“客户”生成一个对称加密算法和密钥，用于后面的通信的加密和解密。这个对称加密算法和密钥，“客户”会用公钥加密后发送给“服务器”，别人截获了也没用，因为只有“服务器”手中有可以解密的私钥。这样，后面“服务器”和“客户”就都可以用对称加密算法来加密和解密通信内容了。
“服务器”->“客户”：{OK，已经收到你发来的对称加密算法和密钥！有什么可以帮到你的？}[密钥|对称加密算法]
“客户”->“服务器”：{我的帐号是aaa，密码是123，把我的余额的信息发给我看看}[密钥|对称加密算法]
“服务器”->“客户”：{你好，你的余额是100元}[密钥|对称加密算法]
}

#网上的说明，对照产品文档使用
{
1.生成根证书的KEY， 1024的意思是RSA加密位数，必须为2的N次方，一般用1024即可。
openssl genrsa -out ca.key 1024
2.用刚刚生成的根证书的KEY来生成CSR（证书签发请求），这一步会要求填写请求的相关信息。
openssl req -new -key ca.key -out ca.csr
 
其中要注意的输入项有两个，一个Common Name（证书机构名），另一个challenge password（记住即可）
 
3.再用刚才的CSR和KEY来生成我们的根证书， days参数用来指定证书的有效天数。
openssl x509 -req -days 3650 -in ca.csr -signkey ca.key -out ca.crt
 
以同样的办法生成服务器证书
1.先生成KEY
openssl genrsa -out server.key 1024
2.然后用KEY生成CSR，这一步输入信息里的Common Name必须填网站的域名
openssl req -new -key server.key -out server.csr
3.生成服务器证书
openssl x509 -req -days 3650 -in server.csr -signkey server.key -out server.crt
 
 
签发一个客户端证书，把最后生成的，后缀为P12文件给客户端安装。
1.先生成客户端的KEY
openssl genrsa -out client.key 1024
2.用KEY来生成CSR，但是这一步输入信息里的Common Name不能填上面的网站域名，因为这个是客户端的证书，如果填的和服务器证书的一样，会导致验证失败。
openssl req -new -key client.key -out client.csr
3.用最开始生成的根证书来签署生成这个客户端的证书。
openssl x509 –req –days 3650 –CA ca.crt –Cakey ca.key –Cacreateserial –in client.csr –out client.crt
4.制作客户端安装证书，这一步会要求输入一个Export Password，就是客户端安装证书时要求输入的安装密码
openssl pkcs12 -export -clcerts -in client.crt -inkey client.key -out client.p12
}

#生成密钥、证书
{

第一步，为服务器端和客户端准备公钥、私钥
# 生成服务器端私钥
openssl genrsa -out server.key 1024
# 生成服务器端公钥
openssl rsa -in server.key -pubout -out server.pem

# 生成客户端私钥
openssl genrsa -out client.key 1024
# 生成客户端公钥
openssl rsa -in client.key -pubout -out client.pem

第二步，生成 CA 证书
# 生成 CA 私钥
openssl genrsa -out ca.key 1024
# X.509 Certificate Signing Request (CSR) Management.
openssl req -new -key ca.key -out ca.csr
# X.509 Certificate Data Management.
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
在执行第二步时会出现：

Common Name (e.g. server FQDN or YOUR name) []:localhost
注意，这里的 Organization Name (eg, company) [Internet Widgits Pty Ltd]: 后面生成客户端和服务器端证书的时候也需要填写，不要写成一样的！！！可以随意写如：My CA, My Server, My Client。
然后 Common Name (e.g. server FQDN or YOUR name) []: 这一项，是最后可以访问的域名，我这里为了方便测试，写成 localhost，如果是为了给我的网站生成证书，需要写成 barretlee.com。

第三步，生成服务器端证书和客户端证书

# 服务器端需要向 CA 机构申请签名证书，在申请签名证书之前依然是创建自己的 CSR 文件
openssl req -new -key server.key -out server.csr
# 向自己的 CA 机构申请证书，签名过程需要 CA 的证书和私钥参与，最终颁发一个带有 CA 签名的证书
openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in server.csr -out server.crt

# client 端
openssl req -new -key client.key -out client.csr 
# client 端到 CA 签名
openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in client.csr -out client.crt
此时，我们的 keys 文件夹下已经有如下内容了：

.
├── https-client.js
├── https-server.js
└── keys
    ├── ca.crt
    ├── ca.csr
    ├── ca.key
    ├── ca.pem
    ├── ca.srl
    ├── client.crt
    ├── client.csr
    ├── client.key
    ├── client.pem
    ├── server.crt
    ├── server.csr
    ├── server.key
    └── server.pem
}
}
