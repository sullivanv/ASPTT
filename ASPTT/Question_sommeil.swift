//
//  Question_sommeil.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 19/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class Question_sommeil: UIViewController {
    
    @IBOutlet weak var qu21: UITextField!
    @IBOutlet weak var qu22: UITextField!
    @IBOutlet weak var qu23: UITextField!
    
    @IBAction func send_sommeil(sender: AnyObject) {
        let prefs = NSUserDefaults.standardUserDefaults()
        let client = prefs.objectForKey("clientencours") as! String
        
        let q21:NSString = qu21.text!
        let q22:NSString = qu22.text!
        let q23:NSString = qu23.text!
        
        var json = "{\"email\": \"" + client
        json = json + "\", \"21\": \"" + (q21 as String)
        json = json + "\", \"22\": \"" + (q22 as String)
        json = json + "\", \"23\": \"" + (q23 as String) + "\"}"
        
        print(json)
        do {
            let post:NSString = "json=\(json)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string:"https://nodeapi-robotbobtm.c9users.io:8081/api/reponseQuestion")!
            
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
                        print("GOOD")
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