//
//  MinuteurViewController.swift
//  ASPTT
//
//  Created by Thibault FRANCOIS on 21/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import UIKit

class MinuteurViewController:UIViewController {


    @IBOutlet var HeureField: UITextField!
    @IBOutlet var MinutesField: UITextField!
    @IBOutlet var SecondField: UITextField!
    @IBOutlet var viewtextfield: UIView!
    
    @IBOutlet var HeureMinuteur: UILabel!
    @IBOutlet var MinutesMinteurs: UILabel!
    @IBOutlet var SecondMinuteur: UILabel!


    @IBOutlet var start: UIView!
    @IBOutlet var clear: UIView!
    
    var StockCount:Int?
    var StockCount2:Int?
    var StockCount3:Int?
    var timer1 = NSTimer()
    
    func updateCounter1() {
        if (StockCount > -1)
        {
            if (StockCount < 10)
            {
                SecondMinuteur.text = String(0)+String(StockCount!)
                StockCount = StockCount! - 1
            }
            else
            {
                SecondMinuteur.text = String(StockCount!)
                StockCount = StockCount! - 1
            }
        }
        else if (StockCount2 > 0)
        {
            if (StockCount2 < 11)
            {
                StockCount = StockCount! + 59
                SecondMinuteur.text = String(StockCount!)
                StockCount2 = StockCount2! - 1
                MinutesMinteurs.text = String(0)+String(StockCount2!)
            }
            else
            {
                StockCount = StockCount! + 59
                SecondMinuteur.text = String(StockCount!)
                StockCount2 = StockCount2! - 1
                MinutesMinteurs.text = String(StockCount2!)
            }
        }
        else if (StockCount3 > 0)
        {
            if (StockCount3 < 11)
            {
                StockCount = StockCount! + 59
                StockCount2 = StockCount2! + 59
                SecondMinuteur.text = String(StockCount!)
                MinutesMinteurs.text = String(StockCount2!)
                StockCount3 = StockCount3! - 1
                HeureMinuteur.text = String(0)+String(StockCount3!)
            }
            else
            {
                StockCount = StockCount! + 59
                StockCount2 = StockCount2! + 59
                SecondMinuteur.text = String(StockCount!)
                MinutesMinteurs.text = String(StockCount2!)
                StockCount3 = StockCount3! - 1
                HeureMinuteur.text = String(StockCount3!)
            }
        }
        else
        {
            SecondMinuteur.text = String(0)+String(0)
            MinutesMinteurs.text = String(0)+String(0)
            HeureMinuteur.text = String(0)+String(0)
            timer1.invalidate()
            self.start.alpha = 1
            self.viewtextfield.alpha = 1
            self.clear.alpha = 0
        }
    }
    

    @IBAction func startButton(sender: UIButton) {
        self.viewtextfield.alpha = 0.0
        self.clear.alpha = 1
        self.start.alpha = 0
        
        if (StockCount <= 60 && StockCount2 <= 60 && StockCount3 <= 60)
        {
            SecondMinuteur.text = SecondField.text
            MinutesMinteurs.text = MinutesField.text
            HeureMinuteur.text = HeureField.text
            
            if let counter1 = NSNumberFormatter().numberFromString(SecondField.text!)
            {
                StockCount = counter1.integerValue
            }
            if let counter2 = NSNumberFormatter().numberFromString(MinutesField.text!)
            {
                StockCount2 = counter2.integerValue
            }
            if let counter3 = NSNumberFormatter().numberFromString(HeureField.text!)
            {
                StockCount3 = counter3.integerValue
            }
            timer1 = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: #selector(MinuteurViewController.updateCounter1),   userInfo: nil, repeats: true)
        }
        else
        {
            SecondMinuteur.text = String(0)+String(0)
            MinutesMinteurs.text = String(0)+String(0)
            HeureMinuteur.text = String(0)+String(0)
        }
    }
    

    @IBAction func pauseButton(sender: UIButton) {
        self.start.alpha = 1
        self.clear.alpha = 0
        timer1.invalidate()
    }
    

    @IBAction func clearButton(sender: UIButton) {
        self.viewtextfield.alpha = 1
        self.start.alpha = 1
        self.clear.alpha = 0
        timer1.invalidate()
        SecondMinuteur.text = String(0)+String(0)
        MinutesMinteurs.text = String(0)+String(0)
        HeureMinuteur.text = String(0)+String(0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}