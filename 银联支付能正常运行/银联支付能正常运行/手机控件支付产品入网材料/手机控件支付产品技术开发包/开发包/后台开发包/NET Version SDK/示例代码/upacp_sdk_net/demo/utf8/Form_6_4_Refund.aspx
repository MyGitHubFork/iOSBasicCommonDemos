<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form_6_4_Refund.aspx.cs" Inherits="upacp_sdk_net.demo.utf8.Form_6_4_Refund" %>

<%@ Import Namespace="upacp_sdk_net.com.unionpay.sdk" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
    // **************退货***********************

    // 使用Dictionary保存参数
    Dictionary<string, string> param = new Dictionary<string, string>();
    // 随机构造一个订单号（演示用）
    Random rnd = new Random();
    string orderID = DateTime.Now.ToString("yyyyMMddHHmmss") + (rnd.Next(900) + 100).ToString().Trim();


    param["version"] = "5.0.0";//版本号
    param["encoding"] = "UTF-8";//编码方式
    param["certId"] = CertUtil.GetSignCertId();//证书ID
    param["signMethod"] = "01";//签名方法
    param["txnType"] = "04";//交易类型
    param["txnSubType"] = "00";//交易子类
    param["bizType"] = "000201";//业务类型
    param["accessType"] = "0";//接入类型
    param["channelType"] = "07";//渠道类型
    param["orderId"] = orderID;//商户订单号，重新产生，不同于原消费
    param["merId"] = "";//商户代码，请改成自己的测试商户号
    param["origQryId"] = "201303071540145467132";//原消费的queryId，可以从查询接口或者通知接口中获取
    param["txnTime"] = DateTime.Now.ToString("yyyyMMddHHmmss");//订单发送时间，重新产生，不同于原消费
    param["txnAmt"] = "1";//交易金额，消费撤销时需和原消费一致

    param["backUrl"]= "http://222.222.222.222:8080/demo/utf8/BackRcvResponse.aspx";  //后台通知地址，改自己的外网地址


    string result = "";//返回结果
    SDKUtil.Sign(param, Encoding.UTF8);

    HttpClient hc = new HttpClient(SDKConfig.BackTransUrl);

    int status = hc.Send(param, Encoding.UTF8);
    if (status == 200)
    {
        result = hc.Result;
        if (result != null && string.IsNullOrEmpty(result))
        {
            Dictionary<string, string> resData = SDKUtil.CoverstringToDictionary(result);
            string respcode = resData["respCode"];

            if (SDKUtil.Validate(resData, Encoding.UTF8))
            {
                Response.Write("商户端验证返回报文签名成功");

            }
            else
            {
                Response.Write("商户端验证返回报文签名失败");
            }

        }
        else
        {
            result = hc.Result;
        }
    }
    else
    {
        Response.Write("退货失败");
        Response.Write("返回报文=[" + result + "]\n");
    }
%>
