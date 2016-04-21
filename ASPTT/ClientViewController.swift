//
//  ClientViewController.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 15/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class ClientViewController: UIViewController {
    
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBOutlet weak var nomcoach: UILabel!
    @IBOutlet weak var prevision1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            MenuButton.target = self.revealViewController()
            MenuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let prefs = NSUserDefaults.standardUserDefaults()
        
        let coach = prefs.objectForKey("coach") as! String!
        nomcoach.text = "Votre coach est : " + coach
       // let prev = prefs.objectForKey("prevision") as! Int!

        
        if ((prefs.objectForKey("prevision")) != nil)
        {
            prevision1.text = "Aucune séance de prévue"
            prefs.setObject(nil, forKey: "prevision")
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}