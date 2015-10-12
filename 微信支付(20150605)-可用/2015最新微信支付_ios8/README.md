# WechatPayDemo

---

这是非官方的微信支付Demo，基于微信SDK1.4.1构建，可以从[这里](https://open.weixin.qq.com/cgi-bin/frame?t=resource/res_main_tmpl&lang=zh_CN)下载到最新的官方iOS开发资料。(里面的参数都是从Android版Demo中提取)

## Usage

这个项目依赖 [CocoaPods](http://cocoapods.org) 使用前请先在工程目录下执行：

```
pod install
```

另外，可以在 ```AppDelegate.m``` 中替换已有的请求参数用于个人项目的测试。

而 ```package``` 里参数的含义可以参考[这里](https://github.com/gbammc/WechatPayDemo/issues/2)。:]

## 说明

创建这个Repo的原因是，微信官方并没有提供支付功能的iOS Demo（只有Android版...），而且个人认为官方提供的文档也相当不靠谱，例如：

1.文档里代码示例出现基本错误

```
// 构造参数列表
NSMutableDictionary params = [NSMutableDictionary dictionary]; [params setObject:@"WX" forKey:@"bank_type"];
[params setObject:@"千足金箍棒" forKey:@"body"];

...

// 进行md5摘要前,params内容为原始内容,未经过url encode处理
String packageSign = package.md5.uppercaseString;
return [NSString stringWithFormat:@"%@&sign=%@",paragramString,packageSign];
```

2.文档指示不清

```
package 生成方法:
A)对所有传入参数按照字段名的 ASCII 码从小到大排序(字典序)后,使用 URL 键值对的格 式(即 key1=value1&key2=value2...)拼接成字符串 string1;
B) 在 string1 最后拼接上 key=partnerKey 得到 stringSignTemp 字符串, 并对 stringSignTemp 进行 md5 运算,再将得到的字符串所有字符转换为大写,得到 sign 值 signValue。
C)对 string1 中的所有键值对中的 value 进行 urlencode 转码,按照 a 步骤重新拼接成字符 串,得到 string2。对于 js 前端程序,一定要使用函数 encodeURIComponent 进行 urlencode 编码(注意!进行 urlencode 时要将空格转化为%20 而不是+)。
D)将 sign=signValue 拼接到 string1 后面得到最终的 package 字符串。
```

C) 中出现的string2在后面再也没提到了，但其实就是```return [NSString stringWithFormat:@"%@&sign=%@",paragramString,packageSign];```里的```paragramString```

```
三、调起微信支付
将第二步生成的 prepayId 作为参数,调用微信 sdk 发送支付请求到微信。
代码示例如下:
PayReq *request = [[[PayReq alloc] init] autorelease];
request.partnerId = _pactnerid;
request.prepayId= _prapayid;
Request.package = _package;
request.nonceStr= _noncestr;
request.timeStamp= _timestamp;
request.sign= _sign;
[WXApi safeSendReq:request];
注意事项:
1.调起微信支付 SDK 时,请求参数中 package 需填写为:Sign=WXPay。 签名生成示例如下:
// 构造参数列表
NSMutableDictionary params = [NSMutableDictionary dictionary]; [params setObject:@"1234567" forKey:@"appid"];
[params setObject:@"111111" forKey:@"appkey"];
[params setObject:@"daadssas" forKey:@"noncestr"];
[params setObject:@"Sign=WXPay" forKey:@"package"];
[params setObject:@"123456" forKey:@"partnerid"];
[params setObject:@"123456" forKey:@"prepayid"];
[params setObject:@"12345" forKey:@"timestamp"];
```

文档中特地用红色标明了这句```[params setObject:@"Sign=WXPay" forKey:@"package"];```，而上面 request 中的 package 却是```Request.package = _package;```，可是经实验，request 的 package 也应该同样是```@"Sign=WXPay"```才能发起支付成功。

---

可能我的理解水平比较低，最后是看着Android的Demo才能顺利跑通，所以希望这个Repo能帮到同样是iOS的开发者，如果有什么建议的话也希望提交issue讨论，不过重点声明```本人不负任何责任```:]
