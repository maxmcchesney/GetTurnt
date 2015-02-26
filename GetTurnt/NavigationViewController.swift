//
//  NavigationViewController.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/25/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        navigationController.navigationBar.barTintColor = UIColor.greenColor()
        
        self.navigationBar.barTintColor = UIColor(red:0.15, green:0.55, blue:0.1, alpha:0.2)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
//    
////        UINavigationBar.appearance().backgroundColor = UIColor.greenColor()
//        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//        UITabBar.appearance().backgroundColor = UIColor.yellowColor();
//        UINavigationBar.appearance().backItem?.backBarButtonItem?.tintColor = UIColor.whiteColor()
        
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
