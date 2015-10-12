<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form_6_2_AppConsume.aspx.cs" Inherits="Form_6_2_AppConsume" %>

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
    
    // **************演示控件获取tn交易的请求***********************
    Dictionary<string, string> param = new Dictionary<string, string>();
    // 随机构造一个订单号（演示用）
    Random rnd = new Random();
    string orderID = DateTime.Now.ToString("yyyyMMddHHmmss") + (rnd.Next(900) + 100).ToString().Trim();
    
    //填写参数

    param["version"] = "5.0.0";//版本号
    param["encoding"] = "UTF-8";//编码方式
    param["certId"] = CertUtil.GetSignCertId();      //证书ID
    param["txnType"] = "01";//交易类型
    param["txnSubType"] = "01";//交易子类
    param["bizType"] = "000201";//业务类型
    param["frontUrl"] = "http://localhost:8080/demo/utf8/FrontRcvResponse.aspx";    //前台通知地址 ，控件接入方式无作用     
    param["backUrl"]= "http://222.222.222.222:8080/demo/utf8/BackRcvResponse.aspx";  //后台通知地址	
    param["signMethod"]= "01";//签名方法
    param["channelType"] = "08";//渠道类型，07-PC，08-手机
    param["accessType"] = "0";//接入类型
    param["merId"] = "888888888888888";//商户号，请改成自己的商户号
    param["orderId"] = orderID;//商户订单号
    param["txnTime"] = DateTime.Now.ToString("yyyyMMddHHmmss");//订单发送时间
    param["txnAmt"] = "1";//交易金额，单位分
    param["currencyCode"] = "156";//交易币种
    param["orderDesc"] = "订单描述";//订单描述，可不上送，上送时控件中会显示该信息
    param["reqReserved"] = "透传信息";//请求方保留域，透传字段，查询、通知、对账文件中均会原样出现

    SDKUtil.Sign(param, Encoding.UTF8);  // 签名
    Response.Write("\n" + "请求报文=[" + SDKUtil.PrintDictionaryToString(param) + "]\n");

    // 初始化通信处理类
    HttpClient hc = new HttpClient(SDKConfig.AppRequestUrl);
    //// 发送请求获取通信应答
    int status = hc.Send(param, Encoding.UTF8);
    // 返回结果
    string result = hc.Result;
    if (status == 200)
    {
        Response.Write("返回报文=[" + result + "]\n");

        Dictionary<string, string> resData = SDKUtil.CoverstringToDictionary(result);

        string respcode = resData["respCode"];


        if (SDKUtil.Validate(resData, Encoding.UTF8))
        {
            Response.Write("商户端验证返回报文签名成功\n");
        }
        else
        {
            Response.Write("商户端验证返回报文签名失败\n");
        }


    }
    else
    {
        Response.Write("请求失败\n");
        Response.Write("返回报文=[" + result + "]\n");
    }
   


 
%>