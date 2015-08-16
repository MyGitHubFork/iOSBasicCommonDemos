//
//  AppDelegate.swift
//  1swift初见
//
//  Created by 黄成都 on 15/8/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var shoppingList = ["one","two","three","four"]
        shoppingList[1] = "bottle of water"
        print("\(shoppingList)\n")
        
        var occupations = [
            "Malcolm":"Captain",
            "kaylee":"Mechanic",
        ]
        occupations["Jayne"] = "Public Relations"
        print("\(occupations)\n")
        
        //空字典和空数组
        let emptyArray = [String]()
        let emptyDictionary = [String:Float]()
        
        var optionalString:String? = "Hello"
        print("\(optionalString == nil)\n")
        
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            let vegetableComment = "Add some raisins and make ants on a log."
        case "cucumber","watercress":
            let vegetableComment = "That would make a good tea sandwich."
        case let x where x.hasSuffix("pepper"):
            let vegetableComment = "Is it a spicy \(x)?"
        default:
            let vegetableComment = "Everything tastes good in soup."
        }
        
        var n = 2
        while n < 100{
            n = n * 2
        }
        print(n)
        print("\n")
        
        var firstForLoop = 0
        for i in 0...4{
            firstForLoop += i
        }
        print(firstForLoop)
        print("\n")
        
        let result:String = greet("Bob", day: "Tuesday")
        print(result)
        print("\n")
        //返回元组
        let statistics = calculateStatistics([5,3,100,3,9])
        print(statistics.sum)
        print("\n")
        print(statistics.2)
        print("\n")
        //可变参数列表
        let total = sumOf(10,20,30,40,40,3)
        print(total)
        print("\n")
        //嵌套函数
        let qiantao:Int = returnFifteen()
        print(qiantao)
        print("\n")
        //返回一个函数
        var increment = makeIncrementer()
        var result1 = increment(7)//调用返回的函数对象
        print(result1)
        print("\n")
        //函数作为参数传入
        var numbers = [20,19,7,12]
        var boolValue:Bool = hasAnyMatches(numbers, condition: lessThanTen)
        print(boolValue)
        print("\n")
        return true
    }

    func greet(name:String, day:String) -> String{
        return "Hello\(name),today is \(day)"
    }
    
    //返回元组
    func calculateStatistics(scores:[Int]) -> (min:Int ,max:Int, sum:Int){
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        for score in scores{
            if score > max{
                max = score
            }else if score < min{
                min = score
            }
            sum = sum + score
        }
        return (min,max,sum)
    }
    //可变参数
    func sumOf(numbers:Int...) -> Int{
        var sum = 0
        for number in numbers{
            sum = sum + number
        }
        return sum
    }
    //函数嵌套
    func returnFifteen() -> Int{
        var y:Int = 10
        func add(){
            y = y + 5
        }
        add()//调用嵌套函数
        return y
    }
    //返回值是函数
    func makeIncrementer() -> (Int -> Int){
        func addOne(number:Int) -> Int{
            return number + 1
        }
        return addOne
    }
    //函数作为参数传入 condition:Int -> Bool
    func hasAnyMatches(list:[Int], condition:Int -> Bool) -> Bool{
        for item in list{
            if condition(item){
                return true
            }
        }
        return false
    }
    func lessThanTen(number:Int) -> Bool{
        return number < 10
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

