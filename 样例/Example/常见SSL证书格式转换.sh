
#常见证书格式
PKCS 全称是 Public-Key Cryptography Standards ，是由 RSA 实验室与其它安全系统开发商为促进公钥密码的发展而制订的一系列标准，PKCS目前共发布过15个标准。 常用的有：
PKCS#7 Cryptographic Message Syntax Standard
PKCS#10 Certification Request Standard
PKCS#12 Personal Information Exchange Syntax Standard
X.509是常见通用的证书格式。所有的证书都符合为Public Key Infrastructure (PKI) 制定的 ITU-T X509 国际标准。
PKCS#7 常用的后缀是： .P7B .P7C .SPC
PKCS#12 常用的后缀有： .P12 .PFX
X.509 DER 编码(ASCII)的后缀是： .DER .CER .CRT
X.509 PAM 编码(Base64)的后缀是： .PEM .CER .CRT
.cer/.crt是用于存放证书，它是2进制形式存放的，不含私钥。
.pem跟crt/cer的区别是它以Ascii来表示。
pfx/p12 用于存放个人证书/私钥，他通常包含保护密码，2进制方式
p10 是证书请求
p7r 是CA对证书请求的回复，只用于导入
p7b 以树状展示证书链(certificate chain)，同时也支持单个证书，不含私钥。

#格式互转

1. CA证书
用openssl创建CA证书的RSA密钥(PEM格式)：
openssl genrsa -des3 -out ca.key 1024        

2. 创建CA证书有效期为一年
用openssl创建CA证书(PEM格式,假如有效期为一年)：
openssl req -new -x509 -days 365 -key ca.key -out ca.crt -config openssl.cnf        
openssl是可以生成DER格式的CA证书的，最好用IE将PEM格式的CA证书转换成DER格式的CA证书。

3. x509 转换为 pfx
openssl pkcs12 -export -inkey server.key -in server.crt -out server.pfx   

4. PEM格式的ca.key转换为Microsoft可以识别的pvk格式
pvk -in ca.key -out ca.pvk -nocrypt -topvk        

5. 从 pfx 格式文件中提取私钥格式文件 (.key)
openssl pkcs12 -in mycert.pfx -nocerts -nodes -out mycert.key

6. 从 pfx 转成 .pem
openssl pkcs12 -in test.pfx -out client.pem 

7.从pfx格式的证书提取出密钥和证书
openssl pkcs12 -in my.pfx -nodes -out server.pem
openssl rsa -in server.pem -out server.key 
openssl x509 -in server.pem -out server.crt

8. 转换 pem 到到 spc
openssl crl2pkcs7 -nocrl -certfile venus.pem  -outform DER -out venus.spc     
用 -outform -inform 指定 DER 还是 PAM 格式。例如：
openssl x509 -in Cert.pem -inform PEM -out cert.der -outform DER        

9. p12 到 pem 的转换，将pcks12中的信息分离出来，写入文件：
openssl pkcs12 -nocerts -nodes -in cert.p12 -out private.pem
openssl pkcs12 -clcerts -nokeys -in cert.p12 -out cert.pem
openssl pkcs12 –in ocsp1.pfx -out certandkey.pem

10. 生成 p12 文件
openssl pkcs12 -export -in Cert.pem -inkey key.pem  -out Cert.p12      
openssl pkcs12 -export -inkey private.key -in client.crt -CAfile ca-cert.pem -chain -out my.pfx
openssl pkcs12 -export -inkey private.key -in client.crt -CAfile ca-cert.pem -chain -out myclient.p12

11.从 crt 转成 pem
openssl x509 -in mycert.crt -out mycert.pem -outform PEM
openssl x509 -in input.crt -out input.der -outform DER
openssl x509 -in input.der -inform DER -out output.pem -outform PEM
	

12.pem 格式的证书与 der 格式的证书的转换
openssl x509 -in cert.pem -inform PEM -out cert.der -outform DER 
openssl x509 -in ca.cer -inform DER -out ca.pem -outform  PEM




实例{
openssl x509 -in cert.cer -inform DER -outform PEM -out ca-cert.pem
openssl pkcs12 -export -inkey abc.key -in kubecfg.crt -CAfile ca-cert.pem -chain -out myclient2.p12

 #/opt/CA/client/test 
openssl pkcs12 -export -inkey private.key -in client.pem -CAfile ca-cert.pem -chain -out my.pfx
openssl pkcs12 -export -inkey private.key -in client.crt -CAfile ca-cert.pem -chain -out myclient.p12

-E ./client.pem --cacert ./ca-cert.pem -X POST


CA根证书 ca-cert.pem
公钥 ca-key.pem
私钥 private.key
证书签名请求文件 certsignreqfile.csr
服务器端证书 server.crt （未经过根证书签名）
经过签名的服务器证书 server.crt


#从 CRT format 到 PEM
openssl x509 -in ca.crt -out input.der -outform DER
openssl x509 -in input.der -inform DER -out ca-cert.pem -outform PEM

分析一个PKCS#12文件和输出到文件中：
openssl pkcs12 -in file.p12 -out file.pem

仅仅输出客户端证书到文件中：
openssl pkcs12 -in file.p12 -clcerts -out file.pem

不加密私钥文件：
openssl pkcs12 -in file.p12 -out file.pem -nodes

打印PKCS#12格式的信息值：
openssl pkcs12 -in file.p12 -info -noout

生成pkcs12文件，但不包含CA证书：
openssl pkcs12 -export -inkey ocspserverkey.pem -in ocspservercert.pem  -out ocspserverpkcs12.pfx

生成pcs12文件，包含CA证书：
openssl pkcs12 -export -inkey ocspserverkey.pem -in ocspservercert.pem -CAfile cacert.pem -chain -out ocsp1.pfx

将pcks12中的信息分离出来，写入文件：
openssl pkcs12 –in ocsp1.pfx -out certandkey.pem

显示pkcs12信息：
openssl pkcs12 –in ocsp1.pfx -info
 
}

其他{

PEM--DER/CER(BASE64--DER编码的转换)

       openssl x509 -outform der -in certificate.pem -out certificate.der
PEM--P7B(PEM--PKCS#7)

       openssl crl2pkcs7 -nocrl -certfile certificate.cer -out certificate.p7b -certfile CACert.cer
PEM--PFX(PEM--PKCS#12)

       openssl pkcs12 -export -out certificate.pfx -inkey privateKey.key -in certificate.crt -certfile CACert.crt
PEM--p12(PEM--PKCS#12)

       openssl pkcs12 -export -out Cert.p12 -in Cert.pem -inkey key.pem
CER/DER--PEM(编码DER--BASE64)

       openssl x509 -inform der -in certificate.cer -out certificate.pem
P7B--PEM(PKCS#7--PEM)

       openssl pkcs7 -print_certs -in certificate.p7b -out certificate.cer
P7B--PFX(PKCS#7--PKCS#12)

       openssl pkcs7 -print_certs -in certificate.p7b -out certificate.cer
       openssl pkcs12 -export -in certificate.cer -inkey privateKey.key -out certificate.pfx -certfile CACert.cer
PFX/p12--PEM(PKCS#12--PEM)

       openssl pkcs12 -in certificate.pfx -out certificate.cer
       如无需加密pem中私钥，可以添加选项-nodes；
       如无需导出私钥，可以添加选项-nokeys; 
PEM BASE64--X.509文本格式

       openssl x509 -in Key.pem -text -out Cert.pem
PFX文件中提取私钥(.key)

       openssl pkcs12 -in mycert.pfx -nocerts -nodes -out mycert.key
PEM--SPC

       openssl crl2pkcs7 -nocrl -certfile venus.pem -outform DER -out venus.spc
PEM－－PVK（openssl 1.x开始支持）

       openssl rsa -in mycert.pem -outform PVK -pvk-strong -out mypvk.pvk
PEM－－PVK（对于openssl 1.x之前的版本，可以下载pvk转换器后通过以下命令完成）

       pvk -in ca.key -out ca.pvk -nocrypt -topvk
}


