//
//  Shape.swift
//  1swift初见
//
//  Created by 黄成都 on 15/8/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import Foundation

class NameShape {
    var numberOfSides:Int = 0
    var name:String
    init(name:String){
        self.name = name
    }
    deinit{
    
    }
    func simpleDescription() -> String{
        return "A shape with \(numberOfSides) sides."
    }
}