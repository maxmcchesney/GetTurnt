//
//  JoinGameTableViewCell.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class JoinGameTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var varietyLabel: UILabel!
    @IBOutlet weak var bottlesRequiredLabel: UILabel!
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    
    
    
    var gameInfo: PFObject? {
        
        didSet {
            
            // set each cells info labels
            groupNameLabel.text = gameInfo?["groupName"] as? String
            colorLabel.text = gameInfo?["wineColor"] as? String
            varietyLabel.text = gameInfo?["wineType"] as? String

            if let numberRequired = gameInfo?["bottlesRequired"] as? Int {
                bottlesRequiredLabel.text = "\(numberRequired)"
            }
            
            hostNameLabel.text = gameInfo?["host"] as? String
            
            if let date = gameInfo?.createdAt {
                
                var dateFormatter = NSDateFormatter()
                var theDateFormat = NSDateFormatterStyle.ShortStyle
                dateFormatter.dateStyle = theDateFormat
                
                dateCreatedLabel.text = dateFormatter.stringFromDate(date)
                
            }
            
            let redWineImage = UIImage(named: "red_wine croped.png")
            let whiteWineImage = UIImage(named: "White-wine cropped.png")
            let bothWinesImage = UIImage(named: "bothWineGlasses.png")
            
            if colorLabel.text == "Red" {
                cellImageView.image = redWineImage
            } else if colorLabel.text == "White" {
                cellImageView.image = whiteWineImage
            } else {
                cellImageView.image = bothWinesImage
            }
            

        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func joinGame(sender: AnyObject) {
        println("User requests to join game...")
    
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)   // commented out so selected state doesn't affect view style

        // Configure the view for the selected state
    }

}
