//
//  CustomButton.swift
//  GetTurnt
//
//  Created by Michael McChesney on 2/9/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    @IBInspectable var strokeSize: CGFloat = 1 {
        didSet {
            layer.borderWidth = strokeSize
        }
    }
    
    @IBInspectable var strokeColor: UIColor = UIColor.darkGrayColor() {
        didSet {
            layer.borderColor = strokeColor.CGColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    /*
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
