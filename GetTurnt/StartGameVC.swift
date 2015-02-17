//
//  StartGameViewController.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class StartGameVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    
    @IBAction func logOut(sender: AnyObject) {
        
        // log user out and present viewcontroller
        println("User logging out...")
        PFUser.logOut()
        TurntData.mainData().isLoggedIn = false
        dismissViewControllerAnimated(true, completion: nil)
        
        let lvc = storyboard?.instantiateViewControllerWithIdentifier("logInVC") as? LoginViewController

        presentViewController(lvc!, animated: true, completion: nil)
        
    }
    
    @IBAction func hostNewGame(sender: AnyObject) {
        println("User chooses to host new game...")
    }
    
    @IBAction func joinExistingGame(sender: AnyObject) {
        println("User chooses to join existing game...")
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
