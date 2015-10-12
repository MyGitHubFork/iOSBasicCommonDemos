//
//  Player.swift
//  StoryBoard教程第一季
//
//  Created by aiteyuan on 15/1/29.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import Foundation
class Player: NSObject {
    var name: String
    var game: String
    var rating: Int
    
    init(name: String, game: String, rating: Int) {
        self.name = name
        self.game = game
        self.rating = rating
        super.init()
    }
}