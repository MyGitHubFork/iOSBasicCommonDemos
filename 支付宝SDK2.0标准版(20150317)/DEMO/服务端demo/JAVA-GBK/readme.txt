
            ╭───────────────────────╮
    ────┤           支付宝代码示例结构说明             ├────
            ╰───────────────────────╯ 

　 　    代码版本：3.3
         开发语言：JAVA
         版    权：支付宝（中国）网络技术有限公司
　       制 作 者：支付宝商户事业部技术支持组
         联系方式：商户服务电话0571-88158090

    ─────────────────────────────────

───────
 代码文件结构
───────

JAVA-GBK
  │
  ├src┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈类文件夹
  │  │
  │  ├com.alipay.config
  │  │  │
  │  │  └AlipayConfig.java┈┈┈┈┈基础配置类文件
  │  │
  │  ├com.alipay.util
  │  │  │
  │  │  ├AlipayCore.java┈┈┈┈┈┈支付宝接口公用函数类文件
  │  │  │
  │  │  ├AlipayNotify.java┈┈┈┈┈支付宝通知处理类文件
  │  │  │
  │  │  └UtilDate.java┈┈┈┈┈┈┈支付宝自定义订单类文件
  │  │
  │  ├com.alipay.rsa
  │  │  │
  │  │  ├RSA.java ┈┈┈┈┈┈┈┈┈RSA签名类文件
  │  │  │
  │  │  └Base64.java┈┈┈┈┈┈┈┈RSA密钥转换
  │  │
  │  └com.alipay.util.httpClient（已封装）
  │      │
  │      ├HttpProtocolHandler.java ┈支付宝HttpClient处理类文件
  │      │
  │      ├HttpRequest.java ┈┈┈┈┈支付宝HttpClient请求类文件
  │      │
  │      ├HttpResponse.java┈┈┈┈┈支付宝HttpClient返回类文件
  │      │
  │      └HttpResultType.java┈┈┈┈支付宝HttpClient返回的结果字符方式类文件
  │
  ├WebRoot┈┈┈┈┈┈┈┈┈┈┈┈┈┈页面文件夹
  │  │
  │  ├notify_url.jsp ┈┈┈┈┈┈┈┈服务器异步通知页面文件
  │  │
  │  └WEB-INF
  │   	  │
  │      └lib（如果JAVA项目中包含这些架包，则不需要导入）
  │   	     │
  │   	     ├commons-codec-1.6.jar
  │   	     │
  │   	     ├commons-httpclient-3.0.1.jar
  │   	     │
  │   	     ├commons-logging-1.1.1.jar
  │   	     │
  │   	     ├dom4j-1.6.1.jar
  │   	     │
  │   	     └jaxen-1.1-beta-6.jar
  │
  └readme.txt ┈┈┈┈┈┈┈┈┈使用说明文本

※注意※
需要配置的文件是：
alipay_config.java
notify_url.jsp
本代码示例（demo）中模拟获取远程HTTP信息使用的是commons-httpclient-3.0版本的第三方架包、及支付宝的httpClient封装类。
如果您不想使用该方式实现模拟获取远程HTTP功能，那么可以用其他方式代替，此时需您自行编写代码。

●商户的私钥、商户的公钥、支付宝公钥


◆商户的私钥
1、必须保证只有一行文字，即，没有回车、换行、空格等
2、需对刚生成的（原始的）私钥做pkcs8编码
3、编码完成后，复制该段私钥，并去掉里面的回车、换行、空格等

◆商户的公钥
1、必须保证只有一行文字，即，没有回车、换行、空格等
2、去掉“-----BEGIN PUBLIC KEY-----”、“-----END PUBLIC KEY-----”，只保存这两条文字之中的部分
3、保存好后，命名须“合作者身份ID.dat”的命名方式，如：2088101568342279.dat
4、重命名后，交给支付宝

◆支付宝公钥
1、必须保证只有一行文字，即，没有回车、换行、空格等
2、去掉“-----BEGIN PUBLIC KEY-----”、“-----END PUBLIC KEY-----”，只保存这两条文字之中的部分

─────────
 类文件函数结构
─────────

AlipayCore.java

public static Map paraFilter(Map<String, String> sArray)
功能：除去数组中的空值和签名参数
输入：Map<String, String> sArray 要签名的数组
输出：Map<String, String> 去掉空值与签名参数后的新签名参数组

public static String createLinkString(Map<String, String> params)
功能：把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
输入：Map<String, String> params 需要拼接的数组
输出：String 拼接完成以后的字符串

public static void logResult(String sWord)
功能：写日志，方便测试（看网站需求，也可以改成存入数据库）
输入：String sWord 要写入日志里的文本内容

public static String getAbstract(String strFilePath, String file_digest_type) throws IOException
功能：生成文件摘要
输入：String strFilePath 文件路径
      String file_digest_type 摘要算法
输出：String 文件摘要结果

┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉

RSA.java

public static String sign(String content, String privateKey, String input_charset)
功能：RSA签名
输入：String content 明文
      String privateKey 商户私钥
      String input_charset 编码格式
输出：String 签名结果

public static boolean verify(String content, String sign, String ali_public_key, String input_charset)
功能：RSA验签名检查
输入：String content 待签名数据
      String sign 支付宝的签名值
      String privateKey 支付宝公钥
      String input_charset 编码格式
输出：boolean 签名结果

┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉

AlipayNotify.java

public static boolean verify(Map<String, String> params)
功能：根据反馈回来的信息，生成签名结果
输入：Map<String, String>  Params 通知返回来的参数数组
输出：boolean 验证结果

private static boolean getSignVeryfy(Map<String, String> Params, String sign)
功能：根据反馈回来的信息，验证签名
输入：Map<String, String>  Params 通知返回来的参数数组
      String sign 支付宝的签名值
输出：boolean 签名结果

private static String verifyResponse(String notify_id)
功能：获取远程服务器ATN结果,验证返回URL
输入：String notify_id 验证通知ID
输出：String 验证结果

private static String checkUrl(String urlvalue)
功能：获取远程服务器ATN结果
输入：String urlvalue 指定URL路径地址
输出：String 服务器ATN结果字符串

┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉

UtilDate.java

public  static String getOrderNum()
功能：自动生出订单号，格式yyyyMMddHHmmss
输出：String 订单号

public  static String getDateFormatter()
功能：获取日期，格式：yyyy-MM-dd HH:mm:ss
输出：String 日期

public static String getDate()
功能：获取日期，格式：yyyyMMdd
输出：String 日期

public static String getThree()
功能：产生随机的三位数
输出：String 随机三位数

┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉┉
