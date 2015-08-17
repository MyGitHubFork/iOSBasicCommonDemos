//
//  ViewController.swift
//  EnumRank
//
//  Created by yifan on 15/8/17.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ace = Rank.Ace
        let aceRawValue = ace.rawValue
        print("aceRawValue is \(aceRawValue) \n")
        
        if let convertedRank = Rank(rawValue: 12){
            let threeDescription = convertedRank.simpleDescription()
            print("threeDescription is \(threeDescription) \n")
        }
        
        print("============================================")
        let threeOfSpades = Card(rank: .Three, suit: .Spades)
        let threeOfSpadesDescription = threeOfSpades.simpleDescription()
        print("\n  \(threeOfSpadesDescription)  \n")
        
        print("============================================")
        let success = ServerResponse.Result("6:00 am", "8:09 pm")
        let failure = ServerResponse.Error("Out of cheese.")
        print("\n")
        switch failure {
        case let .Result(sunrise, sunset):
            let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
            print(serverResponse)
        case let .Error(error):
            let serverResponse = "Failure...  \(error)"
            print(serverResponse)
        }
        print("\n")
        
    }

    
}

