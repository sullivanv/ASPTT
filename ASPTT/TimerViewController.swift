//
//  TimerViewController.swift
//  ASPTT
//
//  Created by Thibault FRANCOIS on 21/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import UIKit

class TimerViewController:UIViewController {

    @IBOutlet var countingLabel: UILabel!
    @IBOutlet var countingLabel2: UILabel!
    @IBOutlet var countingLabel3: UILabel!
    @IBOutlet var viewtest: UIView!
    @IBOutlet var viewtest2: UIView!
    @IBOutlet var viewlabel: UIView!
    
    var timer1 = NSTimer()
    var counter1 = 0
    var counter2 = 1
    var counter3 = 1
    
    func updateCounter1() {
        if (counter2 < 1)
        {
            counter2 = 1
        }
        
        if (counter3 < 1)
        {
            counter3 = 1
        }
        
        if (counter1 < 10)
        {
            countingLabel.text = String(0)+String(counter1++)
        }
        else
        {
            countingLabel.text = String(counter1++)
        }
        
        if (counter1 >= 61)
        {
            if (counter2 < 10)
            {
                counter1 = 1
                countingLabel2.text = String(0)+String(counter2++)
            }
            else
            {
                counter1 = 1
                countingLabel2.text = String(counter2++)
            }
        }
        if (counter2 >= 61)
        {
            if (counter3 < 10)
            {
                counter2 = 1
                countingLabel3.text = String(0)+String(counter3++)
            }
            else
            {
                counter2 = 1
                countingLabel3.text = String(counter3++)
            }
        }
    }
    
    @IBAction func startButton(sender: UIButton) {
        self.viewtest.alpha = 0.0
        self.viewtest2.alpha = 1
        self.viewlabel.alpha = 1
        timer1 = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: #selector(TimerViewController.updateCounter1), userInfo: nil, repeats: true)
        
    }

    @IBAction func pauseButton(sender: UIButton) {
        self.viewtest.alpha = 1
        self.viewtest2.alpha = 0
        timer1.invalidate()
    }
    

    @IBAction func clearButton(sender: UIButton) {
        self.viewtest.alpha = 1
        self.viewtest2.alpha = 0
        self.viewlabel.alpha = 0
        timer1.invalidate()
        counter1 = 0
        counter2 = 0
        counter3 = 0
        countingLabel.text = String(counter1)
        countingLabel2.text = String(counter2)
        countingLabel3.text = String(counter3)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewlabel.alpha = 0
        countingLabel.text = String(counter1)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}