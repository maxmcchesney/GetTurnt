//
//  TurntData.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

let _mainData: TurntData = TurntData()

class TurntData: NSObject {
    
    
    var isLoggedIn: Bool {
        
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn")
        }
        
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "isLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var currentGame: PFObject?  // is this being used?
    
    
    // existing games list
    var gameFeedItems: [PFObject] = []
    
    func refreshGameFeedItems(completion: () -> ()) {
        
        var feedQuery = PFQuery(className: "Game")
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects.count > 0 {
                
                self.gameFeedItems = objects as [PFObject]
                
            }
            
            completion()
            
        }
        
    }
    
    // current game wine list
    var currentGameItems: [PFObject] = []
    
    func refreshCurrentGameFeedItems(completion: () -> ()) {
        
        var feedQuery = PFQuery(className: "Game")
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects.count > 0 {
                
                self.gameFeedItems = objects as [PFObject]
                
            }
            
            completion()
            
        }
        
    }
    
    
    class func mainData() -> TurntData {
        
        return _mainData
        
    }
    
    
    
   
}
