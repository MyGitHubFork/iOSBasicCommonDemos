<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form_6_5_Query.aspx.cs" Inherits="Form_6_5_Query" %>

<!DOCTYPE html>
<%@ Import Namespace="upacp_sdk_net.com.unionpay.sdk" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
</body>
</html>


<%
  
   //以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己需要，按照技术文档编写。该代码仅供参考

    // **************交易状态查询***********************

    Dictionary<string, string> param = new Dictionary<string, string>(); // 使用Dictionary保存参数
   
    param["version"] = "5.0.0";//版本号
    param["encoding"] = "UTF-8";//编码方式
    param["certId"] = CertUtil.GetSignCertId();//证书ID
    param["signMethod"] = "01";//签名方法
    param["txnType"] = "00";//交易类型
    param["txnSubType"] = "00";//交易子类
    param["bizType"] = "000000";//业务类型
    param["accessType"] = "0";//接入类型
    param["channelType"] = "07";//渠道类型
    param["orderId"] = "20150211215817604";//请修改被查询的交易的订单号
    param["merId"] = "888888888888888";//商户代码，请改成自己的测试商户号
    param["txnTime"] = "20150211215817";//请修改被查询的交易的订单发送时间

    SDKUtil.Sign(param, Encoding.UTF8);  // 签名
    Response.Write("\n" + "请求报文=[" + SDKUtil.PrintDictionaryToString(param) + "]\n");

    // 初始化通信处理类
    HttpClient hc = new HttpClient(SDKConfig.SingleQueryUrl);
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


