0. 注意：
1）将ICSharpCode.SharpZipLib加入引用。
2）.net版本4.0及以上。

1. 参考样例修改Web.config，
1) 前台通知、后台通知地址改下，后台通知必须外网，否则会收不到。
2) 证书改下自己本地路径，证书密码测试环境就是000000，生产自己修改。其中加密证书路径请任意配置，用不到的。
3）日志打印路径改下自己本地，请先建立好文件夹并确保有文件写入权限。
具体描述参照测试指引。

样例如下：
<?xml version="1.0" encoding="utf-8"?>

<!--
  有关如何配置 ASP.NET 应用程序的详细消息，请访问
  http://go.microsoft.com/fwlink/?LinkId=169433
  -->

<configuration>
    <system.web>
        <compilation debug="true" targetFramework="4.0" />
    </system.web>
    <appSettings>
      <!-- ##########################交易发送地址配置#############################-->
      <!--######(以下配置为PM环境：入网测试环境用，生产环境配置见文档说明)#######-->
      <!-- 签名证书路径 PM_700000000000001_acp.pfx-->
      <add key="sdk.signCert.path" value="D:\\certs\\PM_700000000000001_acp.pfx" />
      <!-- 签名证书密码 -->
      <add key="sdk.signCert.pwd" value="000000" />
      <!-- 签名证书类型 -->
      <add key="sdk.signCert.type" value="PKCS12" />
      <!-- 加密证书路径 -->
      <add key="sdk.encryptCert.path" value="D:\\certs\\encrypt.cer" />
      <!-- 验签证书目录 -->
      <add key="sdk.validateCert.dir" value="D:\\certs\\" />
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
</configuration>


2.1 wap/网关的消费：调用demo\utf8\Form_6_2_FrontConsume.aspx，商户号请改为自己的商户号，会跳转银联支付页面。

2.2 控件的消费：调用demo\utf8\Form_6_2_AppConsume.aspx，商户号请改为自己的商户号，会访问后台获取tn，把tn传给你们手机app。

支付卡：
平安银行借记卡：6216261000000000018
证件号：341126197709218366
手机号：13552535506
密码：123456
姓名：全渠道
短信验证码：123456（wap/控件）111111（PC）
（短信验证码记得点下获取验证码之后再输入）

3. demo\utf8\Form_6_5_Query.aspx为查询接口，商户号请改为自己的商户号，注意修改txnTime和orderId为被查询交易的txnTime和orderId。

4. demo\utf8\Form_6_3_ConsumeUndo.aspx和Form_6_4_Refund.aspx分别为消费撤销接口、退货接口，商户号请改为自己的商户号，注意修改origQryId为自己需要退款的那笔消费的queryId。

5. demo\utf8\FrontReceive.aspx和BackReceive.aspx为前后台通知接口，交易完成会自行调用。

6. demo\utf8\Form_6_6_FileTransfer.aspx为文件下载接口。
文件下载接口注意点：
1) 请使用自己的【真实商户号】测试。开发包的商户号、自助化测试平台申请的商户号都是不能测试文件下载的，会反http状态500，内容为空。如果真实商户号下载提示无文件但确定有交易，一般是商户号没有文件传输类交易的权限，如需要开通请联系业务运营中心operation@unionpay.com。
2) 请先建立好文件夹并确保有文件写入权限。

7. 如需使用gbk编码，请自行修改代码内写的编码和代码文件本身的编码为gbk。

8. 切换生产时请一定看下https://open.unionpay.com/ajweb/help/faq/listByType?faqType=prod中的问题，特别是“切换生产有哪些需要改动的地方”的这个FAQ。




