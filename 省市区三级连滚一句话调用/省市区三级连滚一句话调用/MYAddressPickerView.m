//
//  AddressPickerView.m
//  HaoHaoMaiDemo
//
//  Created by danzhu on 15/4/7.
//  Copyright (c) 2015年 mtrong. All rights reserved.
//

#import "MYAddressPickerView.h"
//#import "MJExtension.h"
//#import "JSONKit.h"

#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2


//屏幕尺寸
#define __kScreenBounds     [[UIScreen mainScreen]bounds]
#define __kScreenWidth      [[UIScreen mainScreen]bounds].size.width
#define __kScreenHeight     [[UIScreen mainScreen]bounds].size.

@interface MYAddressPickerView()<UIPickerViewDataSource,UIPickerViewDelegate> {
    UIPickerView *_pickerView;
    // 省数据源
    NSDictionary *_dict;
    // 市数据源
    NSDictionary *_cityDict;
    // 县数据源
    NSDictionary *_districtDict;
    NSMutableArray *_proArr;
    NSMutableArray *_cityArr;
    NSMutableArray *_districtArr;
    // 省
    NSMutableArray *_pickerArray;
    // 市
    NSMutableArray *_subPickerArray;
    // 县
    NSMutableArray *_thirdPickerArray;
    NSString *_province;
    NSString *_city;
    NSString *_district;
    NSString *_provinceCode;
    NSString *_cityCode;
    NSString *_districtCode;
    NSInteger _provinceIndex;
    NSInteger _cityIndex;
    NSInteger _districtIndex;
}

@end

@implementation MYAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, 40, __kScreenWidth, 216);
        _pickerView.backgroundColor = [UIColor grayColor];
        [self addSubview:_pickerView];
        //为pickerView添加确定和取消按钮
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(__kScreenWidth - 80, 0, 80, 40)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        [self addSubview:sureBtn];
//        [self initData];
    }
    return self;
}

- (void)initData {
    //默认省市区都选第一个
    _provinceIndex = 0;
    _cityIndex = 0;
    _districtIndex = 0;
    if (_storePCDCode != nil && ![_storePCDCode isEqualToString:@""]) {
        NSArray *codeArr = [_storePCDCode componentsSeparatedByString:@"-"];
        _provinceCode = [codeArr objectAtIndex:0];
        _cityCode = [codeArr objectAtIndex:1];
        _districtCode = [codeArr objectAtIndex:2];
    }
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    //读取本地json数据
    NSString* jsonPath=[[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSDictionary *dic1 = [NSDictionary dictionaryWithContentsOfFile:jsonPath];
    NSLog(@"%@",dic1);
    NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers error:&err];
    //初始化省市区array
    _pickerArray = [[NSMutableArray alloc] init];
    _subPickerArray = [[NSMutableArray alloc] init];
    _thirdPickerArray = [[NSMutableArray alloc] init];
    _proArr = dic[@"p"];
    //
    for (int i = 0; i < _proArr.count; i++) {
        [_pickerArray addObject:[_proArr[i] valueForKey:@"name"]];
        //得到当前选中省的index
        if (_provinceCode != nil && [[NSString stringWithFormat:@"%@",[_proArr[i] valueForKey:@"id"]] isEqualToString:_provinceCode]) {
            _provinceIndex = i;
        }
    }
    //得到省的名字和编码
    _province = _pickerArray[_provinceIndex];
    _provinceCode = [_proArr[_provinceIndex] valueForKey:@"id"];
    //得到省的所有市
    long idl = [[_proArr[_provinceIndex] valueForKey:@"id"] longValue];
    NSString *idStr = [NSString stringWithFormat:@"%ld",idl];
    _cityDict = dic[@"c"];
    _cityArr = [_cityDict valueForKey:idStr];
    for (int i = 0; i < _cityArr.count; i++) {
        [_subPickerArray addObject:[_cityArr[i] valueForKey:@"name"]];
        //得到当前选中的市
        if (_cityCode != nil && [[NSString stringWithFormat:@"%@",[_cityArr[i] valueForKey:@"id"]] isEqualToString:_cityCode]) {
            _cityIndex = i;
        }
    }
    //得到当前选中的市的编码和名字
    _city = _subPickerArray[_cityIndex];
    _cityCode = [_cityArr[_cityIndex] valueForKey:@"id"];
    idl = [[_cityArr[_cityIndex] valueForKey:@"id"] longValue];
    idStr = [NSString stringWithFormat:@"%ld",idl];
    _districtDict = dic[@"a"];
    _districtArr = [_districtDict valueForKey:idStr];
    for (int i = 0; i < _districtArr.count; i++) {
        [_thirdPickerArray addObject:[_districtArr[i] valueForKey:@"name"]];
        //得到当前选中的区
        if (_districtCode != nil && [[NSString stringWithFormat:@"%@",[_districtArr[i] valueForKey:@"id"]] isEqualToString:_districtCode]) {
            _districtIndex = i;
        }
    }
    _district = _thirdPickerArray[_districtIndex];
    _districtCode = [_districtArr[_districtIndex] valueForKey:@"id"];
    //pickerview滚动到当前选中的行
    [_pickerView selectRow:_provinceIndex inComponent:FirstComponent animated:NO];
    [_pickerView selectRow:_cityIndex inComponent:SubComponent animated:NO];
    [_pickerView selectRow:_districtIndex inComponent:ThirdComponent animated:NO];
}

#pragma mark --
#pragma --UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == FirstComponent) {
        return [_pickerArray count];
    }
    if (component == SubComponent) {
        return [_subPickerArray count];
    }
    if (component == ThirdComponent) {
        return [_thirdPickerArray count];
    }
    return 0;
}


#pragma mark--
#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == FirstComponent) {
        return [_pickerArray objectAtIndex:row];
    }
    if (component == SubComponent) {
        return [_subPickerArray objectAtIndex:row];
    }
    if (component == ThirdComponent) {
        return [_thirdPickerArray objectAtIndex:row];
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == FirstComponent) {
        long idl = [[_proArr[row] valueForKey:@"id"] longLongValue];
        NSString *idStr = [NSString stringWithFormat:@"%ld",idl];
        _provinceCode = idStr;
        _cityArr = [_cityDict valueForKey:idStr];
        _subPickerArray = [[NSMutableArray alloc] init];
        for (NSDictionary *cityDic in _cityArr) {
            [_subPickerArray addObject:cityDic[@"name"]];
        }
        idl = [[_cityArr[0] valueForKey:@"id"] longLongValue];
        idStr = [NSString stringWithFormat:@"%ld",idl];
        _cityCode = idStr;
        _districtArr = [_districtDict valueForKey:idStr];
        _districtCode = [_districtArr[0] valueForKey:@"id"];
        _thirdPickerArray = [[NSMutableArray alloc] init];
        for (NSDictionary *districtDic in _districtArr) {
            [_thirdPickerArray addObject:districtDic[@"name"]];
        }
        [_pickerView reloadComponent:1];
        [_pickerView reloadComponent:2];
        _province = _pickerArray[row];
        _city = _subPickerArray[0];
        _district = _thirdPickerArray[0];
        _provinceIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        [_pickerView selectRow:0 inComponent:SubComponent animated:YES];
        [_pickerView selectRow:0 inComponent:ThirdComponent animated:YES];
    }
    if (component == SubComponent) {
        long idl = [[_cityArr[row] valueForKey:@"id"] longLongValue];
        NSString *idStr = [NSString stringWithFormat:@"%ld",idl];
        _cityCode = idStr;
        _districtArr = [_districtDict valueForKey:idStr];
        _districtCode = [_districtArr[0] valueForKey:@"id"];
        _thirdPickerArray = [[NSMutableArray alloc] init];
        for (NSDictionary *districtDic in _districtArr) {
            [_thirdPickerArray addObject:districtDic[@"name"]];
        }
        [_pickerView reloadComponent:2];
        _city = _subPickerArray[row];
        _district = _thirdPickerArray[0];
        _cityIndex = row;
        _districtIndex = 0;
        [_pickerView selectRow:0 inComponent:ThirdComponent animated:YES];
    }
    if (component == ThirdComponent) {
        _district = _thirdPickerArray[row];
        _districtCode = [_districtArr[row] valueForKey:@"id"];
        _districtIndex = row;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return __kScreenWidth / 3;
    }
    if (component==SubComponent) {
        return __kScreenWidth / 3;
    }
    if (component==ThirdComponent) {
        return __kScreenWidth / 3;
    }
    return 0;
}

/*!
 *  @author danzhu, 15-04-18 14:04:30
 *
 *  点击空白部分响应
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 *
 *  @since 1.0
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
//确定按钮。。返回省市区的编码、名字。
- (void)sureClick:(UIButton *)btn {
    NSLog(@"%@-%@-%@",_provinceCode,_cityCode,_districtCode);
    
    NSDictionary *addressDict = @{@"ProvinceId":_provinceCode,
                                  @"CityId":_cityCode,
                                  @"DistrictId":_districtCode,
                                  @"Province":_province,
                                  @"City":_city,
                                  @"District":_district
                                  };
    //确定回调
    _addressCallback([NSString stringWithFormat:@"%@-%@-%@",_provinceCode,_cityCode,_districtCode],[NSString stringWithFormat:@"%@-%@-%@",_province,_city,_district],addressDict);
}
//取消回调
- (void)cancelClick:(UIButton *)btn {
    _cancelCallback();
}

@end
