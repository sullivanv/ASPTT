//
//  TimerSeance.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 21/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class TimerSeance: UIViewController {

    @IBOutlet weak var labelseance: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var seconde: UILabel!
    @IBOutlet weak var heure: UILabel!
    @IBOutlet weak var minute: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var debut: UIButton!
    @IBOutlet weak var viewdebut: UIView!

    
    var sec = 0
    var min = 0
    var h = 0
    var timer = NSTimer()
    
    
    func update() {
        if (min == 60) {
            h = h + 1
            min = 0
        }
        if (sec == 60) {
            min = min + 1
            sec = -1
        }
        heure.text = String(h)
        minute.text = String(min)
        seconde.text = String(sec + 1)
        if (sec + 1 <= 9) {
            seconde.text = "0" + seconde.text!
        }
        if (min <= 9) {
            minute.text = "0" + minute.text!
        }
        sec = sec + 1
    }
    
    @IBAction func DebuterSeance(sender: AnyObject) {
        labelseance.hidden = false
       view1.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: #selector(TimerSeance.update), userInfo: nil, repeats: true)
            viewdebut.hidden = true
        
    }
    
    @IBAction func FinSeance(sender: AnyObject) {
        labelseance.text = "La sceance a durée :"
        timer.invalidate()
    }
    override func viewDidLoad() {
        let prefs = NSUserDefaults.standardUserDefaults()
        label.text = "Le client est : " + "flo"//(prefs.objectForKey("client") as! String!)
        
    }
}