//
//  cardStruct.swift
//  EnumRank
//
//  Created by yifan on 15/8/17.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import Foundation

struct Card {
    var rank:Rank
    var suit:Suit
    func simpleDescription()->String{
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}