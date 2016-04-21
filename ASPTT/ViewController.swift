//
//  ViewController.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 12/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Mdp: UITextField!
    @IBOutlet weak var titre: UIImageView!
    @IBOutlet weak var fond: UIImageView!
    @IBOutlet weak var logpart1: UIImageView!
    @IBOutlet weak var logpart2: UIImageView!
    @IBOutlet weak var Inscription: UIButton!
    @IBOutlet weak var Connexion: UIButton!
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    

   @IBAction func connexion(sender: AnyObject) {
        let mail = Email.text!
        print(mail)
        let mdp = Mdp.text!
        print(mdp)
    
    let json = "{\"email\": \"" + mail + "\", \"mdp\": \"" + mdp + "\"}";
    print(json)
    
    
    
    
    let username:NSString = Email.text!
    let password:NSString = Mdp.text!
    
    if ( username.isEqualToString("") || password.isEqualToString("") ) {
    
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Erreur"
        alertView.message = "Veuillez entrer votre identifiant et votre mot de passe !"
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
    } else {
    
        do {
            let post:NSString = "json=\(json)"
    
            NSLog("PostData: %@",post);
    
            let url:NSURL = NSURL(string:"https://nodeapi-robotbobtm.c9users.io:8081/api/connect")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
    
            let postLength:NSString = String( postData.length )
    
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        
            var reponseError: NSError?
            var response: NSURLResponse?
    
            var urlData: NSData?
                do {
                    urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                } catch let error as NSError {
                    reponseError = error
                    urlData = nil
            }
    
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
    
                NSLog("Response code: %ld", res.statusCode);
    
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
    
                    NSLog("Response ==> %@", responseData);
    
    //var error: NSError?
    
                    let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    
                    let success:NSInteger = jsonData.valueForKey("role") as! NSInteger
    //[jsonData[@"success"] integerValue];
                    NSLog("Success: %ld", success);
                    if(success == 1)
                    {
                        NSLog("Login SUCCESS");
    
                        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        prefs.setObject(username, forKey: "email")
                        prefs.setInteger(1, forKey: "LOGGEDAS")
                        prefs.synchronize()
                        self.performSegueWithIdentifier("goto_coach", sender: self)
                        
                       // self.dismissViewControllerAnimated(true, completion: nil)
                    }else if(success == 0)
                    {
                        NSLog("Login SUCCESS");
                        
                        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                         let coach = jsonData.valueForKey("coach") as! String
                        prefs.setObject(username, forKey: "email")
                        prefs.setObject(coach, forKey: "coach")
                        prefs.setInteger(1, forKey: "LOGGEDAS")
                        prefs.synchronize()
                        self.performSegueWithIdentifier("goto_client", sender: self)
                        
                        // self.dismissViewControllerAnimated(true, completion: nil)
                    }
                        
                    else {
                        var error_msg:NSString
    
                        if jsonData["message"] as? NSString != nil {
                            error_msg = jsonData["message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
    
                    }
    
    } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
    } else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        } catch {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Server Error"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
}
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.titre.alpha = 0.0
        self.fond.alpha = 0.0
        self.Email.alpha = 0.0
        self.Mdp.alpha = 0.0
        self.Inscription.alpha = 0.0
        self.Connexion.alpha = 0.0
        
        UIView.animateWithDuration(3.0, delay: 1, options: .CurveEaseInOut, animations:
            {
                self.titre.alpha = 1
            }, completion: { finished in})
        
        UIView.animateWithDuration(1.0, delay: 0.5, options: .CurveEaseInOut, animations:
            {
                self.logpart1.frame = CGRect(x: 78, y: 225, width: 167, height: 110)
                self.logpart2.frame = CGRect(x: 94, y: 225, width: 141, height: 110)
            }, completion: { finished in})
        
        UIView.animateWithDuration(2, delay: 3, options: .CurveEaseInOut, animations:
            {
                self.titre.frame = CGRect(x: 40, y: -10, width: 240, height: 128)
                self.logpart1.alpha = 0
                self.logpart2.alpha = 0
                self.fond.alpha = 0.5
                self.Email.alpha = 1
                self.Mdp.alpha = 1
                self.Inscription.alpha = 1
                self.Connexion.alpha = 1
            }, completion: { finished in})
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

