在Web.config新增或者修改以下配置信息：
 
 <appSettings>
  	<!-- ##########################交易发送地址配置#############################-->
    <!--######(以下配置为入网测试环境用)#######-->
    <!--  签名证书路径 （联系运营获取两码，在CFCA网站下载后配置，自行设置证书密码并配置） -->
    <add key="sdk.signCert.path" value="d:\\certs\\PRO_700000000000001_acp.pfx" />
    <!-- 签名证书密码 -->
    <add key="sdk.signCert.pwd" value="000000" />
    <!-- 签名证书类型 -->
    <add key="sdk.signCert.type" value="PKCS12" />
    <!-- 加密证书路径 -->
    <add key="sdk.encryptCert.path" value="d:\\certs\\RSA2048_PROD_index_22.cer" />
    <!-- 验签证书目录 -->
    <add key="sdk.validateCert.dir" value="d:\\certs\\" />
    <!-- 前台交易地址 -->
    <add key="sdk.frontTransUrl" value="https://gateway.95516.com/gateway/api/frontTransReq.do" />
    <!-- 后台交易地址 -->
    <add key="sdk.backTransUrl" value="https://gateway.95516.com/gateway/api/backTransReq.do" />
    <!-- 交易状态查询地址 -->
    <add key="sdk.singleQueryUrl" value="https://gateway.95516.com/gateway/api/queryTrans.do" />
    <!-- 文件传输类交易地址 -->
    <add key="sdk.fileTransUrl" value="https://filedownload.95516.com/" />
    <!-- 批量交易地址 -->
    <add key="sdk.batTransUrl" value="https://gateway.95516.com/gateway/api/batchTrans.do" />
    <!-- 有卡交易地址 -->
    <add key="sdk.cardRequestUrl" value="https://gateway.95516.com/gateway/api/cardTransReq.do" />
    <!-- app交易地址 手机控件支付使用该地址-->
    <add key="sdk.appRequestUrl" value="https://gateway.95516.com/gateway/api/appTransReq.do" />
  </appSettings>