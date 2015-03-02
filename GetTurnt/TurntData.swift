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
    
    // current game info
    var currentGame: PFObject?
    
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
    
    // Wines : [String:String]
    // var wines = ["bobby":"merlot","max":"champagne"]
    
    // Ratings : [String:[String:Int]]
    // var ratings = ["bobby":["champagne":6,"merlot":10],"max":["merlot":5,"champagne":8]]
    

    // NEEDS WORK
    func savePlayerRatings(selectedGameID: String, andRatings ratings: [String:Int]) {
        
        var query = PFQuery(className:"Game")
        query.getObjectInBackgroundWithId(selectedGameID, block: { (game, error) -> Void in
            
            if error != nil {
                println(error)
            } else {
                
                let currentGame: PFObject = game
                
                if var info = currentGame["playerRatings"] as? [String:[String:Int]] {

                    if var myRatings = info[PFUser.currentUser().username] as [String:Int]? {
                        // this will run if user already has ratings...

                        var newRatings: [String:Int] = [:]
                        
                        for (wine,rating) in myRatings { newRatings[wine] = rating }
                        for (wine,rating) in ratings { newRatings[wine] = rating }

                        currentGame["playerRatings"] = [PFUser.currentUser().username : newRatings]
                        
//                        currentGame["playerRatings"].addObject(myRatings)
//                        currentGame["playerRatings"] = [PFUser.currentUser().username : ratings]
                    }
                    
                    
                    // ADD WINE NAME AND RATING
//                    currentGame["playerRatings"] = info
                    
                } else {
                    // this will run if no one has rated anything yet
                    currentGame["playerRatings"] = [PFUser.currentUser().username : ratings]
                }
                
                currentGame.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    if success {
                        println("Player ratings saved successfully to Parse.")

                    } else {
                        println("Parse Error: \(error)")
                    }
                    
                })
                
                
            }
            
        })
        
    }
    
    
    class func mainData() -> TurntData {
        
        return _mainData
        
    }
    
    
    
   
}
