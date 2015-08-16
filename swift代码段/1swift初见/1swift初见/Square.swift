//
//  Square.swift
//  1swift初见
//
//  Created by 黄成都 on 15/8/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import Foundation

class Square: NameShape {
    var sideLength:Double
    
    init(sideLength:Double,name:String){
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area()->Double{
        return sideLength * sideLength
    }
    override func simpleDescription() -> String {
        return "A square with sides of length\(sideLength)"
    }
}