0. 注意：
1）依赖包和upacp_sdk-1.0.0.jar都需加到buildpath。
2）acp_sdk.properties放到src根目录下。另外如果用的不是eclipse/MyEclipse可能这个文件默认不会被拷贝到classes目录下，导致加载不到这个文件，请注意修改设置或手工拷贝这个文件。

1. 修改acp_sdk.properties，
1) 证书改下自己本地路径，证书密码测试环境就是000000，生产自己修改。

2.1 wap/网关的消费：调用Form_6_2_FrontConsume，商户号请改为自己的商户号，会生成一段html，把它打印到浏览器即可跳转支付页面。比如可以写一个servlet直接打印页面，或者把html复制到一个记事本里后缀改html再浏览器打开。

2.2 控件的消费：调用Form_6_2_AppConsume，商户号请改为自己的商户号，会访问后台获取tn，把tn传给你们手机app。

支付卡：
平安银行借记卡：6216261000000000018
证件号：341126197709218366
手机号：13552535506
密码：123456
姓名：全渠道
短信验证码：123456（wap/控件）111111（PC）
（短信验证码记得点下获取验证码之后再输入）

3. Form_6_5_Query为查询接口，商户号请改为自己的商户号，注意修改txnTime和orderId为被查询交易的txnTime和orderId。

4. Form_6_3_ConsumeUndo和Form_6_4_Refund分别为消费撤销接口、退货接口，商户号请改为自己的商户号，注意修改origQryId为自己需要退款的那笔消费的queryId。

5. FrontRcvResponse和BackRcvResponse为前后台通知接口，为2个Servlet，请注意配置web.xml，另外FrontRcvResponse会使用“其他文件/utf8_result.jsp”。交易完成会调用通知接口。

6. Form_6_6_FileTransfer为文件下载接口。
文件下载接口注意点：
1) 请使用自己的【真实商户号】测试。开发包的商户号、自助化测试平台申请的商户号都是不能测试文件下载的，会反http状态500，内容为空。如果真实商户号下载提示无文件但确定有交易，一般是商户号没有文件传输类交易的权限，如需要开通请联系业务运营中心operation@unionpay.com。
2) 请先建立好文件夹并确保有文件写入权限。

7. 如需使用gbk编码，请自行修改代码内写的编码和代码文件本身的编码为gbk。

8. 关于配置文件加载问题：
SDKConfig.getConfig().loadPropertiesFromSrc()这句话在整个工程启用的时候执行一次即可，其余地方都可删除。
比如可以建立个servlet，初始化时调用，web.xml中设置成启动时就加载这个servlet：

InitServlet.java：
public class InitServlet extends HttpServlet{
	@Override
	public void init() throws ServletException {
		SDKConfig.getConfig().loadPropertiesFromSrc();// 从classpath加载acp_sdk.properties文件
		super.init();
	}
}

web.xml：
  <servlet>
  	<servlet-name>InitServlet</servlet-name>
  	<servlet-class>com.unionpay.acp.demo.InitServlet</servlet-class>
  	<load-on-startup>0</load-on-startup>
  </servlet>


9. 日志文件路径问题：
可rar打开upacp_sdk-1.0.0.jar，修改里面log4j.properties配置的路径。

10. 切换生产时请一定看下https://open.unionpay.com/ajweb/help/faq/listByType?faqType=prod中的问题，特别是“切换生产有哪些需要改动的地方”的这个FAQ。


