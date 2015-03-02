//
//  InGameTableViewCell.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/26/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class InGameTableViewCell: UITableViewCell, CustomSliderDelegate {

    var hostName: String?
    var playerName: String?
    var playerWine: String?
    var rating: Int?
    var playerIsHost: Bool!
    var selectedGameID: String?
    
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: CustomSlider!
    @IBOutlet weak var wineNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    func sliderValue(value: Float, forSlider sliderType: String!) {
        
        var rating = Int(floor(value * 10))

        ratingLabel.text = "\(rating)"
        
        // TODO: SAVE THE RATING TO PARSE / SINGLETON
        
    }
    
    func saveValue() {
        
        TurntData.mainData().savePlayerRatings(selectedGameID!, andRatings: [wineNameLabel.text!:ratingLabel.text!.toInt()!])
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ratingSlider.delegate = self
        
        wineNameLabel.hidden = false
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
