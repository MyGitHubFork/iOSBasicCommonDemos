//
//  ExampleProtocol.swift
//  3协议和扩展
//
//  Created by yifan on 15/8/17.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import Foundation

protocol ExampleProtocol{
    var simpleDescription:String{get}
    mutating func adjust()//注意声明SimpleStructure时候mutating关键字用来标记一个会修改结构体的方法
}
