//
//  question_autre.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 19/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class Question_autre: UIViewController {
    
    @IBAction func send_sport(sender: AnyObject) {
        let prefs = NSUserDefaults.standardUserDefaults()
        let client = prefs.objectForKey("clientencours") as! String
        
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