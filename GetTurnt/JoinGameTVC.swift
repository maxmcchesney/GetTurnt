//
//  JoinGameTVC.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class JoinGameTVC: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refreshFeed() {
        
        TurntData.mainData().refreshGameFeedItems { () -> () in
            
            self.tableView.reloadData()
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshFeed()
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return TurntData.mainData().gameFeedItems.count
    }

    // set up cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameCell", forIndexPath: indexPath) as JoinGameTableViewCell

        // Configure the cell...
        let game = TurntData.mainData().gameFeedItems[indexPath.row]
        
        cell.gameInfo = game

        return cell
    }
    
    // user selects game to join, push new VC
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("User requests to join game...")
        
        let selectedGameID = TurntData.mainData().gameFeedItems[indexPath.row].objectId
        
        // Check if user already has wine types entered and if not push VC
        
        var query = PFQuery(className:"Game")
        query.getObjectInBackgroundWithId(selectedGameID, block: { (game, error) -> Void in
            
            if error != nil {
                println(error)
            } else {
                
                let currentGame: PFObject = game
                
                if var info = currentGame["playerInfo"] as? [String:String] {
                    
                    if info[PFUser.currentUser().username] != nil {
                        // if user already has wine in server, skip wine info VC
                        println("User already has wine type entered, going straight to game...")
                        TurntData.mainData().currentGame = currentGame
                        let gameTVC = self.storyboard?.instantiateViewControllerWithIdentifier("gameTVC") as GameTVC
                        self.navigationController?.pushViewController(gameTVC, animated: true)
                        
                    } else {
                        // send user to wine info vc to enter wine brand
                        println("User doesn't have wine type entered, requesting wine type...")
                        let userWineInfoVC = self.storyboard?.instantiateViewControllerWithIdentifier("userWineInfoVC") as UserWineInfoViewController
                        userWineInfoVC.selectedGameID = selectedGameID

                        self.navigationController?.pushViewController(userWineInfoVC, animated: true)
                        
                    }
   
                }
                
            }
            
        })
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        
        // only allow admin or maxmcchesney users to delete games
        if PFUser.currentUser().username as String == "maxmcchesney" || PFUser.currentUser().username as String == "admin" {
            return true
        } else {
            println("User not authorized to delete games...")
            return false
        }
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source

                println("Admin deleting game...")

                let id = TurntData.mainData().gameFeedItems[indexPath.row].objectId
                
                TurntData.mainData().gameFeedItems.removeAtIndex(indexPath.row)
                
                var query = PFQuery(className:"Game")
                query.getObjectInBackgroundWithId(id) {
                    (game: PFObject!, error: NSError!) -> Void in
                    if error == nil {
                        println("deleting game (id: \(id)) from Parse...")
                        
                        game.deleteInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                println("Game deleted successfully.")
                            } else {
                                println("Error while deleting from Parse: \(error)")
                            }
                        })
                        
                    } else {
                        println(error)
                    }
                }
        
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
