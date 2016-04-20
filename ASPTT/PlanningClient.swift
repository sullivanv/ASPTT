//
//  PlanningClient.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 15/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class PlanningClient: UIViewController {
    

    @IBOutlet weak var my_heure: UILabel!
    
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
        
        let v_client = prefs.objectForKey("email") as! String!
        
        let json = "{\"email\": \"" + v_client + "\"}"
        
        let post:NSString = "json=\(json)"
        
        let url:NSURL = NSURL(string:"https://nodeapi-robotbobtm.c9users.io:8081/api/print_planning")!
        
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
                
                let obj = jsonData as NSDictionary
                
                for (key, value) in jsonData {
                    var stock_1 = (value as! NSArray)[0] as! String
                    var stock_2 = (value as! NSArray)[1] as! String
                    var stock_3 = (value as! NSArray)[2] as! String
                    var stock_4 = (value as! NSArray)[3] as! String
                    my_heure.text = "Date : " + stock_1 +
                    "\nHeure : " + stock_2 +
                    "\nTemps : " + stock_3 +
                    "\nCoach : " + stock_4
                    
                }
                
            }
            
        }
        
    }
    

    
}