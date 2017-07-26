//
//  ViewControllerLogIn.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/14/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit

class ViewControllerLogIn: UIViewController {

    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var passW: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSUserDefaults.standardUserDefaults().dictionaryForKey("emailArr"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onClickLogin(sender: AnyObject) {
        let email = emailID.text;
        let password = passW.text;
        
//        let storedEmail = NSUserDefaults.standardUserDefaults().stringForKey("email");
//        let storedPassword = NSUserDefaults.standardUserDefaults().stringForKey("password");
//        
//        if (email == storedEmail && email != "") {
//            if (password == storedPassword) {
//                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLoggedIn");
//                NSUserDefaults.standardUserDefaults().synchronize();
//                
//                let myViewController:ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController;
//                
//                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                appDelegate.window?.rootViewController=myViewController
//                
//                appDelegate.window?.makeKeyAndVisible()
//                
//                //self.dismissViewControllerAnimated(true, completion: nil);
//            } else {
//                throwError("Password is incorrect");
//            }
//        } else {
//            throwError("Email is invalid");
//        }
        let arr = NSUserDefaults.standardUserDefaults().dictionaryForKey("emailArr")
        if (arr == nil) {
            throwError("No Registered Users")
        }
        var bool = true
        for (e,p) in arr! {
            if (email == e as! String) {
                bool = false
                if (password == p as! String) {
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLoggedIn");
                    NSUserDefaults.standardUserDefaults().synchronize();
                    
                    let myViewController:ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController;
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController=myViewController
                
                    appDelegate.window?.makeKeyAndVisible()
                } else {
                    throwError("Password is incorrect")
                }
            }
        }
        if (bool) {
            throwError("E-Mail is invalid")
        }
        
        
    }

    //error throwing function
    func throwError(userMessage:String) {
        var alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        alert.addAction(Action);
        self.presentViewController(alert, animated: true, completion: nil);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
