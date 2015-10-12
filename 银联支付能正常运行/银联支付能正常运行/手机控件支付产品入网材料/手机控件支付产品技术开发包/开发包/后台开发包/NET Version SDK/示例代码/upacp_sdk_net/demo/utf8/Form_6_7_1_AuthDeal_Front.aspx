<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form_6_7_1_AuthDeal_Front.aspx.cs" Inherits="Form_6_7_1_AuthDeal_Front" %>

<%@ Import Namespace="upacp_sdk_net.com.unionpay.sdk" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>

<% 
    //以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己需要，按照技术文档编写。该代码仅供参考
    // **************演示预授权前台交易的请求***********************
    Dictionary<string, string> param = new Dictionary<string, string>();
    // 随机构造一个订单号（演示用）
    Random rnd = new Random();
    string orderID = DateTime.Now.ToString("yyyyMMddHHmmss") + (rnd.Next(900) + 100).ToString().Trim();
    
    //填写参数

    param["version"] = "5.0.0";//版本号
    param["encoding"] = "UTF-8";//编码方式
    param["certId"] = CertUtil.GetSignCertId();      //证书ID
    param["txnType"] = "02";//交易类型
    param["txnSubType"] = "01";//交易子类
    param["bizType"] = "000201";//业务类型
    param["frontUrl"] = "http://localhost:8080/demo/utf8/FrontRcvResponse.aspx";    //前台通知地址      
    param["backUrl"]= "http://222.222.222.222:8080/demo/utf8/BackRcvResponse.aspx";  //后台通知地址，改自己的外网地址
    param["signMethod"]= "01";//签名方法
    param["channelType"] = "08";//渠道类型，07-PC，08-手机
    param["accessType"] = "0";//接入类型
    param["merId"] = "888888888888888";//商户号，请改成自己的商户号
    param["orderId"] = orderID;//商户订单号，可任意修改
    param["txnTime"] = DateTime.Now.ToString("yyyyMMddHHmmss");//订单发送时间
    param["txnAmt"] = "1";//交易金额，单位分
    param["currencyCode"] = "156";//交易币种
    //param["orderDesc"] = "订单描述";//订单描述，暂时不会起作用
    param["reqReserved"] = "透传信息";//请求方保留域，透传字段，查询、通知、对账文件中均会原样出现

    SDKUtil.Sign(param, Encoding.UTF8);
    // 将SDKUtil产生的Html文档写入页面，从而引导用户浏览器重定向   
    string html = SDKUtil.CreateAutoSubmitForm(SDKConfig.FrontTransUrl, param, Encoding.UTF8);
    Response.ContentEncoding = Encoding.UTF8; // 指定输出编码
    Response.Write(html);
 
%>