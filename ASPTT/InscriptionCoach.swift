//
//  InscriptionCoach.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 21/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class InscriptionCoach: UIViewController {
   
    @IBOutlet weak var Mail: UITextField!
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var mdp1: UITextField!
    @IBOutlet weak var prenom1: UITextField!
    @IBOutlet weak var nom1: UITextField!
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    

    @IBAction func suiv(sender: AnyObject) {
        let email:NSString = Mail.text!
        let prenom:NSString = prenom1.text!
        let nom:NSString = nom1.text!
        let tel:NSString = telephone.text!
        let mdp:NSString = mdp1.text!
        
        
//        let prefs = NSUserDefaults.standardUserDefaults()
 //       let coach = prefs.objectForKey("email") as! String
  //
  //      prefs.setObject(email, forKey: "clientencours")
        
        
        if ( email.isEqualToString("") || prenom.isEqualToString("") || nom.isEqualToString("") || tel.isEqualToString("") || mdp.isEqualToString("") )
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Erreur"
            alertView.message = "Veuillez remplir tous les champs !"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else{
            var json = "{\"email\": \"" + (email as String) + "\", \"password\": \"" + (mdp as String)// + "\"}"
            json = json + "\", \"nom\": \"" + (nom as String) + "\", \"prenom\": \"" + (prenom as String)
            json = json + "\", \"phone\": \"" + (tel as String)
            json = json + "\", \"role\": \"" + "1" + "\"}"
            
            
            
            
            
            
            
            do {
                let post:NSString = "json=\(json)"
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string:"https://nodeapi-robotbobtm.c9users.io:8081/api/add")!
                
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
                        
                        let success:NSInteger = jsonData.valueForKey("Error") as! NSInteger
                        
                        //[jsonData[@"success"] integerValue];
                        NSLog("Success: %ld", success);
                        if(success == 0)
                        {
                            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            prefs.setObject(email, forKey: "email")
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Bravo"
                            alertView.message = "Vous etes maintenant un coach certifie Le corps et l'esprit"
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                        self.performSegueWithIdentifier("goto_coachpage", sender: self)
                            print("OUUI")
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
    
    
    
    
    
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        
        if self.revealViewController() != nil {
            MenuButton.target = self.revealViewController()
            MenuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
}