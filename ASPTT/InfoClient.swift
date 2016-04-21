//
//  InfoClient.swift
//  ASPTT
//
//  Created by Sullivan VITIELLO on 15/04/16.
//  Copyright © 2016 Sullivan VITIELLO. All rights reserved.
//

import Foundation

class InfoClient: UIViewController {
    
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBOutlet weak var img: UIImageView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            
            let prefs = NSUserDefaults.standardUserDefaults()
            let mail_client = prefs.objectForKey("email") as! String!
            var value_email:String = mail_client
            
            MenuButton.target = self.revealViewController()
            MenuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            img.image = generateQRImage(value_email, withSizeRate: 10)
            
            
            
            //let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
            
            /*
             
             var todaysDate:NSDate = NSDate()
             
             var dateFormatter:NSDateFormatter = NSDateFormatter()
             
             var dateFormatter_min:NSDateFormatter = NSDateFormatter()
             
             dateFormatter.dateFormat = "dd-MM-yyyy"
             
             
             
             dateFormatter_min.dateFormat = "HH:mm:ss"
             
             let today_minutes:String = dateFormatter.stringFromDate(todaysDate)
             
             let todayString:String = dateFormatter.stringFromDate(todaysDate)
             
             //print("fsdfs")
             
             print(todayString)
             
             print(today_minutes)*/
            
            }
            
    }
    
    
    
    func generateQRImage(stringQR:NSString, withSizeRate rate:CGFloat) -> UIImage
        
    {
        
        let filter:CIFilter = CIFilter(name:"CIQRCodeGenerator")!
        
        filter.setDefaults()
        
        let data:NSData = stringQR.dataUsingEncoding(NSUTF8StringEncoding)!
        
        filter.setValue(data, forKey: "inputMessage")
        
        let outputImg:CIImage = filter.outputImage!
        
        let context:CIContext = CIContext(options: nil)
        
        let cgimg:CGImageRef = context.createCGImage(outputImg, fromRect: outputImg.extent)
        
        var img:UIImage = UIImage(CGImage: cgimg, scale: 1.0, orientation: UIImageOrientation.Up)
        
        let width  = img.size.width * rate
        
        let height = img.size.height * rate
        
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        
        img.drawInRect(CGRectMake(0, 0, width, height))
        
        img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
        
    }
    
}