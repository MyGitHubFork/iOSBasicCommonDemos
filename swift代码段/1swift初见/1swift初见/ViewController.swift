//
//  ViewController.swift
//  1swift初见
//
//  Created by 黄成都 on 15/8/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("===========================================")
        let test = Square(sideLength: 5.2, name: "my test square")
        let area = test.area()
        print("\n")
        print(area)
        print("\n")
        print(test.simpleDescription())
        print("\n")
        print("===========================================")
        var triangle = EquilateralTriangle(sideLength: 3.1, name: "a griangle")
        print(triangle.perimeter)
        print("\n")
        triangle.perimeter = 9.9
        print(triangle.sideLength)
        print("\n")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

