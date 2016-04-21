//
//  CoachViewController.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 15/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class CoachViewController: UIViewController {
    
    
    @IBOutlet weak var nbrclient: UILabel!
    @IBOutlet weak var nbrsceance: UILabel!
    
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            MenuButton.target = self.revealViewController()
            MenuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            my_push()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func my_push() {
        
        let prefs = NSUserDefaults.standardUserDefaults()
        
        let coach = prefs.objectForKey("email") as! String!
        
        let json = "{\"coach\": \"" + coach + "\"}"
        
        let post:NSString = "json=\(json)"
        
        let url:NSURL = NSURL(string:"https://nodeapi-robotbobtm.c9users.io:8081/api/info_coach")!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        
        request.HTTPMethod = "POST"
        
        request.HTTPBody = postData
        
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
        
        if (urlData != nil) {
            
            let res = response as! NSHTTPURLResponse!;
            
            NSLog("Response code: %ld", res.statusCode);
            
            if (res.statusCode >= 200 && res.statusCode < 300)
                
            {
                
                var i = 0;
                
                var h = 0;
                
                let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                
                NSLog("Response ==> %@", responseData);
                
                let jsonData:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(urlData!, options:
                    
                    NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                
                

                    var stock_1 = jsonData.valueForKey("clients")
                    var stock_2 = jsonData.valueForKey("seances")
                var s1:NSInteger = (stock_1 as! NSInteger)
                var s2:NSInteger = (stock_2 as! NSInteger)
                var s3:NSString = ("\(s1)")
                var s4:NSString = ("\(s2)")
                print(s1)
                    nbrclient.text = "Vous avez " + ((s3) as String) + " clients"
                    nbrsceance.text = ((s4) as String) + " séances de prévues"
                    
                }
                
            }
            
        }
        
    }
    
    
    
