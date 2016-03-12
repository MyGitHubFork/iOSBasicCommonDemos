#这个仓库提供入门级别的、实用的各种资，我也会持续更新我的学习demo。此仓库对中低级iOSer有一定参考意义，大神请自行忽略。

##这个仓库里面的一般都是实用性的在工作中或者网上遇到一些好的博客的时候，我会把它自己实现一下并且在每个demo的项目中通过warning的形式指定demo的博文地址(后期部分，前期的我没有加)。

##带`转`字的都是别人下的、我只是下载觉得好，如果不适，请联系我。其他的基本上都是我iOS生涯各个时期的学习Demo，基本都是我自己敲的或者学的，希望能对你有所帮助。其中有一些随着时间的流逝丢了，可惜。

#放在一个仓库太大、以后更新都放第二期仓库了。地址如下：
[https://github.com/huang303513/The-Demo-Of-Common-Study](https://github.com/huang303513/The-Demo-Of-Common-Study)

imageivew的contentmodel属性设置看下图我再也不迷糊了：
![image](https://github.com/huang303513/iOS-Study-Demo/blob/master/UiimageView%E7%9A%84contentmodel%E5%9B%BE%E7%89%87%E6%BC%94%E7%A4%BA.jpg)

//==================省市区三级连滚一句话调用====================

![省市区三级连滚一句话调用](https://github.com/huang303513/iOS-Study-Demo/blob/master/screenshoot/%E7%9C%81%E5%B8%82%E5%8C%BA%E4%B8%89%E7%BA%A7%E8%87%AA%E5%8A%A8%E8%BF%9E%E6%BB%9A.gif)

![省市区三级连滚一句话调用](https://github.com/huang303513/iOS-Study-Demo/tree/master/%E7%9C%81%E5%B8%82%E5%8C%BA%E4%B8%89%E7%BA%A7%E8%BF%9E%E6%BB%9A%E4%B8%80%E5%8F%A5%E8%AF%9D%E8%B0%83%E7%94%A8)用法：

```Objective-C
//设置省市区拾取器
MYAddressPickerView *addrPickView = [[MYAddressPickerView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 256)];
//做数据初始化
[addrPickView initData];
//确定回调
[addrPickView setAddressCallback:^(NSString *addressCode,NSString *address,NSDictionary *addressDict) {
self.addressDic = addressDict;
NSLog(@"选中的地址信息%@",self.addressDic);
self.addressTextField.text = address;
[self.addressTextField resignFirstResponder];
}];
//取消回调
[addrPickView setCancelCallback:^{
[self.addressTextField resignFirstResponder];
}];
self.addressTextField.inputView = addrPickView;
```-->

//=============================================
