//
//  UserWineInfoViewController.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/26/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class UserWineInfoViewController: UIViewController {
    
    @IBOutlet weak var brandTextField: UITextField!
    
    var selectedGameID: String?
//    var currentGame: PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func saveWines(sender: AnyObject) {
        
        // check to see if user entered brand
        if brandTextField.text == "" {
            
            // fields are not filled in
            var alertViewController = UIAlertController(title: "Submission Error", message: "Wine brand is required.", preferredStyle: UIAlertControllerStyle.Alert)
            
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
            return
            
        } else {
            // brand is entered, add it to Parse
            
            println("Saving player's wine...")

            
            // Load current game and save it to singleton
            var query = PFQuery(className:"Game")
            query.getObjectInBackgroundWithId(selectedGameID, block: { (game, error) -> Void in
                
                println(self.selectedGameID)
                if error != nil {
                    println(error)
                } else {
//                    println(game)
                    
                    let currentGame: PFObject = game
                    
                    if var info = currentGame["playerInfo"] as? [String:String] {
                            // add wine and player to game
                            info[PFUser.currentUser().username] = self.brandTextField.text
                            currentGame["playerInfo"] = info

                    } else {
                        // add wine and player to game
                        currentGame["playerInfo"] = [PFUser.currentUser().username : self.brandTextField.text]
                    }
                    
                    currentGame.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                        if success {
                            println("Player info saved successfully to Parse.")
                            
                            TurntData.mainData().currentGame = currentGame
                            let gameTVC = self.storyboard?.instantiateViewControllerWithIdentifier("gameTVC") as GameTVC

                            self.navigationController?.pushViewController(gameTVC, animated: true)
                            
                        } else {
                            println("Parse Error: \(error)")
                        }
                        
                    })
                    
                    
                }
                
            })
    
        }
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
