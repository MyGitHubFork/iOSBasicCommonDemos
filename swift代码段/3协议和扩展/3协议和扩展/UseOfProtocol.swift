//
//  UseOfProtocol.swift
//  3协议和扩展
//
//  Created by yifan on 15/8/17.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import Foundation

class SimpleClass: ExampleProtocol {
    var simpleDescription:String = "A very simple class."
    var anotherProperty:Int = 69105
    func adjust() {
        simpleDescription += "Now 100% adjusted."
    }
}

struct SimpleStructure:ExampleProtocol {
    var simpleDescription:String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}