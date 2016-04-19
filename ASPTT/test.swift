//
//  test.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 13/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import UIKit

class test: UIViewController {

    @IBOutlet weak var my_border_b: UIButton!
    @IBOutlet weak var fond2: UIImageView!
    @IBOutlet weak var my_border: UIButton!
    @IBOutlet weak var Red1: UIImageView!
    @IBOutlet weak var Red2: UIImageView!
    let myColor : UIColor = UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )

    
    @IBAction func setDefaultLabelText(sender: UIButton) {
        my_border.layer.borderWidth = 1
        my_border.layer.borderColor = myColor.CGColor
        my_border_b.layer.borderWidth = 1
        my_border_b.layer.borderColor = myColor.CGColor
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.fond2.alpha = 0.9
        my_border_b.backgroundColor = UIColor(
            red:0.65,
            green:0.65,
            blue:0.65,
            alpha:0.0)
        my_border.backgroundColor = UIColor(
            red:0.65,
            green:0.65,
            blue:0.65,
            alpha:0.0)
        
        UIView.animateWithDuration(2.0, delay: 0, options: .CurveEaseInOut, animations:
            {
                self.my_border_b.backgroundColor = UIColor(
                    red:0.65,
                    green:0.65,
                    blue:0.65,
                    alpha:0.8)
                self.my_border.backgroundColor = UIColor(
                    red:0.65,
                    green:0.65,
                    blue:0.65,
                    alpha:0.8)
                self.Red1.frame = CGRect(x: 0, y: 255, width: 320, height: 5)
                self.Red2.frame = CGRect(x: 0, y: 386, width: 320, height: 5)
            }, completion: { finished in})
    }
}
