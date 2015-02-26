//
//  InGameTableViewCell.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/26/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class InGameTableViewCell: UITableViewCell, CustomSliderDelegate {

    var playerName: String?
    var playerWine: String?
    var rating: Int?
    
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var ratingSlider: CustomSlider!
    
    func sliderValue(value: Float, forSlider sliderType: String!) {
        
        var rating = Int(floor(value * 10))

        ratingLabel.text = "\(rating)"
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ratingSlider.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
