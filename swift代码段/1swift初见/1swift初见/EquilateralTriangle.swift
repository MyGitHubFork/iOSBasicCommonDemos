//
//  EquilateralTriangle.swift
//  1swift初见
//
//  Created by 黄成都 on 15/8/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import Foundation

class EquilateralTriangle: NameShape {
    var sideLength:Double = 0.0
    init(sideLength:Double, name:String){
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    //计算属性
    var perimeter:Double{
        get{
            return 3.0 * sideLength
        }
        set{
            sideLength = newValue/3.0
        }
    }
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)"
    }
}