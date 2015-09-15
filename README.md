#在工作中或者网上遇到一些好的博客的时候，我会把它自己实现一下并且在每个demo的项目中通过warning的形式指定demo的博文地址。

#我会持续更新持续总结。。。欢迎大家关注。。。。

//======================================

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