//
//  ViewController.swift
//  基础部分
//
//  Created by 黄成都 on 15/8/18.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //元组
        let http404Error = (404,"Not Found")
        let (statusCode,statusMessage) = http404Error
        println("The status code is \(statusCode)")
        println("the status message is \(statusMessage)")
        println("the status code is \(http404Error.0)")
        println("=====================================")
        let http200Status = (statusCode1:200,description1:"ok")
        println("The status code is \(http200Status.statusCode1)")
        println("=============可选类型================")
        let possibleNumber = "123"
        let convertedNumber:Int? = possibleNumber.toInt()
        println(convertedNumber)
        println("=============隐式可选类型=========")
        let possibleString:String? = "An optional string."
        let forcedString:String = possibleString!
        let assumedString:String! = "An implicitly unwrapped."
        let implicitString:String = assumedString
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

