//
//  GameTVC.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/15/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class GameTVC: UITableViewController {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var showWineButton: UIButton!
    @IBOutlet weak var hostLabel: UILabel!
    
    var currentGame: PFObject?
    var gameItems: [String:String] = ["":""]
    
    var wineNamesVisible: Bool = false
    @IBAction func showWineNames(sender: AnyObject) {
        // toggle the wine / player names

        if wineNamesVisible {
            wineNamesVisible = false
            showWineButton.setTitle("Show Wines", forState: .Normal)
            tableView.reloadData()
        } else {
            wineNamesVisible = true
            tableView.reloadData()
            showWineButton.setTitle("Hide Wines", forState: .Normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        

    }
    
    override func viewWillAppear(animated: Bool) {
        
        currentGame = TurntData.mainData().currentGame
        
        gameItems = currentGame?.valueForKey("playerInfo") as [String:String]
        
        groupNameLabel.text = currentGame?.valueForKey("groupName") as? String
        
        let host = currentGame?.valueForKey("host") as? String

        showWineButton.hidden = true
        hostLabel.hidden = true
        
        if host == PFUser.currentUser().username {
        
            showWineButton.hidden = false
            hostLabel.hidden = false
        
        }
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
//        println(gameItems.count)
        return gameItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wineCell", forIndexPath: indexPath) as InGameTableViewCell

        let name = gameItems.keys.array[indexPath.row]
        let wine = gameItems[name]!
        
        cell.selectedGameID = currentGame?.objectId

        cell.stationLabel.text = "Station #\(indexPath.row + 1)"
        
        cell.wineNameLabel.text = wine
        cell.usernameLabel.text = name
        cell.wineNameLabel.hidden = true
        cell.usernameLabel.hidden = true
        
        if wineNamesVisible {
            cell.wineNameLabel.hidden = false
            cell.usernameLabel.hidden = false
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
