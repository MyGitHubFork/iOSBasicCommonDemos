<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form_6_6_FileTransfer.aspx.cs"
    Inherits="Form_6_6_FileTransfer" %>

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
    // **************文件传输类交易的请求***********************

    // 使用Dictionary保存参数
    Dictionary<string, string> param = new Dictionary<string, string>();

    // 随机构造一个订单号（演示用）
    Random rnd = new Random();
    string orderID = DateTime.Now.ToString("yyyyMMddHHmmss") + (rnd.Next(900) + 100).ToString().Trim();
    // 填写参数

    param["version"] = "5.0.0";//版本号
    param["encoding"] = "UTF-8";//编码方式
    param["certId"] = CertUtil.GetSignCertId();//证书ID
    param["txnType"] = "76";//交易类型
    param["signMethod"] = "01";//签名方法
    param["txnSubType"] = "01";//交易子类
    param["bizType"] = "000000";//业务类型
    param["accessType"] = "0";//接入类型
    param["merId"] = "700000000000001";//商户代码，请替换实际商户号测试，如使用的是自助化平台注册的商户号，该商户号没有权限测文件下载接口的，请使用测试参数里写的文件下载的商户号和日期测。如需真实交易文件，请使用自助化平台下载文件。
    param["settleDate"] = "0119";//清算日期
    param["txnTime"] = DateTime.Now.ToString("yyyyMMddHHmmss");//订单发送时间，重新产生，不同于原消费
    param["fileType"] = "00";//交易金额，消费撤销时需和原消费一致

    // 签名
    SDKUtil.Sign(param, Encoding.UTF8);

    Response.Write("请求报文=[" + SDKUtil.PrintDictionaryToString(param) + "]\n");

    // 初始化通信处理类
    HttpClient hc = new HttpClient(SDKConfig.FileTransUrl);

    // 发送请求获取通信应答
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
            //商户端根据返回报文内容处理自己的业务逻辑 TODO...

            // 解析返回文件
            string fileContent = resData["fileContent"];
            if (!string.IsNullOrEmpty(fileContent))
            {
                //Base64解码
                byte[] dBase64Byte = Convert.FromBase64String(fileContent);
                //解压缩
                byte[] fileByte = SecurityUtil.inflater(dBase64Byte);

                string filePath = "d:\\FileDown";
                string fileName = resData["fileName"];

                //开始生成对账文件
                string path = System.IO.Path.Combine(filePath, fileName);
                System.IO.FileStream fs = new System.IO.FileStream(path, System.IO.FileMode.Create);
                fs.Write(fileByte, 0, fileByte.Length);
                fs.Close();
                fs.Dispose();

                Response.Write("文件生成路径[" + path + "]<br/>");
            }
        }
        else
        {
            Response.Write("商户端验证返回报文签名失败\n");
        }
    }
    else
    {
        // 通信失败,获取返回报文
        Response.Write("通信失败\n");
        Response.Write("返回报文=[" + result + "]\n");
    }

%>
