//
//  HostNewGameVC.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class HostNewGameVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var wineTypeControl: UISegmentedControl!
    @IBOutlet weak var bottleCountLabel: UILabel!
    @IBOutlet weak var wineTypeTextField: UITextField!
    @IBOutlet weak var bottlesRequiredControl: UIStepper!
    
    var bottlesRequired: Double = 2
    var wineColor = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // set defaults
        bottleCountLabel.text = "# of Bottles / Person: \(bottlesRequired)"
        wineColor = wineTypeControl.titleForSegmentAtIndex(wineTypeControl.selectedSegmentIndex)!
        
        groupNameTextField.delegate = self
        wineTypeTextField.delegate = self
        
    }
    
    // hide text field when 'done' key is pressed
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    @IBAction func changeWineColor(sender: UISegmentedControl) {
        
        wineColor = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
//        println(wineColor)
    }

    @IBAction func changeBottleCount(sender: UIStepper) {
        // update bottle count label when stepper is pressed
        bottlesRequired = sender.value
        bottleCountLabel.text = "# of Bottles / Person: \(bottlesRequired)"
    }

    
    @IBAction func createGame(sender: AnyObject) {
        
        if groupNameTextField.text == "" {
        
            // fields are not filled in
            var alertViewController = UIAlertController(title: "Submission Error", message: "Group Name is required.", preferredStyle: UIAlertControllerStyle.Alert)
            
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
            return
        }
        
        
        // create new game and send info to Parse
        println("Creating new game...")
        
        var newGame = PFObject(className: "Game")
        newGame["groupName"] = groupNameTextField.text
        newGame["wineColor"] = wineColor
        newGame["bottlesRequired"] = bottlesRequired
        newGame["creator"] = PFUser.currentUser()
        newGame["host"] = PFUser.currentUser().username

        if wineTypeTextField.text != "" {
            newGame["wineType"] = wineTypeTextField.text
        } else {
            newGame["wineType"] = "Any"
        }
        
        // add new game to singleton and parse
//        TurntData.mainData().gameFeedItems.append(newGame)
        newGame.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                println("New Game saved successfully")
            } else {
                println("Game not saved. Error: \(error)")
            }
            TurntData.mainData().refreshGameFeedItems({ () -> () in
                println("Game Feed refreshed.")
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
