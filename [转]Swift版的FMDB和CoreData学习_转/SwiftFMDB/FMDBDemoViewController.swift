//
//  FMDBDemoViewController.swift
//  SwiftFMDBDemo
//
//  Created by Limin Du on 11/18/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import Foundation
import UIKit

class FMDBDemoViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate, GADInterstitialDelegate {
    let dal = EntryDAL()
    var data=[Entry]()
    
    var interstitial:GADInterstitial?
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: "addEntry")
        
        self.navigationItem.rightBarButtonItem = addButton
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        interstitial = createAndLoadInterstitial()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayInterstitial", name: "kDisplayInterstitialNotification", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        data = dal.getAllEntries()
    
        self.tableView.reloadData()
    }
    
    func addEntry() {
        println("in add Entry")
        
        let addVC = AddEntryViewController()
        let navVC = UINavigationController(rootViewController: addVC)
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "back")
        //backButton.tintColor = UIColor.redColor()
        addVC.navigationItem.setLeftBarButtonItem(backButton, animated: true)
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = indexPath.row
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = data[index].name
        cell.detailTextLabel?.text = data[index].description
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let e = data[indexPath.row]
        if dal.deleteEntry(e) {
            data.removeAtIndex(indexPath.row)
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
        interstitial = createAndLoadInterstitial()
    }
    
    /*func interstitialDidDismissScreen(ad: GADInterstitial!) {
        println("interstitialDidDismissScreen")
    }
    
    func interstitialWillLeaveApplication(ad: GADInterstitial!) {
        println("interstitialWillLeaveApplication")
    }
    
    func interstitialWillPresentScreen(ad: GADInterstitial!) {
        println("interstitialWillPresentScreen")
    }*/
    
    func displayInterstitial() {
        if let isReady = interstitial?.isReady {
            interstitial?.presentFromRootViewController(self)
        }
    }
}