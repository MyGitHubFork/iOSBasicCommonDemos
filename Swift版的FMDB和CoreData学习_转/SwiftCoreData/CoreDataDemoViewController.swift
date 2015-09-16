//
//  CoreDataDemoViewController.swift
//  SwiftCoreDataDemo
//
//  Created by Limin Du on 11/18/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import Foundation
import UIKit

class CoreDataDemoViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate, GADInterstitialDelegate {
    
    var people = [PersonModal]()
    var dal:CoreDataDAL!
    
    var interstitial:GADInterstitial?
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: "addPerson")
        
        self.navigationItem.rightBarButtonItem = addButton
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        interstitial = createAndLoadInterstitial()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayInterstitial", name: "kDisplayInterstitialNotification", object: nil)
        
        dal = CoreDataDAL()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillTerminate", name: UIApplicationWillTerminateNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        people = dal.getAllPersons()
    
        self.tableView.reloadData()
    }
    
    func addPerson() {
        println("in add Person")
        
        var alert = UIAlertController(title: "New Person", message: "Add a new Person", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
                let textField = alert.textFields![0] as UITextField
                self.saveName(textField.text)
                self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveName(name: String) {
        if let person = dal.savePerson(name) {
            people.append(person)
            
            NSNotificationCenter.defaultCenter().postNotificationName("kDisplayInterstitialNotification", object: nil)
        }
    }
    
    func applicationWillTerminate() {
        print("in applicationWillTerminate")
        dal.saveContext()
    }
    
    //table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = indexPath.row
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        let person = people[indexPath.row]
        cell.textLabel!.text = person.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let person = people[indexPath.row]
        if self.dal.deletePerson(person.name) {
            self.people.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    //Interstitial func
    func createAndLoadInterstitial()->GADInterstitial {
        var interstitial = GADInterstitial()
        interstitial.delegate = self
        interstitial.adUnitID = "ca-app-pub-6938332798224330/6206234808"
        interstitial.loadRequest(GADRequest())
        
        return interstitial
    }
    
    //Interstitial delegate
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("interstitialDidFailToReceiveAdWithError:\(error.localizedDescription)")
        interstitial = createAndLoadInterstitial()
    }
    
    func interstitialWillDismissScreen(ad: GADInterstitial!) {
        
    }
    
    func displayInterstitial() {
        if let isReady = interstitial?.isReady {
            if interstitial?.hasBeenUsed != true {
                interstitial?.presentFromRootViewController(self)
            }
        }
    }
}