//
//  Question_sport.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 19/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class Question_sport: UIViewController {
    
    
    @IBOutlet weak var qu1: UITextField!
    @IBOutlet weak var qu2: UITextField!
    @IBOutlet weak var qu3: UITextField!
    @IBOutlet weak var qu4: UITextField!
    @IBOutlet weak var qu5: UITextField!
    
    @IBAction func send_sport(sender: AnyObject) {
    
        let prefs = NSUserDefaults.standardUserDefaults()
        let client = prefs.objectForKey("clientencours") as! String
        
        let q1:NSString = qu1.text!
        let q2:NSString = qu2.text!
        let q3:NSString = qu3.text!
        let q4:NSString = qu4.text!
        let q5:NSString = qu5.text!
        
        var json = "{\"email\": \"" + client
        json = json + "\", \"1\": \"" + (q1 as String)
        json = json + "\", \"2\": \"" + (q2 as String)
        json = json + "\", \"3\": \"" + (q3 as String)
        json = json + "\", \"4\": \"" + (q4 as String)
        json = json + "\", \"5\": \"" + (q5 as String) + "\"}"
        
        print(json)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}