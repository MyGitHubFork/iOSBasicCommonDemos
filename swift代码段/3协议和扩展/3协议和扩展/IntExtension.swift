//
//  IntExtension.swift
//  3协议和扩展
//
//  Created by yifan on 15/8/17.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import Foundation
//Int类型的扩展
extension Int:ExampleProtocol{
    var simpleDescription:String{
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}