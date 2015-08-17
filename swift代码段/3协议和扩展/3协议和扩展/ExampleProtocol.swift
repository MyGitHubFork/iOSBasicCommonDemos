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
    mutating func adjust()
}
