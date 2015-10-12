在Web.config新增或者修改以下配置信息：
 
 <appSettings>
  	<!-- ##########################交易发送地址配置#############################-->
    <!--######(以下配置为PM环境：入网测试环境用，生产环境配置见文档说明)#######-->
    <!-- 签名证书路径 PM_700000000000001_acp.pfx-->
    <add key="sdk.signCert.path" value="d:\\certs\\PM_700000000000001_acp.pfx" />
    <!-- 签名证书密码 -->
    <add key="sdk.signCert.pwd" value="000000" />
    <!-- 签名证书类型 -->
    <add key="sdk.signCert.type" value="PKCS12" />
    <!-- 加密证书路径 -->
    <add key="sdk.encryptCert.path" value="d:\\certs\\encrypt.cer" />
    <!-- 验签证书目录 -->
    <add key="sdk.validateCert.dir" value="d:\\certs\\" />
    <!-- 前台交易地址 -->
    <add key="sdk.frontTransUrl" value="https://101.231.204.80:5000/gateway/api/frontTransReq.do" />
    <!-- 后台交易地址 -->
    <add key="sdk.backTransUrl" value="https://101.231.204.80:5000/gateway/api/backTransReq.do" />
    <!-- 交易状态查询地址 -->
    <add key="sdk.singleQueryUrl" value="https://101.231.204.80:5000/gateway/api/queryTrans.do" />
    <!-- 文件传输类交易地址 -->
    <add key="sdk.fileTransUrl" value="https://101.231.204.80:9080/" />
    <!-- 批量交易地址 -->
    <add key="sdk.batTransUrl" value="https://101.231.204.80:5000/gateway/api/batchTrans.do" />
    <!-- 有卡交易地址 -->
    <add key="sdk.cardRequestUrl" value="https://101.231.204.80:5000/gateway/api/cardTransReq.do" />
    <!-- app交易地址 手机控件支付使用该地址-->
    <add key="sdk.appRequestUrl" value="https://101.231.204.80:5000/gateway/api/appTransReq.do" />
  </appSettings>