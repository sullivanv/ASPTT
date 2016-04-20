//
//  Question_sante.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 19/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class Question_sante: UIViewController {
    
   
    @IBOutlet weak var qu6: UITextField!
    @IBOutlet weak var qu7: UITextField!
    @IBOutlet weak var qu8: UITextField!
    @IBOutlet weak var qu9: UITextField!
    @IBOutlet weak var qu10: UITextField!
    @IBOutlet weak var qu11: UITextField!
    @IBOutlet weak var qu12: UITextField!
    @IBOutlet weak var qu13: UITextField!
    @IBOutlet weak var qu14: UITextField!
    @IBOutlet weak var qu15: UITextField!
    @IBOutlet weak var qu16: UITextField!
    @IBOutlet weak var qu17: UITextField!
    
    
    @IBAction func send_sante(sender: AnyObject) {
        let prefs = NSUserDefaults.standardUserDefaults()
        let client = prefs.objectForKey("clientencours") as! String
        
        let q6:NSString = qu6.text!
        let q7:NSString = qu7.text!
        let q8:NSString = qu8.text!
        let q9:NSString = qu9.text!
        let q10:NSString = qu10.text!
        let q11:NSString = qu11.text!
        let q12:NSString = qu12.text!
        let q13:NSString = qu13.text!
        let q14:NSString = qu14.text!
        let q15:NSString = qu15.text!
        let q16:NSString = qu16.text!
        let q17:NSString = qu17.text!
        
        var json = "{\"email\": \"" + client
        json = json + "\", \"6\": \"" + (q6 as String)
        json = json + "\", \"7\": \"" + (q7 as String)
        json = json + "\", \"8\": \"" + (q8 as String)
        json = json + "\", \"9\": \"" + (q9 as String)
        json = json + "\", \"10\": \"" + (q10 as String)
        json = json + "\", \"11\": \"" + (q11 as String)
        json = json + "\", \"12\": \"" + (q12 as String)
        json = json + "\", \"13\": \"" + (q13 as String)
        json = json + "\", \"14\": \"" + (q14 as String)
        json = json + "\", \"15\": \"" + (q15 as String)
        json = json + "\", \"16\": \"" + (q16 as String)
        json = json + "\", \"17\": \"" + (q17 as String) + "\"}"
        
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