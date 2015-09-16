//
//  PlayerDetailsViewController.swift
//  StoryBoard教程第一季
//
//  Created by aiteyuan on 15/1/29.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UITableViewController {
    var player:Player!
    var game:String = "Chess"
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = game
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    required init(coder aDecoder: NSCoder) {
        println("init PlayerDetailsViewController")
        super.init(coder: aDecoder)
    }
    
    deinit {
        println("deinit PlayerDetailsViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SavePlayerDetail" {
            player = Player(name: self.nameTextField.text, game: game, rating: 1)
        }
        if segue.identifier == "PickGame" {
            let gamePickerViewController = segue.destinationViewController as GamePickerViewController
            gamePickerViewController.selectedGame = game
        }
    }
    
    @IBAction func selectedGame(segue:UIStoryboardSegue) {
        let gamePickerViewController = segue.sourceViewController as GamePickerViewController
        if let selectedGame = gamePickerViewController.selectedGame {
            detailLabel.text = selectedGame
            game = selectedGame
        }
        self.navigationController?.popViewControllerAnimated(true)
        
    }
}
