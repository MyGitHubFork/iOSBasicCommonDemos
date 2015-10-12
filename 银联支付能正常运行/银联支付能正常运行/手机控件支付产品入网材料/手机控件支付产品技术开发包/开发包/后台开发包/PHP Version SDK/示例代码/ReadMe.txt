0. 注意请把php设置启用openssl。

1. 打开gbk（或utf8，下同）\func\SDKConfig.php，
1) 前台通知、后台通知地址改下，后台通知必须外网，否则会收不到。
2) 证书改下自己本地路径，证书密码测试环境就是000000，生产自己修改。
3）日志打印路径改下自己本地，请先建立好文件夹并确保有文件写入权限。
具体描述参照测试指引。

2.1 wap/网关的消费：调用demo\gbk\Form_6_2_FrontConsume.php，商户号请改为自己的商户号，会跳转银联支付页面。

2.2 控件的消费：调用demo\gbk\Form_6_2_AppConsume.php，商户号请改为自己的商户号，会访问后台获取tn，把tn传给你们手机app。

支付卡：
平安银行借记卡：6216261000000000018
证件号：341126197709218366
手机号：13552535506
密码：123456
姓名：全渠道
短信验证码：123456（wap/控件）111111（PC）
（短信验证码记得点下获取验证码之后再输入）

3. demo\gbk\Form_6_5_Query.php为查询接口，商户号请改为自己的商户号，注意修改txnTime和orderId为被查询交易的txnTime和orderId。

4. demo\gbk\Form_6_3_ConsumeUndo.php和Form_6_4_Refund.php分别为消费撤销接口、退货接口，商户号请改为自己的商户号，注意修改origQryId为自己需要退款的那笔消费的queryId。

5. demo\gbk\FrontReceive.php和BackReceive.php为前后台通知接口，交易完成会自行调用。

6. demo\gbk\Form_6_6_FileTransfer.php为文件下载接口。
文件下载接口注意点：
1) 请使用自己的【真实商户号】测试。开发包的商户号、自助化测试平台申请的商户号都是不能测试文件下载的，会反http状态500，内容为空。如果真实商户号下载提示无文件但确定有交易，一般是商户号没有文件传输类交易的权限，如需要开通请联系业务运营中心operation@unionpay.com。
2) 请先建立好文件夹并确保有文件写入权限。

7. 切换生产时请一定看下https://open.unionpay.com/ajweb/help/faq/listByType?faqType=prod中的问题，特别是“切换生产有哪些需要改动的地方”的这个FAQ。


====================

php开发小贴士：

1. 如何看php本身打印的错误日志：
1) 找到php安装目录。
2) 目录中有个php.ini，打开它。
3) 文件里有个配置项为error_log，启用一下。注意配置样例里设了2个，启用一个即可。路径设一下。
4) 重启web服务器，就是iis或者apache之类的。
5) 故意写错一下代码，如echo date('aaa')，触发报错，看看日志里是否有打印这条错误。打印了就设置的没问题。


